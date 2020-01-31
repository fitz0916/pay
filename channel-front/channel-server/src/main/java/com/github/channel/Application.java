package com.github.channel;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

/**
 * channel-server
 *
 */
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})
public class Application {
    public static void main( String[] args ){
    	 SpringApplication.run(Application.class, args);
    }
}
