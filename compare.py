import re
import sys
from pathlib import Path


SOURCE_FUNCTION_RE = re.compile(r"([A-Za-z0-9_./]+\.c):([A-Za-z0-9_]+)")

# Names (and order) of the 9 metrics Callgrind reports, and which of them
# get shown as columns in the output table.
METRIC_NAMES = [
    "Instructions",
    "Data reads",
    "Data writes",
    "L1 I-cache misses",
    "L1 D-cache misses",
    "L1 D-cache write misses",
    "LL I-cache misses",
    "LL D-cache misses",
    "LL D-cache write misses",
]
DISPLAYED_METRICS = METRIC_NAMES[:6]


def extract_callgrind_metrics(filename, target_source=None):
    '''
    Parse a callgrind_annotate output file and return a dict with
    'source', 'function', and one entry per name in METRIC_NAMES.
    Returns None (after printing an error) if parsing fails.
    '''
    path = Path(filename)
    if not path.exists():
        print(f"Error: file not found: {filename}")
        return None

    lines = path.read_text(errors="replace").splitlines()

    # Find the Callgrind event header
    header_index = None
    for i, line in enumerate(lines):
        if (
            line.strip().startswith("Ir")
            and "Dr" in line
            and "Dw" in line
            and "D1mr" in line
        ):
            header_index = i
            break

    if header_index is None:
        print(f"Error: Could not find Callgrind event header in {filename}.")
        return None

    function_line = None
    other_cordic_sources = set()

    for line in lines[header_index + 1:]:
        if "Auto-annotated source:" in line:
            break

        if "PROGRAM TOTALS" in line:
            continue

        match = SOURCE_FUNCTION_RE.search(line)
        if not match:
            continue

        source = Path(match.group(1)).name
        function = match.group(2)

        if target_source:
            # Exact filename match: unambiguous regardless of table order.
            if source == target_source:
                function_line = line
                break
        else:
            # Fallback heuristic: skip main() and other system/library files.
            if source.startswith("cordic_") and function != "main":
                function_line = line
                break
            if source.startswith("cordic_"):
                other_cordic_sources.add(source)

    if function_line is None:
        if target_source:
            print(f"Error: Could not find '{target_source}' in {filename}.")
        else:
            print(f"Error: Could not find the CORDIC function in {filename}.")
        return None

    match = SOURCE_FUNCTION_RE.search(function_line)
    source = Path(match.group(1)).name
    function = match.group(2)

    # Warn if there were other cordic_*.c candidates, since auto-detection
    # picked one based on table order (highest Ir first) rather than an
    # explicit request. Pass ":source_file.c" in the argument to silence
    # this and guarantee the intended function is analyzed.
    if not target_source and other_cordic_sources:
        others = ", ".join(sorted(other_cordic_sources))
        print(f"Warning ({filename}): multiple cordic_*.c sources found ({others}); "
              f"picked '{source}' by table order.")

    parts = function_line.split()

    # ---------------------------------------------------------
    # Extract the first 9 Callgrind metrics.
    #
    # Ir Dr Dw I1mr D1mr D1mw ILmr DLmr DLmw
    # ---------------------------------------------------------
    values = []
    for part in parts:
        # Stop when we reach source:function
        if ".c:" in part:
            break

        # "." means zero/unavailable in Callgrind
        if part == ".":
            values.append(0)
            continue

        # Ignore percentages
        if "%" in part:
            continue

        # Remove commas and parse numbers
        cleaned = part.replace(",", "")
        if re.fullmatch(r"\d+", cleaned):
            values.append(int(cleaned))

        # Stop once we have all 9 metrics
        if len(values) == 9:
            break

    if len(values) != 9:
        print(f"Error: Could not extract all 9 Callgrind metrics from {filename}.")
        print(f"Extracted values: {values}")
        return None

    metrics = {"source": source, "function": function}
    metrics.update(zip(METRIC_NAMES, values))
    return metrics


def print_markdown_table(rows):
    columns = ["Version", "Function"] + DISPLAYED_METRICS

    def row_cells(row):
        return [row["source"], row["function"]] + [str(row[m]) for m in DISPLAYED_METRICS]

    table = [row_cells(row) for row in rows]
    widths = [max(len(columns[i]), *(len(r[i]) for r in table)) for i in range(len(columns))]

    def format_row(cells):
        return "| " + " | ".join(cell.ljust(widths[i]) for i, cell in enumerate(cells)) + " |"

    print(format_row(columns))
    print("|" + "|".join("-" * (w + 2) for w in widths) + "|")
    for row in table:
        print(format_row(row))


def parse_file_arg(arg):
    '''
    Splits "path/to/file.txt:source_file.c" into (path, source_file.c).
    Only treats the last ":" as a separator if what follows ends in ".c",
    so this stays safe on Windows paths like "C:\\path\\file.txt".
    '''
    idx = arg.rfind(":")
    if idx != -1 and arg[idx + 1:].endswith(".c"):
        return arg[:idx], arg[idx + 1:]
    return arg, None


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python compare.py <callgrind-output.txt>[:source_file.c] [more files...]")
        sys.exit(1)

    rows = []
    for arg in sys.argv[1:]:
        filename, target = parse_file_arg(arg)
        metrics = extract_callgrind_metrics(filename, target)
        if metrics is not None:
            rows.append(metrics)

    if not rows:
        sys.exit(1)

    print()
    print_markdown_table(rows)
