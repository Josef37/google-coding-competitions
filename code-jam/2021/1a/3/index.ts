import { createInterface } from "readline";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

interface Input {
  t?: number;
  n?: number;
  q?: number;
  as: string[];
  ss: number[];
}

const main = () => {
  let caseNumber = 1;
  const input: Input = { as: [], ss: [] };

  readline
    .on("line", (line) => {
      if (input.t === undefined) {
        input.t = Number(line);
      } else if (input.n === undefined) {
        [input.n, input.q] = line.split(" ").map(Number);
      } else {
        const [answer, score] = line.split(" ");
        input.as.push(answer);
        input.ss.push(Number(score));

        if (input.as.length === input.n) {
          const { bestAnswer, expectedScore } = solve(input.as, input.ss);

          console.log(`Case #${caseNumber}: ${bestAnswer} ${expectedScore}/1`);

          caseNumber += 1;
          input.n = undefined;
          input.as = [];
          input.ss = [];
        }
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const solve = (
  answers: string[],
  scores: number[]
): { bestAnswer: string; expectedScore: number } => {
  if (scores.length === 1) {
    const [answer] = answers;
    const [score] = scores;

    const questions = answer.length;

    if (score > questions / 2) {
      return {
        bestAnswer: answer,
        expectedScore: score,
      };
    } else {
      return {
        bestAnswer: invert(answer),
        expectedScore: questions - score,
      };
    }
  }
  if (scores.length === 2) {
    const [a1, a2] = answers;
    const [s1, s2] = scores;
    const q = a1.length;

    // const bestAnswer = [];
    const betterAnswer = s1 > s2 ? a1 : a2;
    const bestAnswer = betterAnswer.split("");

    const questionsWithSameAnswer = [];
    // const questionsWithDifferentAnswer = [];

    for (let i = 0; i < q; i++) {
      if (a1[i] === a2[i]) {
        questionsWithSameAnswer.push(i);
      }
      // else {
      //   questionsWithDifferentAnswer.push(i);
      // }
    }

    // const betterAnswer = s1 > s2 ? a1 : a2
    // for (const i of questionsWithDifferentAnswer) {
    // bestAnswer[i] = betterAnswer[i]
    // }

    const numberOfQuestionsWithDifferentAnswer =
      q - questionsWithSameAnswer.length;
    const remainingScoreForSameAnswer =
      (s1 + s2 - numberOfQuestionsWithDifferentAnswer) / 2;

    const shouldCopy =
      remainingScoreForSameAnswer > questionsWithSameAnswer.length / 2;

    for (const i of questionsWithSameAnswer) {
      bestAnswer[i] = shouldCopy ? a1[i] : invert(a1[i]);
    }

    const expectedScore = shouldCopy
      ? Math.max(s1, s2)
      : Math.max(
          remainingScoreForSameAnswer,
          questionsWithSameAnswer.length - remainingScoreForSameAnswer
        ) +
        (numberOfQuestionsWithDifferentAnswer + Math.abs(s1 - s2)) / 2;
    return { bestAnswer: bestAnswer.join(""), expectedScore };
  }

  throw new Error("Too many students");
};

const invert = (answer: string) =>
  mapString(answer, (char) => (char === "T" ? "F" : "T"));

const answerToNumber = (answer: string) =>
  mapString(answer, (char) => (char === "T" ? "1" : "0"));

const numberToAnswer = (number: string) =>
  mapString(number, (char) => (char === "1" ? "T" : "F"));

const mapString = (string: string, cb: (char: string) => string) =>
  string.split("").map(cb).join("");

main();
