import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

function completionString(line) {
    const stack = [];

    for ( const c of line ) {
        if( p1.closing[c] ) {
            stack.unshift(p1.closing[c]);
        } else {
            if(c !== stack.shift())  return;
        }
    }

    return stack;

}

export function linesScore(lines) {
    lines = lines.map( completionString ).filter(x=>x);

    const points = {
        ')': 1,
        ']': 2,
        '}': 3,
        '>': 4,
    }

    const lineScore = line => line.reduce( (a,b) => 5*a + points[b], 0 );

    return lines.map(lineScore);
}

export function solution(lines) {

    const scores =linesScore(lines);

    scores.sort( (a,b) => a<b?-1:1 );

    return scores[ (scores.length-1) / 2  ];
}
