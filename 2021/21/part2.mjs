import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from "./part1.mjs";

const cartesianProduct = (...rest) =>
    rest.reduce(
        (a, b) => a.flatMap((x) => b.map((y) => x.concat([y]))),
        [[]]
    );

const dimensions = cartesianProduct(
    _.range(1, 4),
    _.range(1, 4),
    _.range(1, 4)
).map(fp.sum);

function resolveGame(p1, p2, s1, s2, f) {
    let wins = 0;
    let loses = 0;

    dimensions.forEach((points) => {
        const newPosition = (p1 + points) % 10;
        const newScore = newPosition + 1 + s1;
        if (newScore >= 21) {
            wins++;
            return;
        }
        const next = f(p2, newPosition, s2, newScore, f);
        wins += next[1];
        loses += next[0];
    });

    return [wins, loses];
}

export function solution(positions) {
    const res = _.memoize(resolveGame, (...args) => args.join("-"));

    return Math.max(...res(...positions, 0, 0, res));
}
