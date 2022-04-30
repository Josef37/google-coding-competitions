# Code Jam 2022

This year we're trying TypeScript.  
We compile it to JavaScript ourselves because Google uses some weird settings making it impossible to use external libraries.

## Commands

Build with entry `index.ts` in the current directory. Output to `main.js` in the same directory.

```
function build {
  npm run build -- --env entry="$(realpath ./index.ts)" --env outputPath="$(pwd)"
  xclip -selection clipboard < ./main.js
}
```
