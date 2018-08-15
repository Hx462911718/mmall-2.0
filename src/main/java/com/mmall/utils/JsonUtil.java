package com.mmall.utils;

import com.sun.xml.internal.ws.developer.SerializationFeature;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.PropertyNamingStrategy;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.annotate.JsonSerialize.Inclusion;
import org.codehaus.jackson.type.JavaType;
import org.codehaus.jackson.type.TypeReference;

import java.io.IOException;
import java.text.SimpleDateFormat;

/**
 * @author hexin
 * @createDate 2018年08月08日 11:05:00
 */
@Slf4j
public class JsonUtil {
    private static ObjectMapper objectMapper = new ObjectMapper();
    static {
        // 对象字段全部列入
        objectMapper.setSerializationInclusion(Inclusion.ALWAYS);
        // 取消默认转换timestamps形式
        objectMapper.configure(SerializationConfig.Feature.WRITE_DATE_KEYS_AS_TIMESTAMPS,false);
        // 忽略空bean转json的错误
        objectMapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS,false);
        // 统一日期格式yyyy-MM-dd HH:mm:ss
        objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        // 忽略在json字符串中存在,但是在java对象中不存在对应属性的情况
        objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES,false);

    }

    /**
     * Object转json字符串
     * @param obj
     * @param <T>
     * @return
     */
    public static <T> String obj2String(T obj){
        if (obj == null){
            return null;
        }
        try {
            return obj instanceof String ? (String) obj : objectMapper.writeValueAsString(obj);
        } catch (Exception e) {
            log.error("Parse object to String error");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Object转json字符串并格式化美化
     * @param obj
     * @param <T>
     * @return
     */
    public static <T> String obj2StringPretty(T obj){
        if (obj == null){
            return null;
        }
        try {
            return obj instanceof String ? (String) obj : objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);
        } catch (Exception e) {
            log.error("Parse object to String error");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * string转object
     * @param str json字符串
     * @param clazz 被转对象class
     * @param <T>
     * @return
     */
    public static <T> T string2Obj(String str,Class<T> clazz){
        if (StringUtils.isEmpty(str) || clazz == null){
            return null;
        }
        try {
            return clazz.equals(String.class)? (T) str :objectMapper.readValue(str,clazz);
        } catch (IOException e) {
            log.error("Parse String to Object error");
            e.printStackTrace();
            return null;
        }
    }
    public static <T> T string2Obj(String str, TypeReference<T> tTypeReference){
        if (StringUtils.isEmpty(str) || tTypeReference == null){
            return null;
        }
        try {
            return (T)(tTypeReference.getType().equals(String.class)?  str :objectMapper.readValue(str,tTypeReference));
        } catch (IOException e) {
            log.error("Parse String to Object error");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * string转object 用于转为集合对象
     * @param str json字符串
     * @param collectionClass 被转集合class
     * @param elementClasses 被转集合中对象类型class
     * @param <T>
     * @return
     */
    public static <T> T string2Obj(String str,Class<?> collectionClass,Class<?>... elementClasses){
        JavaType javaType = objectMapper.getTypeFactory().constructParametricType(collectionClass,elementClasses);
        try {
            return objectMapper.readValue(str,javaType);
        } catch (IOException e) {
            log.error("Parse String to Object error");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 通过json实现object互转
     * @param obj1 待转对象
     * @param clazz 目标对象class
     * @param <T>
     * @return
     */
    public static <T> T transferObj(Object obj1,Class<T> clazz){
        if (obj1 == null || clazz == null){
            return null;
        }
        try {
            if(obj1 instanceof String && clazz.equals(String.class)) {
                return (T)obj1;
            }else {
                String json = objectMapper.writeValueAsString(obj1);
                return objectMapper.readValue(json,clazz);
            }
        } catch (Exception e) {
            log.error("transfer object via json error");
            e.printStackTrace();
            return null;
        }
    }
    /**
     * 通过json实现object转集合
     * @param obj 待转对象
     * @param collectionClass 被转集合class
     * @param elementClasses 目标对象class
     * @param <T>
     * @return
     */
    public static <T> T transferObj(Object obj,Class<?> collectionClass,Class<?>... elementClasses){
        if (obj == null || collectionClass == null){
            return null;
        }
        try {
            JavaType javaType = objectMapper.getTypeFactory().constructParametricType(collectionClass,elementClasses);
            String json = objectMapper.writeValueAsString(obj);
            return objectMapper.readValue(json,javaType);
        } catch (Exception e) {
            log.error("transfer object via json error");
            e.printStackTrace();
            return null;
        }
    }


    /**
     * 将json串以下划线转驼峰的规则转为对象
     * @param obj1 待转对象
     * @param clazz 目标对象class
     * @param <T>
     * @return
     */
//    public static <T> T transferObjToCamel(Object obj1,Class<T> clazz){
//        if (obj1 == null || clazz == null){
//            return null;
//        }
//        try {
//            if(obj1 instanceof String && clazz.equals(String.class)) {
//                return (T)obj1;
//            }else {
//                //新创建mapper对象，防止对静态配置的干扰
//                ObjectMapper mapper = new ObjectMapper();
//                mapper.setSerializationInclusion(Inclusion.ALWAYS);
//                mapper.configure(SerializationConfig.Feature.WRITE_DATE_KEYS_AS_TIMESTAMPS,false);
//                mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS,false);
//                mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
//                mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES,false);
//                //下划线转驼峰
//                mapper.setPropertyNamingStrategy(PropertyNamingStrategy.);
//                String json = mapper.writeValueAsString(obj1);
//                T t = mapper.readValue(json,clazz);
//                return t;
//            }
//        } catch (Exception e) {
//            log.error("transfer object via json error");
//            e.printStackTrace();
//            return null;
//        }
//    }

}
