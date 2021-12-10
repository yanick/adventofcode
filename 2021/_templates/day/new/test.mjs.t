---
to: '<%= day %>/test.mjs'
---
// https://adventofcode.com/2021/day/<%= day %>

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample = p1.processInput('sample');
const input = p1.processInput('input');

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample), 0);
//    t.equal(p1.solution(await input), 0);
});

tap.test("part2", async (t) => {
    // t.equal(p2.solution(await sample), 0);
    // t.equal(p2.solution(await input), 0);
});
