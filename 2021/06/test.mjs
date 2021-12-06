import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";

const sample = p1.processInput("3,4,3,1,2");
const input = fs.readFile("input", "utf8").then(p1.processInput);

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample, 18), 26);
    t.equal(p1.solution(await sample), 5934);
    t.equal(p1.solution(await input), 358214);
});

tap.test("part2", async (t) => {
    t.equal(p1.solution(await sample, 256), 26984457539);
    t.equal(p1.solution(await input, 256), 1622533344325);
});
