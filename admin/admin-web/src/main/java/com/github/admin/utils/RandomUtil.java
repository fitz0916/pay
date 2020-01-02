package com.github.admin.utils;

import java.util.Random;


/**
 * <P>随机数</P>
 * 
 */
public class RandomUtil {
	private final Random RANDOM;

	private RandomUtil() {
		RANDOM = new Random();
	}

	private static class RandomHolder {
		private static final RandomUtil INSTANCE = new RandomUtil();
	}

	public static final RandomUtil getInstance() {
		return RandomHolder.INSTANCE;
	}

	public Random getRandom() {
		return getInstance().RANDOM;
	}

	public int nextInt() {
		return getRandom().nextInt();
	}

	public int nextInt(int bound) {
		return getRandom().nextInt(bound);
	}

	public long nextLong() {
		return getRandom().nextLong();
	}

	public double nextDouble() {
		return getRandom().nextDouble();
	}

	public double nextFloat() {
		return getRandom().nextFloat();
	}

	public boolean nextBoolean() {
		return getRandom().nextBoolean();
	}

	public double nextGaussian() {
		return getRandom().nextGaussian();
	}

	public void nextBytes(byte[] bytes) {
		getRandom().nextBytes(bytes);
	}

}
