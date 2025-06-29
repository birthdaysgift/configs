import argparse
import fileinput

import prettytable


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--separator", default=",")
    args = parser.parse_args()

    lines = []
    for line in fileinput.input(files=[]):
        lines.append(line.strip("\n").split(args.separator))

    header = lines[0]
    table = prettytable.PrettyTable(field_names=header)
    table.add_rows(lines[1:])

    print(table)


if __name__ == "__main__":
    main()
