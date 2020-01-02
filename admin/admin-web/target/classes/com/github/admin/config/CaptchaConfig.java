package com.github.admin.config;

import java.awt.Color;
import java.awt.Font;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.admin.service.CustomGenericManageableCaptchaService;
import com.octo.captcha.component.image.backgroundgenerator.UniColorBackgroundGenerator;
import com.octo.captcha.component.image.color.RandomListColorGenerator;
import com.octo.captcha.component.image.color.SingleColorGenerator;
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator;
import com.octo.captcha.component.image.textpaster.DecoratedRandomTextPaster;
import com.octo.captcha.component.image.textpaster.textdecorator.BaffleTextDecorator;
import com.octo.captcha.component.image.textpaster.textdecorator.TextDecorator;
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage;
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator;
import com.octo.captcha.engine.GenericCaptchaEngine;
import com.octo.captcha.image.gimpy.GimpyFactory;

@Configuration
public class CaptchaConfig {

	@Bean(name = "customGenericManageableCaptchaService")
	public CustomGenericManageableCaptchaService customGenericManageableCaptchaService(GenericCaptchaEngine imageEngine) {
		CustomGenericManageableCaptchaService captchaService = new CustomGenericManageableCaptchaService(imageEngine,180,100000);
		return captchaService;
	}
	
	@Bean
	public GenericCaptchaEngine imageEngine(GimpyFactory captchaFactory) {
		GenericCaptchaEngine imageEngine = new GenericCaptchaEngine(new GimpyFactory[] { captchaFactory });
		return imageEngine;
	}

	@Bean
	public GimpyFactory captchaFactory(RandomWordGenerator wordgen, ComposedWordToImage wordtoimage) {
		GimpyFactory captchaFactory = new GimpyFactory(wordgen, wordtoimage);
		return captchaFactory;
	}

	@Bean
	public RandomWordGenerator wordgen() {
		String randomstr = "0123456789abcdefghijklmnopqrstuvwxyz";
		RandomWordGenerator wordgen = new RandomWordGenerator(randomstr);
		return wordgen;
	}

	@Bean
	public ComposedWordToImage wordtoimage(RandomFontGenerator fontGenRandom, UniColorBackgroundGenerator backGenUni,
			DecoratedRandomTextPaster decoratedPaster) {
		ComposedWordToImage wordtoimage = new ComposedWordToImage(fontGenRandom, backGenUni, decoratedPaster);
		return wordtoimage;

	}

	@Bean
	public RandomFontGenerator fontGenRandom() {
		Font font = new Font("Arial", 0, 20);
		RandomFontGenerator fontGenRandom = new RandomFontGenerator(20, 20, new Font[] { font });
		return fontGenRandom;
	}

	@Bean
	public UniColorBackgroundGenerator backGenUni() {
		UniColorBackgroundGenerator backGenUni = new UniColorBackgroundGenerator(80, 32);
		return backGenUni;
	}

	@Bean
	public DecoratedRandomTextPaster decoratedPaster(Color colorGen) {
		int maxWordLength = 4; // 最打字符长度
		int minWorldLength = 4; // 最小字符长度
		DecoratedRandomTextPaster decoratedPaster = new DecoratedRandomTextPaster(maxWordLength, minWorldLength,
				new RandomListColorGenerator(new Color[] { colorGen }), new TextDecorator[] {});
		return decoratedPaster;
	}

	@Bean
	public BaffleTextDecorator baffleDecorator(Color colorWrite) {
		BaffleTextDecorator baffleTextDecorator = new BaffleTextDecorator(1, colorWrite);
		return baffleTextDecorator;
	}

	@Bean
	public SingleColorGenerator colorGen(Color colorWrite) {
		SingleColorGenerator colorGenerator = new SingleColorGenerator(colorWrite);
		return colorGenerator;
	}

	@Bean
	public Color colorWrite() {
		Color color = new Color(105, 105, 105);
		return color;
	}

//	@Bean(name = "colorDimGrey")
//	public Color colorDimGrey() {
//		Color color = new Color(105, 105, 105);
//		return color;
//
//	}
}
