## 通过lua实现原子操作

### 令牌桶实现

```lua
local ratelimit_info=redis.pcall("HMGET",KEYS[1],"last_mill_second","curr_permits","max_burst","rate","app")
local last_mill_second=ratelimit_info[1]
local curr_permits=tonumber(ratelimit_info[2])
local max_burst=tonumber(ratelimit_info[3])
local rate=tonumber(ratelimit_info[4])
local app=tostring(ratelimit_info[5])
if app == nil then
    return 0
end

local local_curr_permits=max_burst;

if(type(last_mill_second) ~='boolean' and last_mill_second ~=nil) then
    local reverse_permits=math.floor((ARGV[2]-last_mill_second)/1000)*rate
    if(reverse_permits>0) then
        redis.pcall("HMSET",KEYS[1],"last_mill_second",ARGV[2])
    end

    local expect_curr_permits=reverse_permits+curr_permits
    local_curr_permits=math.min(expect_curr_permits,max_burst);

else
    redis.pcall("HMSET",KEYS[1],"last_mill_second",ARGV[2])
end

local result=-1
if(local_curr_permits-ARGV[1]>0) then
    result=1
    redis.pcall("HMSET",KEYS[1],"curr_permits",local_curr_permits-ARGV[1])
else
    redis.pcall("HMSET",KEYS[1],"curr_permits",local_curr_permits)
end

return result
```

### 初始化参数

```lua
local result=1
redis.pcall("HMSET",KEYS[1],
        "last_mill_second",ARGV[1],
        "curr_permits",ARGV[2],
        "max_burst",ARGV[3],
        "rate",ARGV[4],
        "app",ARGV[5])
return result
```

### 代码调用

```java
// 获取脚本
DefaultRedisScript redisScript = new DefaultRedisScript();
        redisScript.setLocation(new ClassPathResource("ratelimit.lua"));
        redisScript.setResultType(java.lang.Long.class);
// 执行脚本获取令牌
Long currMillSecond = stringRedisTemplate.execute(
                (RedisCallback<Long>) redisConnection -> redisConnection.time()
        );
Long accquire = stringRedisTemplate.execute(redisScript,                Collections.singletonList("key"), permits.toString(), currMillSecond.toString());
```

