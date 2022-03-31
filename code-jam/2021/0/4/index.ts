import { readline } from "../utils/readline";
import { Listener } from "./classes/Listener";

export interface Input {
  t: number;
  n: number;
}

export enum Order {
  Less = "Less",
  Greater = "Greater",
}

export const reverseOrder = (order: Order) =>
  ({
    [Order.Less]: Order.Greater,
    [Order.Greater]: Order.Less,
  }[order]);

export enum GameState {
  Ongoing = "Ongoing",
  Error = "Error",
  Finished = "Finished",
}

const main = () => {
  const listener = new Listener(console.log);

  readline.on("line", (line) => {
    const gameState = listener.handleLine(line);

    switch (gameState) {
      case GameState.Error:
        process.exit(1);
        break;
      case GameState.Finished:
        process.exit(0);
        break;
    }
  });
};

main();
