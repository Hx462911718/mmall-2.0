package com.mmall.common;

import com.mmall.utils.PropertiesUtil;
import redis.clients.jedis.*;
import redis.clients.util.Hashing;
import redis.clients.util.Sharded;

import java.util.Arrays;
import java.util.List;

/**
 * 分片redis
 * @author hexin
 * @createDate 2018年08月10日 15:37:00
 */
public class RedisShardPool {
    private static ShardedJedisPool pool;//jedis 连接池
    private static Integer maxTotal = Integer.parseInt(PropertiesUtil.getProperty("redis.max.total", "20"));//最大连接数
    private static Integer maxIdle = Integer.parseInt(PropertiesUtil.getProperty("redis.max.idle", "10"));
    ; //最大空闲状态数
    private static Integer minIdle = Integer.parseInt(PropertiesUtil.getProperty("redis.min.idle", "2"));
    ;//最小空闲状态数
    private static Boolean testOneBorrow = Boolean.parseBoolean(PropertiesUtil.getProperty("redis.test.borrow", "true"));
    ;//在borrow一个jedis实例的时候，是否要进行验证操作，如果为true,则得到的jedis的实例是可以用
    private static Boolean testOneRetrun = Boolean.parseBoolean(PropertiesUtil.getProperty("redis.test.return", "true"));
    ;//在return一个jedis实例的时候，是否要进行验证操作，如果为true,则放回jedispool的jedis的实例是可以用
    private static String ip1 = PropertiesUtil.getProperty("redis1.ip");
    private static Integer port1 = Integer.parseInt(PropertiesUtil.getProperty("redis1.port"));
    private static String ip2 = PropertiesUtil.getProperty("redis2.ip");
    private static Integer port2 = Integer.parseInt(PropertiesUtil.getProperty("redis2.port"));

    private static void init() {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(maxTotal);
        config.setMaxIdle(maxIdle);
        config.setMaxIdle(minIdle);
        config.setTestOnBorrow(testOneBorrow);
        config.setTestOnReturn(testOneRetrun);
        config.setBlockWhenExhausted(true);//连接耗尽时，是否阻塞，false抛出异常，true阻塞到知道超时，默认为true
        JedisShardInfo info1 = new JedisShardInfo(ip1, port1, 1000 * 2);
        info1.setPassword("hexin");
        JedisShardInfo info2 = new JedisShardInfo(ip2, port2, 1000 * 2);
        info2.setPassword("hexin");
        List<JedisShardInfo> jedisShardInfos = Arrays.asList(info1, info2);
        //分片策略
        pool = new ShardedJedisPool(config, jedisShardInfos, Hashing.MURMUR_HASH, Sharded.DEFAULT_KEY_TAG_PATTERN);

    }

    static {
        init();
    }

    public static ShardedJedis getJedis() {
        return pool.getResource();
    }

    public static void returnResource(ShardedJedis jedis) {
        pool.returnResource(jedis);
    }

    public static void returnBrokenResource(ShardedJedis jedis) {
        pool.returnBrokenResource(jedis);
    }

    public static void main(String[] args) {
        ShardedJedis jedis = pool.getResource();
        for (int i = 0; i < 10; i++) {
            jedis.set("key"+i,"value--"+i);
        }
        returnResource(jedis);
       // pool.destroy();//临时调用


    }
}
