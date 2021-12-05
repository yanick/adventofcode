import fp from "lodash/fp.js";
import _ from "lodash";
import u from "updeep";

import { toDecimal } from "./part1.mjs";

function findNumber(entries, index, most) {
    // which number to filter on
    const mostSeen =
        _.sum(entries.map((e) => e[index])) * 2 >= entries.length ? 1 : 0;

    const filter = most ? mostSeen : 1 - mostSeen;

    const filtered = entries.filter((e) => e[index] === filter);

    if (filtered.length === 1) return filtered[0];

    return findNumber(filtered, index + 1, most);
}

export const solution = (entries) => {
    const oxyGenerator = toDecimal(findNumber(entries, 0, true));

    const scrubber = toDecimal(findNumber(entries, 0, false));

    return oxyGenerator * scrubber;
};
