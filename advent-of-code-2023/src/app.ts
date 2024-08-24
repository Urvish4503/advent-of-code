import Fastify from "fastify";
import day01 from "./solutions/day01.js";
import day02 from "./solutions/day02.js";

const fastify = Fastify();


fastify.get('/', async (request, reply) => {
  return { hello: 'world' }
})

fastify.register(day01)
fastify.register(day02)

const start = async () => {
  try {
    await fastify.listen({ port: 3000, host: '0.0.0.0' })
  } catch (err) {
    fastify.log.error(err)
    process.exit(1)
  }
}
start()
