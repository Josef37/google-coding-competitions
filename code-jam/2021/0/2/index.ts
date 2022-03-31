import { readline } from "../utils/readline";

const main = () => {
  let lineCount = 0;

  readline.on("line", (line) => {
    if (lineCount > 0) {
      const [x, y, s] = line.split(" ");

      const solution = solve(Number(x), Number(y), s);

      console.log(`Case #${lineCount}: ${solution}`);
    }

    lineCount += 1;
  });
};

const solve = (x: number, y: number, input: string) => {
  let lastChar;
  let cost = 0;

  for (const char of input) {
    if (char !== "?") {
      if (lastChar && char !== lastChar) {
        cost += char === "J" ? x : y;
      }

      lastChar = char;
    }
  }

  return cost;
};

main();
