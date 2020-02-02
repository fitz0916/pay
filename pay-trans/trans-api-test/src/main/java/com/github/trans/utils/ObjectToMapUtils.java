package com.github.trans.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * <p>对象转成Map工具类 </p>
 * 
 * @version 1.0
 **/
public class ObjectToMapUtils {

	/**
	 * 将目标对象的所有属性转换成Map对象
	 * 
	 * @param target 目标对象
	 * 
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target) {
		return toMap(target, false);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 * 
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 * 
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target, boolean ignoreParent) {
		return toMap(target, ignoreParent, false);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 * 
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 * @param ignoreEmptyValue 是否不把空值添加到Map中
	 * 
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target, boolean ignoreParent, boolean ignoreEmptyValue) {
		return toMap(target, ignoreParent, ignoreEmptyValue, new String[0]);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 * 
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 * @param ignoreEmptyValue 是否不把空值添加到Map中
	 * @param ignoreProperties 不需要添加到Map的属性名
	 * @return Map
	 * 
	 */
	public static <T> Map<String, T> toMap(Object target, boolean ignoreParent, boolean ignoreEmptyValue,
			String... ignoreProperties) {
		final Map<String, T> map = new HashMap<String, T>();
		if (target == null) {
			return map;
		}
		final Map<String, String> ignoreMap = getIgnorePropertiesMap(ignoreProperties);
		final List<Field> fields = getClassFields(ignoreParent, target.getClass());
		for (Field field : fields) {
			T value = getFieldsValue(target, field);
			if (isIgnoreEmpty(value, ignoreEmptyValue) || isIgnoreProperty(field.getName(), ignoreMap)) {
				continue;
			}
			map.put(field.getName(), value);
		}
		return map;
	}

	/**
	 * 获得忽略的属性Map条件
	 * 
	 * @param ignoreProperties 待忽略的属性
	 * @return
	 * 
	 */
	private static Map<String, String> getIgnorePropertiesMap(final String[] ignoreProperties) {
		final Map<String, String> resultMap = new HashMap<String, String>();
		for (String ignoreProperty : ignoreProperties) {
			resultMap.put(ignoreProperty, null);
		}
		return resultMap;
	}

	/**
	 * 获取类实例的属性
	 * 
	 * @param ignoreParent 是否忽略父类属性
	 * @param clazz 类名
	 * @return
	 * 
	 */
	private static List<Field> getClassFields(boolean ignoreParent, Class<?> clazz) {
		final List<Field> fields = new ArrayList<Field>();
		fields.addAll(Arrays.asList(clazz.getDeclaredFields()));
		if (!ignoreParent) {
			fields.addAll(getParentClassFields(fields, clazz.getSuperclass()));
		}
		return fields;
	}

	/**
	 * 获取类实例的父类的属性
	 * 
	 * @param fields 类实例的属性
	 * @param clazz 类名
	 * @return
	 * 
	 */
	private static List<Field> getParentClassFields(List<Field> fields, Class<?> clazz) {
		fields.addAll(Arrays.asList(clazz.getDeclaredFields()));
		if (clazz.getSuperclass() == null) {
			return fields;
		}
		return getParentClassFields(fields, clazz.getSuperclass());
	}

	/**
	 * 获取类实例的属性值
	 * 
	 * @param target 目标对象
	 * @param field 目标对象属性
	 * @return
	 * 
	 */
	@SuppressWarnings("unchecked")
	private static <T> T getFieldsValue(Object target, Field field) {
		field.setAccessible(true);
		T value = null;
		try {
			value = (T) field.get(target);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}

	/**
	 * 是否忽略属性
	 * 
	 * @param fieldName 属性字段名
	 * @param ignoreMap 忽略属性MAP
	 * @return
	 * 
	 */
	private static <T> boolean isIgnoreProperty(String fieldName, final Map<String, String> ignoreMap) {
		return ignoreMap.containsKey(fieldName);
	}

	/**
	 * 是否忽略空值
	 * 
	 * @param value 属性值
	 * @param ignoreEmptyValue 是否不把空值添加到Map中
	 * @return
	 * 
	 */
	private static <T> boolean isIgnoreEmpty(T value, boolean ignoreEmptyValue) {
		boolean isEmpty = (value == null || value.toString().equals(""));
		boolean isCollectionEmpty = (value instanceof Collection && ((Collection<?>) value).isEmpty());
		boolean isMapEmpty = (value instanceof Map && ((Map<?, ?>) value).isEmpty());
		return ignoreEmptyValue && (isEmpty || isCollectionEmpty || isMapEmpty);
	}

}
