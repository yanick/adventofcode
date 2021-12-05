import tap from "tap";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";


const sample = p1.processFile("sample");
const input = p1.processFile("input");

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample), 198);
    t.equal(p1.solution(await input), 3813416 );
});

tap.test("part2", async (t) => {
    t.equal(p2.solution(await sample), 230);
    t.equal(p2.solution(await input), 2990784);
});
