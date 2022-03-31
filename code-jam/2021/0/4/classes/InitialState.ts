import { State } from "./State";
import { GameState } from "../index";

export class InitialState extends State {
  processLine(line: string) {
    const [t, n, q] = line.split(" ").map(Number);

    this.listener.setInputValues({ t, n });
    this.listener.startNewRound();

    return GameState.Ongoing;
  }

  start(): void {
    throw new Error("Can't start in initial state.");
  }
}
