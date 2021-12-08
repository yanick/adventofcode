import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const digits = {
    0: 'abcefg', // 6
    1: 'cf',     // 2
    2: 'acdeg',  // 5
    3: 'acdfg',  // 5
    4: 'bcdf',   // 4
    5: 'abdfg',  // 5
    6: 'abdefg', // 6
    7: 'acf',    // 3
    8: 'abcdefg',// 7
    9: 'abcdfg', // 6
}

export const processInput = (lines) => {
    return lines.split("\n").filter(x=>x).map( line => {
        let [ input, output ] = line.split(' | ').map(
            x => x.split(' ').map( x => x.split('').sort() )
        );

        return {input, output};
    }
    )
};

/** @return {number} */
export function solution(lines) {
    return lines.map(fp.get('output')).flat().filter(
        x => [2,4,3,7].includes(x.length )
    ).length
}
