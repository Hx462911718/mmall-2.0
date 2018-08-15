package com.mmall.utils;

import com.mmall.common.RedisPool;
import lombok.extern.slf4j.Slf4j;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * @author hexin
 * @createDate 2018年08月08日 10:24:00
 */
@Slf4j
public class JedisPoolUtil {
    //重新设置这个key有效期
    public static Long expire(String key ,int expireTime){
        Jedis jedis =null;
        Long result= null;
        try {
            jedis = RedisPool.getJedis();
            result = jedis.expire(key, expireTime);
        }catch (Exception e){
            log.error("expire key:{} expireTime:{} error:{}",key,expireTime,e);
            RedisPool.returnBrokenResource(jedis);
            return result;
        }
        RedisPool.returnResource(jedis);
        return result;
    }

    public static String set(String key ,String value){
        Jedis jedis =null;
        String result= null;
        try {
            jedis = RedisPool.getJedis();
            result = jedis.set(key, value);
        }catch (Exception e){
            log.error("set key:{} value:{} error:{}",key,value,e);
            RedisPool.returnBrokenResource(jedis);
            return result;
        }
        RedisPool.returnResource(jedis);
        return result;
    }
    public static String setWithExpireTime( String key, String value, int expireTime) {
        Jedis jedis =null;
        String result= null;
        try {
            jedis = RedisPool.getJedis();
            result = jedis.setex(key,expireTime,value);
        }catch (Exception e){
            log.error("setex key:{} expritTime:{} value:{} error:{}",key,expireTime,value,e);
            RedisPool.returnBrokenResource(jedis);
            return result;
        }
        RedisPool.returnResource(jedis);
        return result;
    }

    public static String get(String key) {
        Jedis jedis =null;
        String result= null;
        try {
            jedis = RedisPool.getJedis();
            result = jedis.get(key);
        }catch (Exception e){
            log.error("get key:{} value:{} error:{}",key,e);
            RedisPool.returnBrokenResource(jedis);
            return result;
        }
        RedisPool.returnResource(jedis);
        return result;
    }
    public static Long del(String key) {
        Jedis jedis =null;
        Long result= null;
        try {
            jedis = RedisPool.getJedis();
            result = jedis.del(key);
        }catch (Exception e){
            log.error("get key:{} value:{} error:{}",key,e);
            RedisPool.returnBrokenResource(jedis);
            return result;
        }
        RedisPool.returnResource(jedis);
        return result;
    }

    public static void main(String[] args) {
        JedisPoolUtil.set("keyTest","keyTset");
        System.out.println(JedisPoolUtil.get("keyTest"));

        JedisPoolUtil.setWithExpireTime("hha","yya",60*10);
        JedisPoolUtil.expire("hha",100*10);
        JedisPoolUtil.del("keyTest");

    }
}
