import { createInterface as createReadlineInterface } from "readline";

export const readline = createReadlineInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});
