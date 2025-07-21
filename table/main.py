import argparse
import csv
import fileinput
import io
import itertools

import prettytable


def main():
    args = parse_args()
    text = read_input()

    if text.startswith("+") or args.csv:
        to_csv(text, args.separator)
        return

    print(to_table(text, args.separator))


def to_table(text, separator):
    with io.StringIO(text) as f:
        reader = csv.reader(f, delimiter=separator)
        rows = list(reader)

    table = prettytable.PrettyTable(field_names=rows[0])
    table.add_rows(rows[1:])
    return table


def to_csv(text, separator):
    rows = text.split("\n")

    header = rows[:3]
    header_border = header[0]
    plus_positions = [index for (index, char) in enumerate(header_border) if char == "+"]

    cleaned_data = []

    cell_positions = list(itertools.pairwise(plus_positions))
    for row in [header[1]] + rows[3:-2]:
        cleaned_row = []
        for start, end in cell_positions:
            cleaned_row.append(row[start+1:end].strip(" "))
        cleaned_data.append(cleaned_row)

    with io.StringIO() as f:
        writer = csv.writer(f, delimiter=separator, lineterminator="\n")
        for row in cleaned_data:
            writer.writerow(row)
        print(f.getvalue().rstrip("\n"))


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--separator", default=",")
    parser.add_argument("--csv", action="store_true")
    return parser.parse_args()


def read_input():
    lines = []
    for line in fileinput.input(files=[]):
        lines.append(line)
    return "".join(lines)


if __name__ == "__main__":
    main()
