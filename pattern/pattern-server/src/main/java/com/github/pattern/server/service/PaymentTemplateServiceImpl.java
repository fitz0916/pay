package com.github.pattern.server.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentTemplate;
import com.github.pattern.common.service.PaymentTemplateService;
import com.github.pattern.server.dao.PaymentTemplateDao;

@Service
public class PaymentTemplateServiceImpl extends BaseService implements PaymentTemplateService{

	
	@Autowired
	private PaymentTemplateDao paymentTemplateDao;
	
	@Override
	public ModelResult<List<PaymentTemplate>> selectByPayType(String payType) {
		ModelResult<List<PaymentTemplate>> modelResult = new ModelResult<List<PaymentTemplate>>();
		if(StringUtils.isBlank(payType)) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		List<PaymentTemplate> list = paymentTemplateDao.selectByPayType(payType);
		modelResult.setModel(list);
		return modelResult;
	}

	

}
