# Code Jam 2022

This year we're trying TypeScript.  
We compile it to JavaScript ourselves because Google uses some weird settings making it impossible to use external libraries.

## Commands

```bash
# Build with entry `index.ts` in the current directory. Output to `main.js` in the same directory.
function build {
  npm run build -- --env entry="$(realpath ./index.ts)" --env outputPath="$(pwd)"
  xclip -selection clipboard < ./main.js
}

# Test static input with `ts-node`.
function test_static {
  cat input.txt | node main.js
}

# Test interactive problem (make sure to have `interactive_runner.py` and `local_testing_tool.py` in working directory).
function test_interactive {
  python interactive_runner.py python local_testing_tool.py 1 -- node main.js
}
```
