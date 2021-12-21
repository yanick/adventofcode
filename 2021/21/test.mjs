// https://adventofcode.com/2021/day/21

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample = p1.processInput('sample');
const input = p1.processInput('input');

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample),739785 );
    t.equal(p1.solution(await input), 916083);
});

tap.test("part2", async (t) => {
    t.equal(p2.solution(await p1.processInput('sample')), 444356092776315);
    t.equal(p2.solution(await p1.processInput('input')), 49982165861983);
});
