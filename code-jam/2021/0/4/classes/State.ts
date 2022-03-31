import { Listener } from "./Listener";
import { GameState } from "../index";

export abstract class State {
  constructor(public listener: Listener) {}
  abstract processLine(line: string): GameState;
  abstract start(): void;
}
