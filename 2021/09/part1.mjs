import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (filename) => fs.readFile(filename,'utf8').then(
    content => content.split("\n").filter(x=>x).map(
        lines => lines.split('').map(x => parseInt(x))
    )
);

export const genNeighbours = (maxX,maxY) => (x,y) =>
    [ [-1,0], [1,0], [0,1], [0,-1] ].map(
        delta => _.zip(delta,[x,y]).map(_.sum)
    ).filter( ([x,y]) => {
        if(x<0 || y<0 ) return false;
        if( x>= maxX || y>= maxY ) return false;
        return true;
    } );

export const genCoords = grid => ([x,y]) => grid[x][y];

export function solution(grid) {
    const seen = grid.map( () => [] );
    let risk = 0;

    const neighbours = genNeighbours(grid.length,grid[0].length);
    const coords = genCoords(grid);

    for( const x of _.range(grid.length) ) {
        for( const y of _.range(grid[x].length) ) {
            if( seen[x][y] ) continue;

            let lowest = true;
            for( const n of neighbours(x,y) ) {
                if( coords(n) > grid[x][y] ) {
                    seen[n[0]][n[1]] = true;
                } else if ( coords(n) == grid[x][y] ) {
                    seen[n[0]][n[1]] = true;
                    lowest = false;
                } else {
                    lowest = false;
                }
            }

            if(lowest) {
                risk += 1 + grid[x][y];
            }
            seen[x][y] = true;

        }
    }

    return risk;
}
