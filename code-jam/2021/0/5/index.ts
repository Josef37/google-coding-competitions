import { createInterface as createReadlineInterface } from "readline";

export const readline = createReadlineInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

const sum = (array: number[]): number =>
  array.reduce((accumulator, value) => accumulator + value, 0);

const main = () => {
  let t,
    p,
    lineCount = -2;
  let playerResults: number[][] = [];

  readline.on("line", (line) => {
    if (lineCount === -2) {
      t = Number(line);
    } else if (lineCount === -1) {
      p = Number(line);
    } else {
      playerResults.push(line.split("").map(Number));

      if (lineCount % 100 === 99) {
        const result = solve(playerResults);
        console.log(`Case #${(lineCount + 1) / 100}: ${result}`);
        playerResults = [];
      }
    }

    lineCount += 1;
  });
};

const solve = (playerResults: number[][]): number => {
  const playerWinRates = playerResults.map(
    (result) => sum(result) / result.length
  );
  const questionResults = transpose(playerResults);
  const questionLossRates = questionResults.map(
    (result) => 1 - sum(result) / result.length
  );

  const playerSkillLevels = playerWinRates.map(skillLevelFromWinRate);
  const questionDifficulties = questionLossRates.map(skillLevelFromWinRate);

  const divergence = playerResults.map((result, playerIndex) => {
    const skillLevel = playerSkillLevels[playerIndex];

    return sum(
      result.map((outcome, questionIndex) => {
        const questionDifficutly = questionDifficulties[questionIndex];
        const expectedOutcome = sigmoid(skillLevel - questionDifficutly);
        return Math.abs(outcome - expectedOutcome);
      })
    );
  });

  return maxIndex(divergence);
};

const transpose = (array: number[][]) =>
  array[0].map((_, colIndex) => array.map((row) => row[colIndex]));

const probabilityForSkillGap = (gap: number) =>
  Math.max(0, -(1 / 36) * Math.abs(gap) + 1 / 6);

const sigmoid = (x: number) => 1 / (1 + Math.exp(-x));

const sigmoidIntegral = (x: number) => Math.log(Math.exp(x) + 1);

// Assuming question difficutly is evenly distributed
const skillLevelFromWinRate = (rate: number) =>
  Math.log(
    (Math.exp(3) * (Math.exp(6 * rate) - 1)) /
      (Math.exp(6) - Math.exp(6 * rate))
  );

const winRateFromSkillLevel = (skillLevel: number) =>
  (1 / 6) * (sigmoidIntegral(skillLevel + 3) - sigmoidIntegral(skillLevel - 3));

const maxIndex = (array: number[]) => {
  let currentMaxIndex = 0;

  for (let index = 0; index < array.length; index++) {
    const element = array[index];

    if (element > array[currentMaxIndex]) {
      currentMaxIndex = index;
    }
  }

  return currentMaxIndex;
};

main();
