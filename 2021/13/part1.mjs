import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (input) => fs.readFile(input,'utf8').then(
    content => {
        let [ coords, instructions ] = content.split("\n\n");

        let grid = [];

        for( const [y,x] of coords.split("\n").map(line => line.split(",").map( x => parseInt(x) )) ) {
            if(!grid[x]) grid[x] = [];
            grid[x][y] = true;
        }

        grid = [...grid];
        grid = grid.map( x => x? [...x]:[] );

        instructions = instructions.split("\n").filter(x=>x).map( line => line.match(/([xy])=(\d+)/) )
        .map( ([_,direction,level]) => ([direction,parseInt(level)]) );

        return {
            grid,
            instructions,
        }

    }
);

export function foldGrid(grid,direction,level) {
    if(direction === 'x') {
        for( const row of grid ) {
            if(!row) continue;
            const folded = row.splice(level);
            folded.forEach((v,i) => {
                if(i===0) return;
                if(!v) return;
                row[level-i] = v;
            })
        }

        return grid;
    }

    const folded = grid.splice(level);
    folded.forEach((v,i) => {
        if(i===0) return;
        if(!v) return;
        grid[level-i] =
            _.range(_.max([grid[level-i].length,folded[i].length])).
                map( j => grid[level-i][j] || folded[i][j] );
    })

    return grid;
}

export function printGrid(grid) {
    return grid.map( line =>
        (line||[]).map( x => x ? '#':'.' ).join('')
     ).join("\n");
}

export function solution({grid, instructions}) {

    foldGrid(grid,...instructions.shift());

    return _.sum(grid.flat());


}
