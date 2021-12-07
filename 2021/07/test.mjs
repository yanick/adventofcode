// https://adventofcode.com/2021/day/07

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample = p1.processInput("16,1,2,0,4,2,7,1,2,14");
const input = fs.readFile("input", "utf8").then(p1.processInput);

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample), 37);
    t.equal(p1.solution(await input), 340987);
});

tap.test("part2", async (t) => {
    t.equal(p2.solution(await sample), 168);
    t.equal(p2.solution(await input), 96987874);
});
