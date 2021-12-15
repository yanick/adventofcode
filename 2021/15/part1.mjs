import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";
import Heap from 'heap';

export const processInput = (input) => fs.readFile(input,'utf8').then(
    content => content.split("\n").filter(x=>x).map(
        line => line.split('').map( x => parseInt(x) )
    )
);

export const genNeighbours = (maxX,maxY) => ([x,y]) =>
    [
        [1,0], [0,1],[-1,0],  [0,-1]
].map(
        delta => _.zip(delta,[x,y]).map(_.sum)
    ).filter( ([x,y]) => {
        if(x<0 || y<0 ) return false;
        if( x>= maxX || y>= maxY ) return false;
        return true;
    } );

export function solution(grid) {

    const lowest = grid.map( () => grid[0].map(()=>9E9) );

    const neighbors = genNeighbours(grid.length, grid[0].length);

    const scouts = new Heap((a,b) => a.risk - b.risk);
    scouts.push( {pos: [0,0], risk: 0 } );

    let destinationRisk = () => _.last(_.last(lowest)) || 9E9;

    while(scouts.size()) {
        const {pos,risk} = scouts.pop();

        for( const [x,y] of neighbors(pos) ) {

            if( lowest[x][y] <= risk + grid[x][y] ) continue;

            if( destinationRisk() <= risk + grid[x][y]  ) continue;

            lowest[x][y] = risk + grid[x][y];

            scouts.push({pos:[x,y], risk: lowest[x][y]} );
        }
    }

    return _.last( _.last(lowest) );
}
