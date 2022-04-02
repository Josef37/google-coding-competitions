import { createInterface } from "readline";
import { shuffle, sum, random } from "lodash-es";

const readline = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

const main = () => {
  let caseNumber = 1;
  let t: number;
  let isSolving = false;
  let onAnswer: (line: string) => void;

  readline
    .on("line", (line) => {
      if (line === "-1") {
        process.exit(1);
      } else if (t === undefined) {
        t = Number(line);
      } else if (!isSolving) {
        const [n, k] = line.split(" ").map(Number);

        isSolving = true;

        const onComplete = () => {
          isSolving = false;

          caseNumber += 1;

          if (caseNumber > t) {
            readline.close();
          }
        };

        onAnswer = solveByTeleporting(n, k, onComplete);
      } else {
        onAnswer(line);
      }
    })
    .on("close", () => {
      process.exit(0);
    });
};

const config = {
  walkLength: 100,
};

type Walk = Array<{ node: number; degree: number }>;

const weightedNumberOfIntersections = (walk1: Walk, walk2: Walk) => {
  let result = 0;
  for (const e1 of walk1) {
    for (const e2 of walk2) {
      if (e1.node === e2.node) {
        result += 1 / e1.degree;
      }
    }
  }
  return result;
};

const estimateEdges = (walkPairs: Array<[Walk, Walk]>) => {
  const K = walkPairs.length;
  const t = walkPairs[0][0].length - 1;

  const weights = walkPairs.map((walks) =>
    weightedNumberOfIntersections(...walks)
  );

  const estimate = t ** 2 / ((2 / K) * sum(weights));
  return Math.round(estimate);
};

const solveByRandomWalks = (n: number, k: number, onComplete: () => void) => {
  let inputCount = 0;
  const walkPairs: Array<[Walk, Walk]> = [];
  let currentWalkPair: Walk[] = [];
  let currentWalk: Walk = [];

  return (line: string) => {
    const [node, degree] = line.split(" ").map(Number);
    inputCount += 1;

    currentWalk.push({ node, degree });

    if (currentWalk.length > config.walkLength) {
      currentWalkPair.push(currentWalk);
      if (currentWalkPair.length === 2) {
        walkPairs.push(currentWalkPair as [Walk, Walk]);
        currentWalkPair = [];
      }
      currentWalk = [];
    }

    if (inputCount <= k) {
      if (currentWalk.length === 0) {
        if (currentWalkPair.length === 1) {
          const startingNode = currentWalkPair[0][0].node;
          console.log(`T ${startingNode}`);
        } else {
          const randomNode = random(1, n);
          console.log(`T ${randomNode}`);
        }
      } else {
        console.log(`W`);
      }
    } else {
      console.log(`E ${estimateEdges(walkPairs)}`);

      onComplete();
    }
  };
};

const solveByTeleporting = (
  n: number,
  actualK: number,
  onComplete: () => void
) => {
  const k = Math.min(n, actualK);

  const roomsToVisit = shuffle(Array.from(Array(n), (_, i) => i + 1));

  let inputCount = 0;
  let totalPassageCount = 0;

  return (line: string) => {
    const [room, passageCount] = line.split(" ").map(Number);
    inputCount += 1;

    totalPassageCount += passageCount;

    if (inputCount <= k) {
      const nextRoom = roomsToVisit[inputCount - 1];

      console.log(`T ${nextRoom}`);
    } else {
      const fractionOfExploredRooms = inputCount / n;
      const estimatedPassageCount = Math.round(
        (0.5 * totalPassageCount) / fractionOfExploredRooms
      );

      console.log(`E ${estimatedPassageCount}`);

      onComplete();
    }
  };
};

main();
