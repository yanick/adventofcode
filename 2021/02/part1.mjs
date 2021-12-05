import fp from "lodash/fp.js";

export const solution = fp.flow([
    fp.groupBy(0),
    fp.mapValues(fp.map(fp.get(1))),
    fp.mapValues(fp.sum),
    ({ forward, up, down }) => forward * (down - up),
]);
