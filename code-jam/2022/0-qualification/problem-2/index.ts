import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  levels: number[][];
}

const main = () => {
  let caseNumber = 1;
  const input: Input = { levels: [] };

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else {
        input.levels.push(line.split(" ").map(Number));

        if (input.levels.length === 3) {
          const solution = solve(input.levels);

          console.log(`Case #${caseNumber}: ${solution}`);

          caseNumber += 1;
          input.levels = [];
        }
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (levels: number[][]) => {
  let remaining = 10 ** 6;
  const outputLevels = [];

  for (let color = 0; color < levels[0].length; color++) {
    const minLevel = Math.min(...levels.map((printer) => printer[color]));
    const usedLevel = Math.min(minLevel, remaining);
    outputLevels.push(usedLevel);
    remaining -= usedLevel;
  }

  if (remaining > 0) {
    return "IMPOSSIBLE";
  } else {
    return outputLevels.join(" ");
  }
};

main();
