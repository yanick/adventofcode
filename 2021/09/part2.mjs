import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

function getBasinSize( [x,y], grid, seen ) {
    if( seen[x][y] ) return 0;

    seen[x][y] = true;

    if( grid[x][y] == 9 ) return 0;
    let size = 1;

    const neighbours = p1.genNeighbours(grid.length,grid[0].length);
    const coords = p1.genCoords(grid);

    neighbours(x,y).map( n => getBasinSize(n,grid,seen) ).forEach(
        x => size+=x
    );

    return size;
}

export function solution(grid) {
    const seen = grid.map( () => [] );
    let basinSizes = [];


    for( const x of _.range(grid.length) ) {
        for( const y of _.range(grid[x].length) ) {
            if( seen[x][y] ) continue;

            if( grid[x][y] == 9 ) {
                seen[x][y] = true;
                continue;
            }
            basinSizes.push( getBasinSize([x,y],grid,seen));
        }
    }

    basinSizes.sort( (a,b) => a < b ? 1 : -1 );
    return basinSizes.splice(0,3).reduce( (a,b) => a*b ) ;
}
