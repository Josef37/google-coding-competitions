import { Input, GameState } from "../index";
import { SolvingState } from "./SolvingState";
import { InitialState } from "./InitialState";
import { State } from "./State";

export class Listener {
  state: State;
  input: Input = {
    t: 0,
    n: 0,
  };
  round = 0;
  gameState = GameState.Ongoing;

  constructor(public callback: (message: string) => void) {
    this.state = new InitialState(this);
  }

  changeState(state: State) {
    this.state = state;
  }

  handleLine(line: string): GameState {
    if (this.gameState !== GameState.Ongoing) {
      return this.gameState;
    }
    this.gameState =
      line === "-1" ? GameState.Error : this.state.processLine(line);
    return this.gameState;
  }

  setInputValues(input: Input) {
    this.input = input;
  }

  startNewRound() {
    this.round += 1;
    if (this.round > this.input.t) {
      throw new Error("Cannot start another round");
    }
    this.changeState(new SolvingState(this));
    this.state.start();
  }
}
