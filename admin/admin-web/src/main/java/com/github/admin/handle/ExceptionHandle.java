package com.github.admin.handle;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.ShiroException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.utils.ResultUtils;
import com.github.admin.common.vo.ErrorMsgVo;
import com.github.admin.common.vo.ResultVo;
import com.github.admin.utils.SpringWebUtils;
import com.github.appmodel.domain.result.ModelResult;

@RestControllerAdvice
public class ExceptionHandle{

	private final static Logger LOGGER = LoggerFactory.getLogger(ExceptionHandle.class);
	
	private static final String SERVLERT_STATUS_CODE = "javax.servlet.error.status_code";
	
	@ExceptionHandler(ShiroException.class)
	public Object resolveShiroException(HttpServletRequest request, HandlerMethod handlerMethod, Throwable exception) {
		LOGGER.error("当前全局异常拦截ShiroException权限异常，用户没有权限访问！");
//		if(SpringWebUtils.isAjax(handlerMethod)) {
//			ModelResult<ResultVo> modelResult = new ModelResult<ResultVo>();
//			modelResult.withError("10110", "您没有权限操作！");
//			return ResultUtils.buildResult(modelResult);
//		}else {
//			ModelAndView modelAndView = new ModelAndView();
//			request.setAttribute(SERVLERT_STATUS_CODE, 403);
//			modelAndView.setViewName("/error"); 
//			modelAndView.addObject("error",exception.getMessage());
//			return modelAndView;
//		}
		//shiro不需要做ajax判断
		ModelResult<ResultVo> modelResult = new ModelResult<ResultVo>();
		modelResult.withError("10110", "您没有权限操作！");
		return ResultUtils.buildResult(modelResult);
		
	}
	
	@ExceptionHandler(Exception.class)
	public Object resolveException(HttpServletRequest request, HandlerMethod handlerMethod, Throwable exception) {
		String status = String.valueOf(getStatus(request).value());
		LOGGER.info("全局统一异常处理,请求响应状态码status = 【{}】",status);
		ModelAndView modelAndView = new ModelAndView();
		if(SpringWebUtils.isAjax(handlerMethod)) {
			ModelResult<ErrorMsgVo> modelResult = new ModelResult<ErrorMsgVo>();
			String msg = "访问出错，无法访问:";
			if(StringUtils.isNotBlank(exception.getMessage())) {
				msg = msg + exception.getMessage();
			}else {
				msg = msg + "系统异常，请与管理员联系！";
			}
//			modelResult.withError(status,msg);
			return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, modelResult);
		}else {
			modelAndView.setViewName("/error"); 
			modelAndView.addObject("error",exception.getMessage());
		}
		return modelAndView;
	}

	/**
     * 获取响应状态码
     * @param request
     * @return
     */
    private HttpStatus getStatus(HttpServletRequest request) {
        Integer statusCode = (Integer) request.getAttribute(SERVLERT_STATUS_CODE);
        if (statusCode == null) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }
        return HttpStatus.valueOf(statusCode);
    }

}
