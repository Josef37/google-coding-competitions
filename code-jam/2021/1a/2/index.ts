import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  m?: number;
  ns: [number, number][];
}

const main = () => {
  let caseNumber = 1;
  const input: Input = { ns: [] };

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else if (input.m === undefined) {
        input.m = Number(line);
      } else {
        const [prime, count] = line.split(" ").map(Number);
        input.ns.push([prime, count]);

        if (input.ns.length === input.m) {
          const solution = solve(new Map(input.ns));

          console.log(`Case #${caseNumber}: ${solution}`);

          caseNumber += 1;
          input.m = undefined;
          input.ns = [];
        }
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (primes: Map<number, number>): number => {
  let primeSum = 0;
  primes.forEach((count, prime) => {
    primeSum += count * prime;
  });

  return solveRecursive(primeSum, 1, 0, primes);
};

const solveRecursive = (
  sum: number,
  product: number,
  lastUsedPrime: number,
  availablePrimes: Map<number, number>
) => {
  if (sum === product) return sum;
  if (sum < product) return 0;

  let result = 0;

  const sortedAvailablePrimes = Array.from(availablePrimes.keys())
    .filter((prime) => prime >= lastUsedPrime)
    .sort((a, b) => a - b);

  for (const prime of sortedAvailablePrimes) {
    take(prime, availablePrimes);

    result = Math.max(
      result,
      solveRecursive(sum - prime, product * prime, prime, availablePrimes)
    );

    add(prime, availablePrimes);
  }

  return result;
};

const add = (prime: number, primes: Map<number, number>) => {
  const primeCount = primes.get(prime);

  if (primeCount) {
    primes.set(prime, 1 + primeCount);
  } else {
    primes.set(prime, 1);
  }
};

const take = (prime: number, primes: Map<number, number>) => {
  const primeCount = primes.get(prime);

  if (!primeCount) {
    throw new Error("Prime not found");
  }

  if (primeCount === 1) {
    primes.delete(prime);
  } else {
    primes.set(prime, primeCount - 1);
  }
};

main();
