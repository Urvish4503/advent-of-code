import Fastify from "fastify";
import day01 from "./solutions/day01.js";
const fastify = Fastify({
// logger: true,
});
fastify.get('/', async (request, reply) => {
    return { hello: 'world' };
});
fastify.register(day01);
const start = async () => {
    try {
        await fastify.listen({ port: 3000, host: '0.0.0.0' });
    }
    catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};
start();
