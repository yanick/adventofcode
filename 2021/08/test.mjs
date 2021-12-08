// https://adventofcode.com/2021/day/08

import tap from "tap";
import fs from "fs-extra";

import * as p1 from "./part1.mjs";
import * as p2 from "./part2.mjs";

const sample0 = fs.readFile("sample0", "utf8").then(p1.processInput);
const sample = fs.readFile("sample", "utf8").then(p1.processInput);
const input = fs.readFile("input", "utf8").then(p1.processInput);

tap.test("part1", async (t) => {
    t.equal(p1.solution(await sample), 26);
    t.equal(p1.solution(await input), 26);
});

tap.test("part2", async (t) => {
    const [ s0 ] = await sample0;
    t.match(
        p2.findMapping([...s0.input,...s0.output]), {
            d: 'a',
            e: 'b',
            a: 'c',
            f: 'd',
            g: 'e',
            b: 'f',
            c: 'g',
        }
    );
    t.match(p2.decodedOutput(s0),5353);
    t.equal(p2.solution(await sample), 61229);
    t.equal(p2.solution(await input), 1019355);
});
