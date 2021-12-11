import fs from "fs-extra";
import fp from "lodash/fp.js";
import _ from "lodash";

export const processInput = (file) =>
    fs.readFile(file, "utf8").then((content) =>
        content
            .split("\n")
            .filter((x) => x)
            .map((line) => line.split("").map((x) => parseInt(x)))
    );

export const genNeighbours = (maxX, maxY) => (x, y) =>
    [
        [-1, 0],
        [1, 0],
        [0, 1],
        [0, -1],
        [1, 1],
        [-1, -1],
        [1, -1],
        [-1, 1],
    ]
        .map((delta) => _.zip(delta, [x, y]).map(_.sum))
        .filter(([x, y]) => {
            if (x < 0 || y < 0) return false;
            if (x >= maxX || y >= maxY) return false;
            return true;
        });

function powerUp(x, y, grid, toClear) {
    grid[x][y]++;

    if (grid[x][y] !== 10) return 0;

    // FLASH!
    toClear.push([x, y]);

    return _.sum([
        1,
        ...genNeighbours(grid.length, grid[0].length)(x, y).map((coords) =>
            powerUp(...coords, grid, toClear)
        ),
    ]);
}

export function playTurn(grid) {
    let flashes = 0;
    let toClear = [];

    for (const x in grid) {
        for (const y in grid[x]) {
            flashes += powerUp(parseInt(x), parseInt(y), grid, toClear);
        }
    }

    for (const [x, y] of toClear) {
        grid[x][y] = 0;
    }

    return flashes;
}

export const printGrid = (grid) =>
    grid.forEach((line) => console.log(line.join("")));

export const solution = (grid) =>
    _.sum(_.range(100).map(() => playTurn(grid)));
