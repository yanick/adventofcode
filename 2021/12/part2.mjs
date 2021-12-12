import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from './part1.mjs';

export function solution(graph) {
    let paths = 0;

    graph.forEachNode( node => {
        graph.setNodeAttribute( node, 'nbrVisits', 0 )
    } );

    const left = [
        { graph, where: 'start' }
    ];

    while( left.length > 0 ) {
        const position = left.shift();

        if( position.where === 'end' ) {
            paths++;
            continue;
        }

        const canVisit = (graph,node) => {
            if(node === 'start') return false;
            if( node === node.toUpperCase() ) return true;
            const nbrVisits =graph.getNodeAttribute(node,'nbrVisits');

            if(nbrVisits ===0  ) return true;
            if(nbrVisits>1) return false;
            return !graph.hasAttribute('revisited');
        }

        for( const n of position.graph.neighbors(position.where) ) {
            if( !canVisit( position.graph, n ) ) continue;

            let newGraph = position.graph;

            if( n === n.toLowerCase() ) {
                newGraph = newGraph.copy();
                newGraph.setNodeAttribute(
                    n, 'nbrVisits', 1 + newGraph.getNodeAttribute(n,'nbrVisits')
                );


                if( newGraph.getNodeAttribute(n,'nbrVisits') === 2 ) {
                    newGraph.setAttribute('revisited',n);
                }

            }

            left.unshift({
                graph: newGraph,
                where: n,
            });
        }

    }

    return paths;
}
