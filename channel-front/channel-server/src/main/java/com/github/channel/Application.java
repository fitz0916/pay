package com.github.channel;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * channel-server
 *
 */
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})
@EnableDiscoveryClient
public class Application {
    public static void main( String[] args ){
    	 SpringApplication.run(Application.class, args);
    }
}
