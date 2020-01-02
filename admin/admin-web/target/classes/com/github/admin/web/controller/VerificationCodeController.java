package com.github.admin.web.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.service.CustomGenericManageableCaptchaService;

@Controller
public class VerificationCodeController{
	
	 private static Logger logger = LoggerFactory.getLogger(VerificationCodeController.class);
	
	 @Autowired  
	 private CustomGenericManageableCaptchaService customGenericManageableCaptchaService; 
	 
	/***
	 * 生产随机验证码
	 * @throws IOException 
	 */
	@RequestMapping(value="/captcha")
	public String verificationCode(HttpServletRequest request, HttpServletResponse response){
		logger.info("进入生产验证码控制器....");
		try {
			ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();  
            String captchaId = request.getSession().getId();  
            customGenericManageableCaptchaService.removeCaptcha(request.getSession().getId());
            BufferedImage challenge = customGenericManageableCaptchaService.getImageChallengeForID(captchaId, request.getLocale());  
            response.setHeader("Cache-Control", "no-store");  
            response.setHeader("Pragma", "no-cache");  
            response.setDateHeader("Expires", 0L);  
            response.setContentType("image/jpeg");  
            ImageIO.write(challenge, "jpeg", jpegOutputStream); 
            byte[] captchaChallengeAsJpeg = jpegOutputStream.toByteArray();  
            ServletOutputStream respOs = response.getOutputStream();  
            respOs.write(captchaChallengeAsJpeg);  
            respOs.flush();  
            respOs.close();  
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
