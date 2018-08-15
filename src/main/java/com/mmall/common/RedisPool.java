package com.mmall.common;

import com.mmall.utils.PropertiesUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * redeispool
 * @author hexin
 * @createDate 2018年08月08日 9:36:00
 */
public class RedisPool {

    private  static JedisPool   pool;//jedis 连接池
    private  static  Integer maxTotal= Integer.parseInt(PropertiesUtil.getProperty("redis.max.total","20"));//最大连接数
    private  static  Integer maxIdle =Integer.parseInt(PropertiesUtil.getProperty("redis.max.idle","10"));; //最大空闲状态数
    private  static  Integer minIdle =Integer.parseInt(PropertiesUtil.getProperty("redis.min.idle","2"));;//最小空闲状态数
    private  static  Boolean testOneBorrow = Boolean.parseBoolean(PropertiesUtil.getProperty("redis.test.borrow","true"));;//在borrow一个jedis实例的时候，是否要进行验证操作，如果为true,则得到的jedis的实例是可以用
    private  static  Boolean testOneRetrun = Boolean.parseBoolean(PropertiesUtil.getProperty("redis.test.return","true"));;//在return一个jedis实例的时候，是否要进行验证操作，如果为true,则放回jedispool的jedis的实例是可以用
    private  static  String ip =PropertiesUtil.getProperty("redis.ip");
    private  static  Integer port =Integer.parseInt(PropertiesUtil.getProperty("redis.port"));
    private  static   void  init(){
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(maxTotal);
        config.setMaxIdle(maxIdle);
        config.setMaxIdle(minIdle);
        config.setTestOnBorrow(testOneBorrow);
        config.setTestOnReturn(testOneRetrun);
        config.setBlockWhenExhausted(true);//连接耗尽时，是否阻塞，false抛出异常，true阻塞到知道超时，默认为true
        pool = new JedisPool(config,ip,port,1000*2,"hexin");
    }
    static {
        init();
    }
    public static Jedis getJedis(){
        return pool.getResource();
    }
    public static void returnResource(Jedis jedis){
            pool.returnResource(jedis);
    }

    public static void returnBrokenResource(Jedis jedis){
            pool.returnBrokenResource(jedis);
    }

    public static void main(String[] args) {
        Jedis jedis = pool.getResource();
        jedis.set("age","18");
        returnResource(jedis);
        pool.destroy();//临时调用


    }
}
