// https://adventofcode.com/2021/day/11

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";


tap.test("part1", async (t) => {
    const sample = p1.processInput('sample');
    const input = p1.processInput('input');

    t.equal(p1.solution(await sample), 1656);
    t.equal(p1.solution(await input), 1729);
});

tap.test("part2", async (t) => {
    const sample = await p1.processInput('sample');
    const input = await p1.processInput('input');
    t.equal(p2.solution(sample), 195);
    t.equal(p2.solution(input), 237);
});
