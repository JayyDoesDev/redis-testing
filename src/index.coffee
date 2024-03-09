{ Redis } = require "ioredis"

redis = new Redis 
    host: "localhost"
    port: 6379

redis.set "stupidkey", "value"

someFunctionWithRedis = (key, callback) -> 
    redisKey = await exists key
    unless redisKey is 1
        if not callback
            throw Error "Callback required."
        else
            data = 
                key: key
                value: await redis.get key
            callback(data)
    else 
        console.log "Can't find key."

exists = (key) ->
    if await redis.exists key
        return true
    else 
        return false

console.log someFunctionWithRedis "stupidkey", (data) -> console.log "Key: #{data.key} Value: #{data.value}" 