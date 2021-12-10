// https://adventofcode.com/2021/day/10

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample = p1.processInput('sample');
const input = p1.processInput('input');

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample), 26397);
    t.equal(p1.solution(await input), 311949);
});

tap.test("part2", async (t) => {
    t.match(p2.linesScore(await sample), [
        288957, 5566, 1480781, 995444, 294
    ]);
    t.equal(p2.solution(await sample), 288957);
    t.equal(p2.solution(await input), 3042730309);
});
