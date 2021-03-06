package com.github.pattern.web.controller;

import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.github.admin.client.service.UserServiceClient;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.User;
import com.github.admin.common.exception.AccountLockException;
import com.github.admin.common.exception.AccountNotFoundException;
import com.github.admin.common.exception.AccountUnknownException;
import com.github.admin.common.exception.IncorrectCaptchaException;
import com.github.admin.common.exception.IncorrectPasswordException;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.domain.result.ResultUtils;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.service.CustomGenericManageableCaptchaService;
import com.github.pattern.token.SecurityToken;
import com.github.pattern.utils.RedisUtils;
import com.octo.captcha.service.CaptchaServiceException;

import io.swagger.annotations.ApiOperation;

@Controller
public class LoginController {

	private static Logger logger = LoggerFactory.getLogger(LoginController.class);
	 
	@Autowired
	private RedisUtils redisUtils;
	
	@Autowired
	private UserServiceClient userServiceClient;
	
	@Autowired
	private CustomGenericManageableCaptchaService customGenericManageableCaptchaService;
	
	@GetMapping("/login")
	public String index() {
		return "login";
	}

	
	@ApiOperation("用户登录")
    @RequestMapping("/login")
	public @ResponseBody Object login(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");
        String rememberMe = "false";
        ResultVo resultVo = new ResultVo();
        ModelResult<ResultVo> modelResult = new ModelResult<ResultVo>();
        if(StringUtils.isBlank(userName)) {
        	logger.error("用户登入账号为空！");
        	modelResult.withError("10000", "请输入账号!");
        	return ResultUtils.buildResult(modelResult);
        }
        
        if(StringUtils.isBlank(password)) {
        	logger.error("用户密码能为空！");
        	modelResult.withError("10001","请输入密码!");
        	return ResultUtils.buildResult(modelResult);
        }
        
//        if(StringUtils.isBlank(captcha)) {
//        	logger.error("用户登入验证码为空！");
//        	modelResult.withError("10002", "请输入验证码!");
//        	return ResultUtils.buildResult(modelResult);
//        }
        Subject subject = SecurityUtils.getSubject();
        Session session = subject.getSession();
        String sessionId = session.getId().toString();
//        boolean isResponseCorrect = customGenericManageableCaptchaService.validateResponseForID(request.getSession().getId(), captcha);
//        logger.info("用户输入验证码:{}是否一致{}",captcha,isResponseCorrect);
//        if(!isResponseCorrect) {
//            modelResult.withError("10002", "请输入正确的验证码!");
//            return ResultUtils.buildResult(modelResult);
//        }
      // 使用shiro认证
      try{
    	  SecurityToken usernamePasswordToken = new SecurityToken(userName, password,captcha);
            if (BooleanUtils.toBoolean(rememberMe)) {
                usernamePasswordToken.setRememberMe(true);
            } else {
                usernamePasswordToken.setRememberMe(false);
            }
            subject.login(usernamePasswordToken);
        } catch (UnknownAccountException e) {
            logger.error("账号不存在:{}",e.getMessage());
            modelResult.withError("10002", "帐号不存在！");
            return ResultUtils.buildResult(modelResult);
        } catch (IncorrectCredentialsException e) {
            logger.error("密码无效:{}",e.getMessage());
            modelResult.withError("10003", "密码错误！");
            return ResultUtils.buildResult(modelResult);
        } catch (LockedAccountException e) {
            logger.error("用户账号已锁定:{}",e.getMessage());
            modelResult.withError("10004", "无效帐号！");
            return ResultUtils.buildResult(modelResult);
        } catch(AccountUnknownException e) {
        	 modelResult.withError("10005", "系统异常,请稍后重试！");
        	 return ResultUtils.buildResult(modelResult);
        } catch(AccountNotFoundException e) {
            logger.error("账号不存在:{}",e.getMessage());
            modelResult.withError("10006", "帐号不存在！");
            return ResultUtils.buildResult(modelResult);
        } catch(AccountLockException e) {
            logger.error("账号已锁定:{}",e.getMessage());
            modelResult.withError("10007", "账号已锁定！");
            return ResultUtils.buildResult(modelResult);
        }catch(IncorrectPasswordException e) {
            logger.error("密码无效:{}",e.getMessage());
            modelResult.withError("10008", "密码错误！");
            return ResultUtils.buildResult(modelResult);
        } catch(IncorrectCaptchaException e) {
            logger.error("验证码错误:{}",e.getMessage());
            modelResult.withError("10009", "验证码错误或已失效！");
            return ResultUtils.buildResult(modelResult);
        }catch(CaptchaServiceException e) {
        	 modelResult.withError("10010", "验证码失效！");
        	 return ResultUtils.buildResult(modelResult);
        }catch(Exception e) {
        	 modelResult.withError("10005", "系统异常,请稍后重试！");
        	 return ResultUtils.buildResult(modelResult);
        }
        logger.info("用户登入成功:{}",userName);
        ModelResult<User> userModelResult = userServiceClient.selectUserByUserName(userName);
        if(!modelResult.isSuccess()) {
        	modelResult.withError("0", "登入失败！");
        	return ResultUtils.buildResult(modelResult);
        }
        User user = userModelResult.getModel();
//        //将userId 存入session中
        String redisVal = JSONObject.toJSONString(user);
        redisUtils.setEx(Constants.ADMIN_CURRENT_USER + user.getUserName(),redisVal, 60 * 60,TimeUnit.MINUTES);
//        redisUtils.setEx(Constants.ADMIN_SERVER_SESSION + user.getUserName(),redisVal,60 * 60,TimeUnit.MINUTES);
        String shiroSessionKey = Constants.ADMIN_SERVER_SESSION + sessionId;
        logger.info("当前shiro session 的用户的shiroSessionKey = 【{}】,用户账号为userName = 【{}】",shiroSessionKey,userName);
        SecurityUtils.getSubject().getSession().setAttribute(shiroSessionKey,userName);
        
        String userJSON = redisUtils.get(Constants.ADMIN_CURRENT_USER + userName);
        
        logger.info("当前redis缓存用户信息:[{}]",userJSON);
        customGenericManageableCaptchaService.removeCaptcha(request.getSession().getId());
        resultVo = new ResultVo();
        resultVo.setCode("1");
        resultVo.setMsg("登入成功！");
        modelResult.setModel(resultVo);
        return ResultUtils.buildResult(modelResult);
	}
	
}
