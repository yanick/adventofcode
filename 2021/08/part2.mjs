import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from "./part1.mjs";

function decodedDigits(mapping) {
    const s = fp.invert(mapping);

    return _.flow([
        fp.invert,
        fp.mapKeys((k) =>
            k
                .split("")
                .map((l) => s[l])
                .join("")
        ),
        fp.mapKeys((k) => k.split("").sort().join("")),
    ])(p1.digits);
}

function guess(unknowns, guessed = {}, inputs) {
    const [next] = Object.keys(unknowns);

    if (!next) return guessed;

    for (const p of unknowns[next]) {
        let newUnknowns = fp.mapValues(
            (s) => s.filter((x) => x !== p),
            fp.omit(next, unknowns)
        );

        if (Object.values(newUnknowns).some((s) => s.size === 0)) continue;

        const r = guess(newUnknowns, { ...guessed, [next]: p }, inputs);

        if (!r) continue;

        const solution = decodedDigits(r);

        if (inputs.every((i) => solution.hasOwnProperty(i.join(""))))
            return r;
    }
}

export function findMapping(input) {
    const values = "abcdefg".split("");

    let possibility = Object.fromEntries(values.map((v) => [v, values]));

    for (const seq of input) {
        const p = Object.values(p1.digits)
            .filter((d) => d.length === seq.length)
            .join("")
            .split("");

        for (const l of seq) {
            possibility[l] = _.intersection(possibility[l], p);
        }
    }

    // feel cute, might delete later
    const one = input.find((i) => i.length === 2);
    const seven = input.find((i) => i.length === 3);
    const [a] = seven.filter((x) => !one.includes(x));

    possibility = fp.mapValues(fp.reject("a"), possibility);

    possibility[a] = ["a"];

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
