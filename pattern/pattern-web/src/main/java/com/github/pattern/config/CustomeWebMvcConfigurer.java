package com.github.pattern.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CustomeWebMvcConfigurer implements WebMvcConfigurer{

//	@Autowired
//	private SessionTimeOutInterceptor sessionTimeOutInterceptor;
//	
	
	public void addInterceptors(InterceptorRegistry registry) {
//       registry.addInterceptor(sessionTimeOutInterceptor)
//       .addPathPatterns("/**","/manager/**")
//       .excludePathPatterns("/login")
//       .excludePathPatterns("/captcha")
//       .excludePathPatterns("/resources/**");
	
	}

	
//	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		registry.addResourceHandler("/","/js/**","/css/**","/images/**","data/**","plugins/**").addResourceLocations("classpath:/resources/");
//	}

}