import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (file) => fs.readFile(file,'utf8').then(
    content => content.split("\n").filter(x=>x).map(
        line => line.split('')
    )
);

export const closing = {
    '{':'}',
    '<': ">",
    '(': ')',
    '[': ']',
};

function firstIllegalCharacter(line) {
    const stack = [];

    for ( const c of line ) {
        if( closing[c] ) {
            stack.push(closing[c]);
        } else {
            if(c !== stack.pop())  return c;
        }
    }

    return '';

}

export function solution(lines) {
    const points = {
        ')': 3,
        ']': 57,
        '}': 1197,
        '>': 25137,
    }

    return _.sum(
        lines.map( firstIllegalCharacter ).map(
            c => points[c] || 0
        )
    )
}
