package com.github.admin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * admin-server
 *
 */

@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.github.admin.server.dao")
public class AdminServerApplication {
    public static void main( String[] args ){
        SpringApplication.run(AdminServerApplication.class, args);
    }
}
