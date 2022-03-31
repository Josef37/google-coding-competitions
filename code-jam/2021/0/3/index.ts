import { readline } from "../utils/readline";

const main = () => {
  let lineCount = 0;

  readline.on("line", (line) => {
    if (lineCount > 0) {
      const [n, c] = line.split(" ").map(Number);

      const list = solve(n, c);
      const solution = list === undefined ? "IMPOSSIBLE" : list.join(" ");

      console.log(`Case #${lineCount}: ${solution}`);
    }

    lineCount += 1;
  });
};

const solve = (length: number, targetCost: number): number[] | undefined => {
  let currentCost = 0;

  const list = Array.from(Array(length), (v, i) => i + 1);

  for (let i = length - 2; i >= 0; i--) {
    const minimalRemainingCost = i;
    const costDifference = targetCost - currentCost;
    const maximumCost = Math.max(1, costDifference - minimalRemainingCost);
    const j = Math.min(length - 1, maximumCost + i - 1);

    currentCost += j - i + 1;
    reverseInPlace(list, i, j);
  }

  return currentCost !== targetCost ? undefined : list;
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
