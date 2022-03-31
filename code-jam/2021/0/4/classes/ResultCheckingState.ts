import { State } from "./State";
import { GameState } from "../index";

export class ResultCheckingState extends State {
  processLine(line: string) {
    if (line !== "1") {
      return GameState.Error;
    }

    if (this.listener.round === this.listener.input.t) {
      return GameState.Finished;
    }

    this.listener.startNewRound();
    return GameState.Ongoing;
  }

  start() {
    throw new Error("Can't start in result checking state.");
  }
}
