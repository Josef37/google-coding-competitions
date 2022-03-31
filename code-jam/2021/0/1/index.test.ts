const {
  testables: { reverseInPlace, solve },
} = require(".");

describe("reverseInPlace", () => {
  test("simple case", () => {
    const array = [1, 2, 3];

    reverseInPlace(array, 0, 2);

    expect(array).toEqual([3, 2, 1]);
  });

  test("complex case", () => {
    const array = [1, 2, 3, 4, 5];

    reverseInPlace(array, 1, 3);

    expect(array).toEqual([1, 4, 3, 2, 5]);
  });
});

describe("solve", () => {
  test("simple case", () => {
    expect(solve([4, 2, 1, 3])).toEqual(6);
  });
});
