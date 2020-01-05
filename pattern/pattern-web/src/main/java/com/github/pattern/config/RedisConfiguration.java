package com.github.pattern.config;

import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import com.fasterxml.jackson.databind.ObjectMapper;


/***
 *  # Jedis和Lettuce都是Redis Client
	# Jedis 是直连模式，在多个线程间共享一个 Jedis 实例时是线程不安全的，
	# 如果想要在多线程环境下使用 Jedis，需要使用连接池，
	# 每个线程都去拿自己的 Jedis 实例，当连接数量增多时，物理连接成本就较高了。
	# Lettuce的连接是基于Netty的，连接实例可以在多个线程间共享，
	# 所以，一个多线程的应用可以使用同一个连接实例，而不用担心并发线程的数量。
	# 当然这个也是可伸缩的设计，一个连接实例不够的情况也可以按需增加连接实例。
	
	# 通过异步的方式可以让我们更好的利用系统资源，而不用浪费线程等待网络或磁盘I/O。
	# Lettuce 是基于 netty 的，netty 是一个多线程、事件驱动的 I/O 框架，
	# 所以 Lettuce 可以帮助我们充分利用异步的优势。
 * @author XIEYONGPEI983
 *
 */

@Configuration
@EnableCaching
public class RedisConfiguration extends CachingConfigurerSupport{

	private static final Logger log = LoggerFactory.getLogger(RedisConfiguration.class);
	@Value("${spring.redis.hostName}")
	private String host;
	@Value("${spring.redis.port}")
	private int port;
	
	@Override
	public KeyGenerator keyGenerator() {
		// 设置自动key的生成规则，配置spring boot的注解，进行方法级别的缓存
        // 使用：进行分割，可以很多显示出层级关系
        return (target, method, params) -> {
            StringBuilder sb = new StringBuilder();
            sb.append(target.getClass().getName());
            sb.append(":");
            sb.append(method.getName());
            for (Object obj : params) {
                sb.append(":" + String.valueOf(obj));
            }
            String rsToUse = String.valueOf(sb);
            log.info("自动生成Redis Key -> [{}]", rsToUse);
            return rsToUse;
        };
	}
	
	/**
     * 缓存配置管理器
     */
    @Bean
	public CacheManager cacheManager(LettuceConnectionFactory lettuceConnectionFactory) {
    	RedisCacheManager.RedisCacheManagerBuilder builder = RedisCacheManager
                .RedisCacheManagerBuilder
                .fromConnectionFactory(lettuceConnectionFactory);
        Set<String> cacheNames = new HashSet<String>();
        cacheNames.add("codeNameCache");
        builder.initialCacheNames(cacheNames);
        return builder.build();
	}
    
    
 	@Bean
    public RedisTemplate<String, Object> redisTemplate(LettuceConnectionFactory lettuceConnectionFactory) {
 		//设置序列化
        Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<Object>(Object.class);
        ObjectMapper om = new ObjectMapper();
        om.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        jackson2JsonRedisSerializer.setObjectMapper(om);
        //配置redisTemplate
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<String, Object>();
        redisTemplate.setConnectionFactory(lettuceConnectionFactory);
        RedisSerializer<?> stringSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringSerializer);//key序列化
        redisTemplate.setValueSerializer(jackson2JsonRedisSerializer);//value序列化
        redisTemplate.setHashKeySerializer(stringSerializer);//Hash key序列化
        redisTemplate.setHashValueSerializer(jackson2JsonRedisSerializer);//Hash value序列化
        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

 	@Bean
    public LettuceConnectionFactory redisConnectionFactory() {
        return new LettuceConnectionFactory(new RedisStandaloneConfiguration(host, port));
    }
}
