import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

const main = () => {
  let lineIndex = 0;
  let t;

  readline
    .on("line", (line) => {
      if (lineIndex === 0) {
        t = Number(line);
      } else if (lineIndex % 2 === 0) {
        const numbers = line.split(" ");

        const solution = solve(numbers);

        const caseNumber = lineIndex / 2;
        console.log(`Case #${caseNumber}: ${solution}`);
      }

      lineIndex += 1;
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (numbers: string[]): number => {
  let numberOfCorrections = 0;

  for (let index = 1; index < numbers.length; index++) {
    const previous = numbers[index - 1];
    const current = numbers[index];

    const { newNumber, corrections } = getNextBiggestNumberWithSameStart(
      previous,
      current
    );

    numberOfCorrections += corrections;
    numbers[index] = newNumber;
  }

  return numberOfCorrections;
};

const getNextBiggestNumberWithSameStart = (compare: string, start: string) => {
  if (
    compare.length < start.length ||
    (compare.length === start.length && compare < start)
  ) {
    return {
      corrections: 0,
      newNumber: start,
    };
  }

  const compareStart = compare.slice(0, start.length);

  if (compareStart < start) {
    return {
      corrections: compare.length - start.length,
      newNumber: start.padEnd(compare.length, "0"),
    };
  } else if (compareStart > start) {
    return {
      corrections: 1 + compare.length - start.length,
      newNumber: start.padEnd(compare.length + 1, "0"),
    };
  } else if (compare === start) {
    return {
      corrections: 1,
      newNumber: start + "0",
    };
  } else {
    const endsWithNines = compare
      .slice(start.length)
      .split("")
      .every((char) => char === "9");

    if (endsWithNines) {
      return {
        newNumber: start.padEnd(compare.length + 1, "0"),
        corrections: 1 + compare.length - start.length,
      };
    } else {
      return {
        newNumber: (BigInt(compare) + BigInt(1)).toString(),
        corrections: compare.length - start.length,
      };
    }
  }
};

main();
