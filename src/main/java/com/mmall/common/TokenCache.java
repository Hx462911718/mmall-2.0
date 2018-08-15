package com.mmall.common;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.TimeUnit;

/**
 * 本地token
 * @author hexin
 * @createDate 2018年03月16日 13:16:00
 */
public class TokenCache {
    private static Logger logger = LoggerFactory.getLogger(TokenCache.class);



    private static LoadingCache<String, String> loadCache = CacheBuilder
            .newBuilder()
            .initialCapacity(1000)
            .maximumSize(10000)
            .expireAfterAccess(12, TimeUnit.HOURS)//有效期为12小时
            .build(new CacheLoader<String, String>() {
                //默认的数据加载实现，当调用get取值的时候，如果key没有对应的取值，就调用这个方法进行加载
                @Override
                public String load(String s) throws Exception {
                    return "null";
                }
            });

    public static void setKey(String key, String value) {
        loadCache.put(key, value);
    }

    public static String getKey(String key) {
        String value = null;
        try {
            value = loadCache.get(key);
            if ("null".equals(value)) {
                return null;
            }
            return value;
        } catch (Exception e) {
            logger.error("loadCache get error", e);
        }
        return null;
    }
}
