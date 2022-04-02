import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
}

const main = () => {
  let caseNumber = 1;
  const input: Input = {};

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else {
        const [r, c] = line.split(" ").map(Number);

        const solution = solve(r, c);

        console.log(`Case #${caseNumber}:\n${solution}`);

        caseNumber += 1;
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (r: number, c: number) => {
  const seperatorRow = "+-".repeat(c) + "+";
  const valueRow = "|.".repeat(c) + "|";

  const lines = [seperatorRow];

  for (let row = 0; row < r; row++) {
    lines.push(valueRow, seperatorRow);
  }

  for (const row of [0, 1]) {
    lines[row] = ".." + lines[row].slice(2);
  }

  return lines.join("\n");
};

main();
