import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

import * as p1 from "./part1.mjs";

export function solution(graph) {
    let paths = 0;

    graph.forEachNode((node) => {
        graph.setNodeAttribute(node, "nbrVisits", 0);
    });

    const left = [{ graph, where: "start" }];

    while (left.length > 0) {
        const position = left.shift();

        if (position.where === "end") {
            paths++;
            continue;
        }

        const canVisit = (graph, node) => {
            if (node === "start") return false;
            if (node === node.toUpperCase()) return true;
            const nbrVisits = graph.getNodeAttribute(node, "nbrVisits");

            if (nbrVisits === 0) return true;
            if (nbrVisits > 1) return false;
            return !graph.hasAttribute("revisited");
        };

        for (const n of position.graph
            .neighbors(position.where)
            .filter((n) => canVisit(position.graph, n))) {
            let newGraph = position.graph;

            if (n === n.toLowerCase()) {
                newGraph = newGraph.copy();
                newGraph.updateNodeAttribute(
                    n,
                    "nbrVisits",
                    fp.add(1)
                );

                if (newGraph.getNodeAttribute(n, "nbrVisits") === 2) {
                    newGraph.setAttribute("revisited", n);
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
