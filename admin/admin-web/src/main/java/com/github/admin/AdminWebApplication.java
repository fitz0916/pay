package com.github.admin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * admin-web
 *
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
//@ServletComponentScan
public class AdminWebApplication {
	
    public static void main( String[] args ){
       SpringApplication.run(AdminWebApplication.class, args);
    }
    

}
