const { resolve } = require("path");

module.exports = (env) => ({
  // mode: "none",
  entry: env.entry,
  output: {
    filename: "main.js",
    path: env.outputPath || resolve(__dirname, "dist"),
  },
  target: "node",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [".ts", ".js"],
  },
});
