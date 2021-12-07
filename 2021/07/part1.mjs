import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (input) => input.split(',').map( x => parseInt(x) );

export function solution(input) {
    const min = _.min(input);
    const max = _.max(input);

    let minScore = 9E99;

    for( let i = min; i<= max; i++ ) {
        const score = _.sum(input.map( x => Math.abs( x - i ) ));
        if( score >= minScore ) break;
        minScore = score;
    }

    return minScore;
}
