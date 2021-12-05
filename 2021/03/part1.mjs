import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processFile = async (f) =>
    fs
        .readFile(f, "utf8")
        .then((x) => x.split("\n").filter((x) => x))
        .then((lines) =>
            lines.map((l) => l.split("").map((x) => parseInt(x)))
        );

const mostCommon = (numbers) => (_.sum(numbers) * 2 > numbers.length ? 1 : 0);

export const toDecimal = (numbers) => numbers.reduce((a, x) => a * 2 + x, 0);

export const solution = (entries) => {
    const groups = _.zip(...entries).map(mostCommon);

    const gamma = toDecimal(groups);

    const epsilon = toDecimal(groups.map((x) => 1 - x));

    return gamma * epsilon;
};
