package com.github.admin.filter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.servlet.AdviceFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.github.admin.common.constants.Constants;
import com.github.appmodel.vo.ResultVo;

//@Order(1)
//@WebFilter(filterName = "loginFilter", urlPatterns = "/manage/**")
public class LoginFilter extends AdviceFilter{

	private final static Logger logger = LoggerFactory.getLogger(LoginFilter.class);
	private static final String URI = "/manage/index";
	private static final String X_REQUEST_WITH = "x-requested-with";
	private static final String XML_HTTP_REQUEST = "XMLHttpRequest";
	private static final String LOGIN_URL = "/login";
	
	protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
		logger.info("...............shiro filter........");
		HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		HttpServletResponse httpServletResponse = (HttpServletResponse)response;
		String uri = httpServletRequest.getRequestURI();
		if(uri.indexOf(URI) > -1) {
			logger.info("如果用户全局刷新，则直接跳过，用户授权通过shiro配置");
			return true;
		}
		logger.info("过滤请求uri = 【{}】",uri);
		if(SecurityUtils.getSubject() != null) {
			Subject subject = SecurityUtils.getSubject();
	        Session session = subject.getSession();
	        String sessionId = session.getId().toString();
	        String shiroSessionKey = Constants.ADMIN_SERVER_SESSION + sessionId;
	        logger.info("shiro sessionId = 【{}】,shiroSessionKey = 【{}】",sessionId,shiroSessionKey);
	        
	        if(session.getAttribute(shiroSessionKey) != null) {
	        	String userName = (String)session.getAttribute(shiroSessionKey);
	        	logger.info("当前用户userName = 【{}】",userName);
	        	if(StringUtils.isBlank(userName)) {
	        		logger.info("当前用户session存在，但登录用户不存在");
	        		if(isAjax(httpServletRequest)) {
	        			logger.info("当前用户为ajax请求");
	        			buildJSONResult(response);
	        		}else {
	        			logger.info("当前用户为普通请求");
	        			httpServletResponse.sendRedirect(LOGIN_URL);
	        		}
	    			return false;
	        	}
	        }else{
	        	logger.info("当前用户session不存在，但登录用户不存在");
	        	if(isAjax(httpServletRequest)) {
	        		logger.info("当前用户为ajax请求.....");
	        		buildJSONResult(response);
	        	}else {
	        		logger.info("当前用户为普通请求.....");
	        		httpServletResponse.sendRedirect(LOGIN_URL);
	        	}
    			return false;
	        }
		}
        return true;
    }
	
	private boolean isAjax(HttpServletRequest request) {
		//获取头部信息
		if (request.getHeader(X_REQUEST_WITH) != null  && request.getHeader(X_REQUEST_WITH) .equalsIgnoreCase(XML_HTTP_REQUEST)){
		    return true;
		}else{
		    return false;
		}
	}
	
	private void buildJSONResult(ServletResponse response) throws IOException{
		ResultVo result = new ResultVo();
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		result.setCode("10110");
		result.setMsg("登录超时!");
		result.setData("");
		result.setIsSuccess(false);
		String JSONResult = JSON.toJSONString(result);
		response.getWriter().write(JSONResult);
	}

	public static void main(String args[]) {
		String url = "/manage/2index";
		System.out.println(url.indexOf("/manage/index"));
		if(url.indexOf("/manage/index") > -1) {
			System.out.println("-----");
		}
	}
}
