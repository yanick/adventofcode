import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import Graph from 'graphology';



export const processInput = (filename) => fs.readFile(filename,'utf8').then(
    content => content.split("\n").filter(x=>x)
).then(
    lines => {
        const graph = new Graph();
        lines.map( line => line.split('-') ).forEach( edge =>
            graph.mergeEdge(...edge) );
        return graph;
    }

);

export function solution(graph) {
    let paths = 0;
    const left = [
        { graph, where: 'start' }
    ];

    while( left.length > 0 ) {
        const position = left.shift();

        if( position.where === 'end' ) {
            paths++;
            continue;
        }

        let newGraph = position.graph;
        if( position.where === position.where.toLowerCase()  ) {
            newGraph = position.graph.copy();
            newGraph.dropNode(position.where);
        }

        for( const n of position.graph.neighbors(position.where) ) {
            left.unshift({
                graph: newGraph,
                where: n,
            });
        }

    }

    return paths;
}
