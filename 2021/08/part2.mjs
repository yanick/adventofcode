import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from "./part1.mjs";

function decodedDigits(mapping) {
    const s = fp.invert(mapping);
    let solution = fp.invert(p1.digits);
    solution = fp.mapKeys(
        (k) =>
            k
                .split("")
                .map((l) => s[l])
                .join(""),
        solution
    );

    solution = fp.mapKeys((k) => {
        k = k.split("").sort().join("");
        return k;
    }, solution);

    return solution;
}

function guess(unknowns, guessed = {}, inputs) {
    const [next] = Object.keys(unknowns);

    if (!next) return guessed;

    if (unknowns[next].size === 0) return;

    for (const p of unknowns[next].values()) {
        let newUnknowns = fp.omit(next, unknowns);
        newUnknowns = fp.mapValues((s) => {
            const x = new Set(s.values());
            x.delete(p);
            return x;
        }, newUnknowns);

        if (Object.values(newUnknowns).some((s) => s.size === 0)) continue;

        const r = guess(newUnknowns, { ...guessed, [next]: p }, inputs);

        if (r) {
            const solution = decodedDigits(r);

            if (inputs.every((i) => solution.hasOwnProperty(i.join("")))) {
                return r;
            }
        }
    }
}

export function findMapping(input) {
    const values = "abcdefg".split("");

    const possibility = Object.fromEntries(
        values.map((v) => [v, new Set(values)])
    );

    for (const seq of input) {
        const p = Object.values(p1.digits)
            .filter((d) => d.length === seq.length)
            .join("")
            .split("");

        for (const l of seq) {
            possibility[l] = new Set(p.filter((x) => possibility[l].has(x)));
        }
    }

    const one = input.find((i) => i.length === 2);
    const seven = input.find((i) => i.length === 3);
    const [a] = seven.filter((x) => !one.includes(x));

    for (const l of Object.values(possibility)) {
        l.delete("a");
    }

    possibility[a] = new Set(["a"]);

    return guess(possibility, {}, input);
}

export function decodedOutput({ input, output }) {
    const mapping = findMapping([...input, ...output]);

    const digits = decodedDigits(mapping);

    return parseInt(output.map((e) => digits[e.join("")]).join(""));
}

export function solution(input) {
    return _.sum(input.map(decodedOutput));
}
