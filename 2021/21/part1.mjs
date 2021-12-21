import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (input) => fs.readFile(input,'utf8').then(
    content => content.split("\n").filter(x=>x).map(
        line => parseInt(line.split(": ")[1])-1
    )
);

export function solution(positions) {
    let scores = [0,0];
    let dice = 0;

    MAIN: while( Math.max(...scores) < 1000 ) {
        for( const player of [0,1] ) {
            let add = 0;
            _.range(3).forEach( () => {
                dice++;
                add+= dice;
            } );
            positions[player] = (positions[player] + add) % 10;
            scores[player] += 1 + positions[player]
            if(scores[player]>=1000) break MAIN;
        }
    }

    return Math.min(...scores) * dice;

}
