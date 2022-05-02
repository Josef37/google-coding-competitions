import { groupBy, partition } from "lodash-es";
import { createInterface } from "readline";

const readNumbers = (line: string) => line.split(" ").map(Number);

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
        const towers = line.split(" ");

        const solution = solve(towers);

        console.log(`Case #${caseNumber}: ${solution}`);

        input.n = undefined;
        caseNumber += 1;
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (words: string[]) => {
  const [oneCharWords, mixedWords] = partition(words, (word) =>
    [...word].every((char) => char === word[0])
  );

  const groupedOneCharWords = groupBy(oneCharWords, (word) => word[0]);
  const groupedByStart = groupBy(mixedWords, (word) => word[0]);
  const groupedByEnd = groupBy(mixedWords, (word) => word[word.length - 1]);

  const hasDuplicateStart = Object.values(groupedByStart).some(
    (bucket) => bucket.length > 1
  );
  const hasDuplicateEnd = Object.values(groupedByEnd).some(
    (bucket) => bucket.length > 1
  );
  if (hasDuplicateStart || hasDuplicateEnd) {
    return "IMPOSSIBLE";
  }

  const takeMixedWord = (word: string) => {
    const start = word[0];
    const end = word[word.length - 1];

    const head = (groupedOneCharWords[start] ?? []).join("");
    const tail = (groupedOneCharWords[end] ?? []).join("");

    delete groupedByStart[start];
    delete groupedByEnd[end];
    delete groupedOneCharWords[start];
    delete groupedOneCharWords[end];

    return head + word + tail;
  };

  const getNextMixedWord = (): string | undefined => {
    return Object.values(groupedByStart)?.[0]?.[0];
  };

  let wordParts: string[] = [];

  while (true) {
    const nextMixedWord = getNextMixedWord();
    if (nextMixedWord === undefined) break;
    wordParts.unshift(takeMixedWord(nextMixedWord));

    while (true) {
      const start = wordParts[0][0];
      const nextWord = groupedByEnd[start]?.[0];
      if (nextWord === undefined) break;
      wordParts[0] = takeMixedWord(nextWord) + wordParts[0];
    }

    while (true) {
      const end = wordParts[0][wordParts[0].length - 1];
      const nextWord = groupedByStart[end]?.[0];
      if (nextWord === undefined) break;
      wordParts[0] = wordParts[0] + takeMixedWord(nextWord);
    }
  }

  const word =
    wordParts.join("") +
    Object.values(groupedOneCharWords)
      .map((bucket) => bucket.join(""))
      .join("");

  let currentChar = word[0];
  const usedChars = new Set();

  for (const char of word) {
    if (char !== currentChar && usedChars.has(char)) {
      return "IMPOSSIBLE";
    }
    currentChar = char;
    usedChars.add(char);
  }

  return word;
};

main();
