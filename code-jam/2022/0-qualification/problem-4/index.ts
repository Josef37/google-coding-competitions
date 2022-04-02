import { min } from "lodash-es";
import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  n?: number;
  funs?: number[];
  pointers?: (number | undefined)[];
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
      } else if (input.funs === undefined) {
        input.funs = [0, ...line.split(" ").map(Number)];
      } else {
        input.pointers = [undefined, ...line.split(" ").map(Number)];

        const solution = solve(input.funs, input.pointers);

        console.log(`Case #${caseNumber}: ${solution}`);

        caseNumber += 1;
        input.n = undefined;
        input.funs = undefined;
        input.pointers = undefined;
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (funs: number[], pointers: (number | undefined)[]) => {
  const reversePointers: number[][] = Array.from(
    Array(pointers.length),
    () => []
  );

  for (let index = 0; index < pointers.length; index++) {
    const pointer = pointers[index];
    if (pointer === undefined) continue;

    reversePointers[pointer] = [...reversePointers[pointer], index];
  }

  const solveRecursive = (
    node = 0
  ): { totalFun: number; currentFun: number } => {
    const reversePointersAtNode = reversePointers[node];

    if (reversePointersAtNode.length === 0) {
      return {
        totalFun: funs[node],
        currentFun: funs[node],
      };
    }

    const recursiveResults = reversePointersAtNode.map(solveRecursive);

    let totalFun = recursiveResults.reduce(
      (sum, result) => sum + result.totalFun,
      0
    );
    let minFun = recursiveResults.reduce(
      (min, result) => Math.min(min, result.currentFun),
      Infinity
    );

    const nodeFun = funs[node];
    const currentFun = Math.max(minFun, nodeFun);
    const improvement = currentFun - minFun;

    return {
      totalFun: totalFun + improvement,
      currentFun,
    };
  };

  const { totalFun } = solveRecursive();

  return totalFun;
};

main();
