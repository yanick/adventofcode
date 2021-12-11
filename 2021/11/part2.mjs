import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

const allFlashed = grid => grid.every(
        row => row.every( x => x === 0 )
    );

export function solution(grid) {
    let step = 0;

    while(true) {
        step++;
        p1.playTurn(grid);
        if( allFlashed(grid) ) return step;
    }
}
