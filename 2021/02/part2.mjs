import fp from "lodash/fp.js";
import u from "updeep";

const update = (action, value) =>
    action === "down" ? u({ aim: fp.add(value) })
   : action === "up"  ? u({ aim: fp.add(-value) })
   : u((state) =>
       u({ x: fp.add(value), depth: fp.add(value * state.aim) }, state)
     );

export function solution(lines) {
    const { x, depth } = lines.reduce(
        (accum, line) => update(...line)(accum),
        { depth: 0, aim: 0, x: 0 }
    );

    return x * depth;
}
