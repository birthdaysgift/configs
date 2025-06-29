# Table

Simple CLI interface for `prettytable` python package


## Installation:

1. Go to current `table/` directory.

2. Install dependencies:

```bash
# create virtual env
python3.12 -m venv .venv

# activate virtual env
source .venv/bin/activate

# install requirements
python3 -m pip install -r requirements.txt
```

3. Check that `table` works:

```bash
echo -e "hello;world\nin;table" | table -s ';'
```
