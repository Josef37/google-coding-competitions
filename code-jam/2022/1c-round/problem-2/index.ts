import { sum } from "lodash-es";
import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  n?: number;
  k?: number;
}

const main = () => {
  let caseNumber = 1;
  const input: Input = {};

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else if (input.n === undefined) {
        [input.n, input.k] = line.split(" ").map(Number);
      } else {
        const elements = line.split(" ").map(Number);

        const solution = solve(elements, input.k ?? 0);

        console.log(`Case #${caseNumber}: ${solution}`);

        input.n = undefined;
        input.k = undefined;
        caseNumber += 1;
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const lookup = {};

interface State {
  s: number;
  d: number;
  zs: number[];
}

const solve = (es: number[], k: number) => {
  let s = sum(es);
  const sumSquared = s ** 2;
  const squareSum = sum(es.map((e) => e ** 2));
  let d = squareSum - sumSquared;

  if (d % 2 !== 0) return "IMPOSSIBLE";

  if (k === 1) {
    if (s === 0) return d === 0 ? "0" : "IMPOSSIBLE";
    if (d % (2 * s) !== 0) return "IMPOSSIBLE";

    const z = d / (2 * s);

    return [z].join(" ");
  }

  const z1 = -s + 1;
  d -= 2 * s * z1;
  s += z1;

  const z2 = d / 2 / s;
  d -= 2 * s * z2;
  s += z2;

  return [z1, z2].join(" ");

  // const openStates: State[] = [{ s, d, zs: [] }];

  // while (openStates.length > 0) {
  //   const state = openStates.shift();
  // }

  // const additionalNumbers = [];
  // do {
  //   const newNumber = s === 0 ? 0 : Math.round(d / 2 / s);
  //   console.log(newNumber);
  //   additionalNumbers.push(newNumber);
  //   d -= 2 * s * newNumber;
  //   s += newNumber;
  // } while (d !== 0 && additionalNumbers.length < k);

  // if (d !== 0) return "IMPOSSIBLE";

  // return additionalNumbers;
};

main();
