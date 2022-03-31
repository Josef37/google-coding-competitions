import assert from "assert";
import { range, orderBy } from "lodash-es";
import { Listener } from "./Listener";
import { State } from "./State";
import { Order, reverseOrder, GameState } from "../index";
import { ResultCheckingState } from "./ResultCheckingState";

export class SolvingState extends State {
  order: (Order | undefined)[][];
  query: number[];

  constructor(listener: Listener) {
    super(listener);

    // We work with numbers 0, 1, ... , n-1 and transform the input
    const n = this.listener.input.n;
    this.order = Array.from(Array(n), () => Array(n).fill(undefined));
    this.setOrder(0, Order.Less, 1); // assume x0 < x1

    this.query = this.generateNewQuery();
  }

  setOrder(x1: number, order: Order, x2: number) {
    assert(
      this.getOrder(x1, x2) !== reverseOrder(order) &&
        this.getOrder(x2, x1) !== order,
      `Cannot override existing order ${JSON.stringify({ x1, order, x2 })}`
    );

    this.order[x1][x2] = order;
    this.order[x2][x1] = reverseOrder(order);
  }

  getOrder(x1: number, x2: number) {
    return this.order[x1][x2];
  }

  generateTransitiveOrders(affectedNumbers: number[]) {
    const newAffectedNumbers = new Set<number>();
    const addNewAffectedNumbers = (...numbers: number[]) => {
      numbers.forEach((number) => newAffectedNumbers.add(number));
    };

    for (const x1 of affectedNumbers) {
      for (const x2 of affectedNumbers) {
        if (x1 >= x2) continue;
        const x1_order_x2 = this.getOrder(x1, x2);
        if (!x1_order_x2) continue;

        for (let x = 0; x < this.order.length; x++) {
          if (
            this.getOrder(x, x1) === x1_order_x2 &&
            this.getOrder(x, x2) !== x1_order_x2
          ) {
            addNewAffectedNumbers(x, x1, x2);
            this.setOrder(x, x1_order_x2, x2);
          }
          if (
            x1_order_x2 === this.getOrder(x2, x) &&
            this.getOrder(x1, x) !== x1_order_x2
          ) {
            addNewAffectedNumbers(x, x1, x2);
            this.setOrder(x1, x1_order_x2, x);
          }
        }
      }
    }

    if (newAffectedNumbers.size > 0)
      this.generateTransitiveOrders(Array.from(newAffectedNumbers.values()));
  }

  allOrdersKnown() {
    for (let i = 0; i < this.order.length; i++) {
      const row = this.order[i];
      for (let j = 0; j < row.length; j++) {
        if (i === j) continue;

        const element = row[j];
        if (element === undefined) {
          return false;
        }
      }
    }

    return true;
  }

  print(numbers: number[]) {
    const message = numbers.map((x) => x + 1).join(" ");
    this.listener.callback(message);
  }

  calculateGuess() {
    return orderBy(
      range(this.order.length),
      (number) =>
        this.order[number].filter((order) => order === Order.Greater).length
    );
  }

  generateNewQuery() {
    const n = this.order.length;

    for (let i = 0; i < n; i++) {
      for (let j = i + 1; i < n; i++) {
        const i_order_j = this.getOrder(i, j);
        if (i_order_j === undefined) continue;

        for (let k = 0; k < n; k++) {
          if (k === i || k === j) continue;

          if (this.getOrder(i, k) === undefined) {
            return [...(i_order_j === Order.Less ? [i, j] : [j, i]), k];
          }
        }
      }
    }

    throw new Error("unable to generate a new query");
  }

  processLine(line: string) {
    const x = Number(line) - 1;

    assert(
      this.getOrder(this.query[0], this.query[1]) === Order.Less,
      "We assume query[0] to be less than query[1]"
    );

    switch (x) {
      case this.query[0]:
        this.setOrder(this.query[2], Order.Less, this.query[0]);
        this.setOrder(this.query[2], Order.Less, this.query[1]);
        break;
      case this.query[1]:
        this.setOrder(this.query[0], Order.Less, this.query[2]);
        this.setOrder(this.query[1], Order.Less, this.query[2]);
        break;
      case this.query[2]:
        this.setOrder(this.query[0], Order.Less, this.query[2]);
        this.setOrder(this.query[2], Order.Less, this.query[1]);
        break;
      default:
        throw new Error(`Invalid line ${line}`);
    }

    this.generateTransitiveOrders(this.query);

    if (this.allOrdersKnown()) {
      const guess = this.calculateGuess();
      this.print(guess);
      this.listener.changeState(new ResultCheckingState(this.listener));
    } else {
      this.query = this.generateNewQuery();
      this.print(this.query);
    }

    return GameState.Ongoing;
  }

  start() {
    this.print(this.query);
  }
}
