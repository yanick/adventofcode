// https://adventofcode.com/2021/day/09

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample = p1.processInput("sample");
const input = p1.processInput("input");

tap.test("part1", async (t) => {
    t.match(p1.genNeighbours(10,10)(0,0), [
        [1,0],[0,1]
]);
    t.equal(p1.solution(await sample), 15);
    t.equal(p1.solution(await input), 550);
});

tap.test("part2", async (t) => {
    /* t.equal(p2.solution(await sample, 256), 26984457539); */
    /* t.equal(p2.solution(await input, 256), 1622533344325); */
});
