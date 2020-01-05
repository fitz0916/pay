package com.github.pattern.utils;

import java.util.UUID;


/**
 * UUID生成器
 * 
 */
public class UUIDGenerator {

	public static String getUUID() {
		UUID uuid = UUID.randomUUID();
		String str = uuid.toString().toUpperCase();
		return str.replace("-", "");
	}

	// 获得指定数量的UUID
	public static String[] getUUID(int number) {
		if (number < 1) {
			return null;
		}
		String[] ss = new String[number];
		for (int i = 0; i < number; i++) {
			ss[i] = getUUID();
		}
		return ss;
	}

	public static String getUUIDByLen(int len) {
		String returnStr = getUUID();
		return returnStr.length() < len ? returnStr : returnStr.substring(0, len);
	}

	public static String getRandomNumber() {
		return getRandomNumber(6);
	}

	public static String getRandomNumber(int len) {
		StringBuffer maxStr = new StringBuffer("");
		StringBuffer minStr = new StringBuffer("1");
		for (int i = 0; i < len; i++) {
			maxStr.append("9");
			minStr.append("0");
		}
		int max = Integer.parseInt(maxStr.toString());
		int min = Integer.parseInt(minStr.toString()) / 10;
		// return new Random().nextInt(max) % (max - min + 1) + min + "";
		return RandomUtil.getInstance().nextInt(max) % (max - min + 1) + min + "";
	}

	public static void main(String[] args) {
		/*String[] ss = getUUID(10);
		for (int i = 0; i < ss.length; i++) {
			System.out.println("ss[" + i + "]=====" + ss[i]);
		}
		System.out.println(getUUID());
		System.out.println(getUUIDByLen(18));*/
		System.out.println(getRandomNumber());
	}

}
