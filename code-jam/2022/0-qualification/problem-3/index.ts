import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  n?: number;
}

const main = () => {
  let caseNumber = 1;
  const input: Input = {};

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else if (input.n === undefined) {
        input.n = Number(line);
      } else {
        const sides = line.split(" ").map(Number);

        const solution = solve(sides);

        console.log(`Case #${caseNumber}: ${solution}`);

        caseNumber += 1;
        input.n = undefined;
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (dice: number[]) => {
  const sortedDice = dice.sort((a, b) => b - a);

  let diceToPick = sortedDice[0];

  for (let index = 1; index < sortedDice.length; index++) {
    const die = sortedDice[index];

    diceToPick = Math.min(diceToPick - 1, die);

    if (diceToPick === 0) {
      return index;
    }
  }

  return dice.length;
};

main();
