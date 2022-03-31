import { Listener } from ".";

describe("Listener", () => {
  test("3 digit case", () => {
    const mockCallback = jest.fn();

    const listener = new Listener(mockCallback);
    listener.handleLine("1 3 600");

    expect(mockCallback).toHaveBeenNthCalledWith(1, "1 2 3");
    listener.handleLine("3");

    expect(mockCallback).toHaveBeenNthCalledWith(2, "1 3 2");
    listener.handleLine("1");

    expect(mockCallback).toHaveBeenCalledTimes(2);
  });

  test("4 digit case", () => {
    const mockCallback = jest.fn();

    const listener = new Listener(mockCallback);
    listener.handleLine("1 4 600");

    expect(mockCallback).toHaveBeenNthCalledWith(1, "1 2 3");
    listener.handleLine("3");

    expect(mockCallback).toHaveBeenNthCalledWith(2, "1 2 4");
    listener.handleLine("4");

    expect(mockCallback).toHaveBeenNthCalledWith(3, "3 2 4");
    listener.handleLine("4");

    expect(mockCallback).toHaveBeenNthCalledWith(4, "1 3 4 2");
    listener.handleLine("1");

    expect(mockCallback).toHaveBeenCalledTimes(4);
  });
});
