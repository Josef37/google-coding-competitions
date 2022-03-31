import { readline } from "../utils/readline";

const main = () => {
  let lineCount = 0;

  readline.on("line", (line) => {
    if (lineCount > 0 && lineCount % 2 === 0) {
      const testNumber = lineCount / 2;
      const list = line.split(" ").map(Number);

      const solution = solve(list);

      console.log(`Case #${testNumber}: ${solution}`);
    }

    lineCount += 1;
  });
};

const solve = (list: number[]) => {
  let cost = 0;

  for (let i = 0; i < list.length - 1; i++) {
    const j = minIndex(list, i);
    reverseInPlace(list, i, j);

    cost += j - i + 1;
  }

  return cost;
};

const reverseInPlace = (array: number[], start: number, end: number) => {
  for (let i = 0; i < (end - start) / 2; i++) {
    const temp = array[start + i];
    array[start + i] = array[end - i];
    array[end - i] = temp;
  }
};

const minIndex = (array: number[], start: number) => {
  let currentMinIndex = start;

  for (let index = start; index < array.length; index++) {
    const element = array[index];

    if (element < array[currentMinIndex]) {
      currentMinIndex = index;
    }
  }

  return currentMinIndex;
};

main();

export const testables = { solve, reverseInPlace, minIndex };
