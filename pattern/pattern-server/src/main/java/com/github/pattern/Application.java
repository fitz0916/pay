package com.github.pattern;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * pattern-server
 *
 */

@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.github.pattern.server.dao")
public class Application {

	public static void main(String[] args) {
		 SpringApplication.run(Application.class, args);

	}

}
