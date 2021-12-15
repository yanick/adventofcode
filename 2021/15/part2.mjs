import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

export function solution(grid) {

    const massive = Array.from({
        length: 5 * grid.length }, ( ) => []
    );

    const wrap = x => x <= 9 ? x : (1+x % 10);

    for ( const magX of _.range(0,5) ) {
        for ( const magY of _.range(0,5) ) {
            for ( const x of _.range(grid.length) ) {
                for( const y of _.range(grid[0].length) ) {
                    massive[x + grid[0].length * magX][
                        y + grid.length * magY
                    ] = wrap( grid[x][y] + magX + magY )
                }
            }
        }
    }

    return p1.solution(massive);
}
