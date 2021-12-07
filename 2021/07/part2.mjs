import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

export function solution(input) {
    const min = _.min(input);
    const max = _.max(input);

    let minScore = 9E99;

    for( let i = min; i<= max; i++ ) {
        const score = _.sum(input.map( x =>  {
            const p = Math.abs( x - i );
            if (p==0) return 0;
            return p * (p+1) /2
        }));
        if( score >= minScore ) break;
        minScore = score;
    }

    return minScore;
}
