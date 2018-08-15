package com.mmall.utils;

import com.mmall.common.RedisShardPool;
import com.mmall.common.RedisShardPool;
import lombok.extern.slf4j.Slf4j;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ShardedJedis;

/**
 * @author hexin
 * @createDate 2018年08月08日 10:24:00
 */
@Slf4j
public class RedisShardPoolUtil {
 
    //重新设置这个key有效期
    public static Long expire(String key ,int expireTime){
        ShardedJedis jedis =null;
        Long result= null;
        try {
            jedis = RedisShardPool.getJedis();
            result = jedis.expire(key, expireTime);
        }catch (Exception e){
            log.error("expire key:{} expireTime:{} error:{}",key,expireTime,e);
            RedisShardPool.returnBrokenResource(jedis);
            return result;
        }
        RedisShardPool.returnResource(jedis);
        return result;
    }

    public static String set(String key ,String value){
        ShardedJedis jedis =null;
        String result= null;
        try {
            jedis = RedisShardPool.getJedis();
            result = jedis.set(key, value);
        }catch (Exception e){
            log.error("set key:{} value:{} error:{}",key,value,e);
            RedisShardPool.returnBrokenResource(jedis);
            return result;
        }
        RedisShardPool.returnResource(jedis);
        return result;
    }
    public static String setWithExpireTime( String key, String value, int expireTime) {
        ShardedJedis jedis =null;
        String result= null;
        try {
            jedis = RedisShardPool.getJedis();
            result = jedis.setex(key,expireTime,value);
        }catch (Exception e){
            log.error("setex key:{} expritTime:{} value:{} error:{}",key,expireTime,value,e);
            RedisShardPool.returnBrokenResource(jedis);
            return result;
        }
        RedisShardPool.returnResource(jedis);
        return result;
    }

    public static String get(String key) {
        ShardedJedis jedis =null;
        String result= null;
        try {
            jedis = RedisShardPool.getJedis();
            result = jedis.get(key);
        }catch (Exception e){
            log.error("get key:{} value:{} error:{}",key,e);
            RedisShardPool.returnBrokenResource(jedis);
            return result;
        }
        RedisShardPool.returnResource(jedis);
        return result;
    }
    public static Long del(String key) {
        ShardedJedis jedis =null;
        Long result= null;
        try {
            jedis = RedisShardPool.getJedis();
            result = jedis.del(key);
        }catch (Exception e){
            log.error("get key:{} value:{} error:{}",key,e);
            RedisShardPool.returnBrokenResource(jedis);
            return result;
        }
        RedisShardPool.returnResource(jedis);
        return result;
    }

    public static void main(String[] args) {
        RedisShardPoolUtil.set("keyTest","keyTset");
        System.out.println(RedisShardPoolUtil.get("keyTest"));

        RedisShardPoolUtil.setWithExpireTime("hha","yya",60*10);
        RedisShardPoolUtil.expire("hha",100*10);
        RedisShardPoolUtil.del("keyTest");

    }
}
