import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (input) =>
    input.split(',').map( x => parseInt(x) );

export function solution(input,days = 80) {
    let fish = Array.from({length:8}, ()=>0);
    input.forEach( x => fish[x]++ );

    for( let i = 0; i< days; i++ ) {
        const breeders = fish.shift();
        if(breeders ) {
            fish[8] = breeders;
            fish[6] = (fish[6] || 0)  + breeders;
        }
   //     console.log(fish);
    }

    return _.sum(fish);
};
