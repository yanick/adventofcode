import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from "./part1.mjs";

export function solution({ grid, instructions }) {
  instructions.forEach((i) => p1.foldGrid(grid, ...i));

  return p1.printGrid(grid);
}
