# Google Coding Competitions

Training for and attempting [Google's Coding Competitions](https://codingcompetitions.withgoogle.com) with my favorite scientific programming language: [**Julia**](https://julialang.org/)!

## Testing commands
* `cat test.in | julia solution.jl`
* `julia test.jl`
* `python interactive_runner.py python testing_tool.py 0 -- julia solution.jl` (with the provided `testing_tool.py`: for test set `i`, input number `i-1`)

## Construction Scripts
Folders can be constructed by running
`sh .scripts/scaffold.sh <path-to-round> <number-of-problems>`.

For example: `sh .scripts/scaffold.sh code-jam/2020/0 4`.

This creates 4 folders (1 to 4) and copies the files `.scripts/interactive_runner.py`, `.scripts/solution.jl` and `.scripts/test.jl` and creates an empty file called `test.in`.
