package com.github.admin.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 
 */
public class SessionMapUtil {


    private static Map<String,String> map = new HashMap<>();

    public static void setMap(String key,String value){
        map.put(key,value);
    }

    public static String getMap(String key){
        return map.get(key);
    }

    public static void remove(String key){
        map.remove(key);
    }
}
