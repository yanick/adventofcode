import tap from "tap";
import fs from "fs-extra";

import * as part1 from "./part1.mjs";
import * as part2 from "./part2.mjs";

const processFile = async (f) =>
    fs
        .readFile(f, "utf8")
        .then((x) => x.split("\n"))
        .then((lines) => lines.map((l) => l.split(" ")))
        .then((lines) => lines.filter( ([action]) => action ).map((l) => [l[0], parseInt(l[1])]));

const sample = processFile("sample");
const input = processFile("input");

tap.test("part1", async (t) => {
    t.equal(part1.solution(await sample), 150);
    t.equal(part1.solution(await input), 2091984);
});

tap.test("part2", async (t) => {
    t.equal(part2.solution(await sample), 900);
    t.equal(part2.solution(await input), 2086261056);
});
