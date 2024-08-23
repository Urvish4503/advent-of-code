import fs from 'fs';
const getFirstAndLastNumber = function (input) {
    const numbers = input
        .split('')
        .map(Number)
        .filter((num) => !isNaN(num));
    return [numbers[0], numbers[numbers.length - 1]];
};
const combineNumbers = function (input) {
    return parseInt(`${input[0]}${input[1]}`);
};
const getFirstAndLastNumberOrWord = function (input) {
    const wordToNumber = {
        one: '1',
        two: '2',
        three: '3',
        four: '4',
        five: '5',
        six: '6',
        seven: '7',
        eight: '8',
        nine: '9',
    };
    const regex = /(?=(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine))/g;
    const matches = [...input.matchAll(regex)].map(match => match[1]);
    const numbers = matches.map((match) => wordToNumber[match] || match);
    return [numbers[0], numbers[numbers.length - 1]];
};
export default async function day01(fastify) {
    fastify.get('/01/1', async (request, reply) => {
        const data = fs.readFileSync('src/input/day01.txt', 'utf-8');
        return data
            .split('\n')
            .map(getFirstAndLastNumber)
            .map(combineNumbers)
            .reduce((acc, curr) => acc + curr, 0);
    });
    fastify.get('/01/2', async (request, reply) => {
        const data = fs.readFileSync('src/input/day01.txt', 'utf-8');
        return data
            .split('\n')
            .map(getFirstAndLastNumberOrWord)
            .map(combineNumbers)
            .reduce((acc, curr) => acc + curr, 0);
    });
}
