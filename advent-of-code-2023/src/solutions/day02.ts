import fs from 'fs';
import { FastifyInstance } from 'fastify';

type Game = {
  id: number;
  cubes: Cubes;
};

type Cubes = {
  red: number;
  green: number;
  blue: number;
}

const MAX_CUBES = {
  red: 12,
  green: 13,
  blue: 14,
};

const gameCubeCounter = function (input: string): Cubes {
  let cubes: Cubes = { red: 0, green: 0, blue: 0 };
  const colours = input.split(', ');
  
  for (const colour of colours) {
    const [value, key] = colour.split(' ');
    switch (key) {
      case 'red':
        cubes.red += parseInt(value);
        break;
      case 'green':
        cubes.green += parseInt(value);
        break;
      case 'blue':
        cubes.blue += parseInt(value);
        break;
    }
  }

  return cubes;
};

const gameParser = function (input: string): Game {
  const [gameInfo, diceInfo] = input.split(': ');
  const [_, id] = gameInfo.split(' ');

  const cubeCount = diceInfo
    .split('; ')
    .map(gameCubeCounter)
    .reduce(
      (max, current) => ({
        red: Math.max(max.red, current.red),
        green: Math.max(max.green, current.green),
        blue: Math.max(max.blue, current.blue),
      }),
      { red: 0, green: 0, blue: 0 },
    );

  return { id: parseInt(id), cubes: cubeCount };
};


function isGameValid(game: Game): boolean {
  return game.cubes.red <= MAX_CUBES.red && game.cubes.green <= MAX_CUBES.green && game.cubes.blue <= MAX_CUBES.blue;
}

function cubeMultiplier(cube: Game): number {
  return cube.cubes.red * cube.cubes.green * cube.cubes.blue;
}

export default async function day02(fastify: FastifyInstance): Promise<void> {
  fastify.get('/02/1', async (request, reply) => {
    reply.type('application/json').code(200);
    const input = fs.readFileSync('src/input/day02.txt', 'utf8');

    const result = input
      .split('\n')
      .map(gameParser)
      .reduce((sum, game) => isGameValid(game) ? sum + game.id : sum, 0);

    return { result };
  });
  fastify.get('/02/2', async (request, reply) => {
    reply.type('application/json').code(200);
    const input = fs.readFileSync('src/input/day02.txt', 'utf8');

    const result = input
      .split('\n')
      .map(gameParser)
      .reduce((sum, game) => cubeMultiplier(game) + sum, 0);

    
    return { result };
  })
}
