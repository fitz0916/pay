package com.github.pattern.web.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.common.constants.Constants;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.CustomerPaymentChannelInfoServiceClient;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.PaymentChannelServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.utils.NotNullValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/customerpaymentchannelinfo")
public class CustomerPaymentChannelInfoController {

	
	@Autowired
	private CustomerPaymentChannelInfoServiceClient customerPaymentChannelInfoServiceClient;
	
	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	@Autowired
	private PaymentChannelServiceClient paymentChannelServiceClient;
	
	
	@ApiOperation("渠道商户首页")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
	public String index() {
		return "/manager/paymentchannelinfo/index";
	}
	
	@ApiOperation("渠道商户首页")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody CustomerPaymentChannelInfoRequest request) {
		ModelResult<PageVo> modelResult = customerPaymentChannelInfoServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	@ApiOperation("商户对应渠道列表")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:read")
    @RequestMapping(value = "/paymentchannelinfolist",method = RequestMethod.POST)
	public @ResponseBody Object paymentChannelInfoList(@RequestBody CustomerPaymentChannelInfoRequest request) {
		ModelResult<PageVo> modelResult = customerPaymentChannelInfoServiceClient.paymentChannelInfoPage(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	@ApiOperation("添加商户渠道")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:create")
    @RequestMapping(value = "/create/{customerId}",method = RequestMethod.GET)
	public String create(@PathVariable("customerId")Integer customerId,ModelMap modelMap) {
		ModelResult<Customer> customerCodelResult = customerServiceClient.selectByPrimaryKey(customerId);
		ModelResult<List<PaymentChannel>> paymentModelResult = paymentChannelServiceClient.list();
		if(!customerCodelResult.isSuccess() || !paymentModelResult.isSuccess()) {
			throw new NullPointerException("查询失败");
		}
		modelMap.put("customer", customerCodelResult.getModel());
		modelMap.put("paymentChannelList", paymentModelResult.getModel());
		return "/manager/paymentchannelinfo/create";
	}
	
	@ApiOperation("添加商户渠道")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		ComplexResult result = valid(customerPaymentChannelInfo);
        if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        
        ModelResult<Integer> modelResult = customerPaymentChannelInfoServiceClient.insertSelective(customerPaymentChannelInfo);
        return ResultUtils.buildResult(modelResult);
	}

	private ComplexResult valid(CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		ComplexResult result = FluentValidator.checkAll()
				.on(customerPaymentChannelInfo.getCustomerId() == null ? null : String.valueOf(customerPaymentChannelInfo.getCustomerId()), new NotNullValidator("商户"))
				.on(customerPaymentChannelInfo.getCustomerNo(), new NotNullValidator("商户编号"))
			    .on(customerPaymentChannelInfo.getPaymentChannelId() == null ? null : String.valueOf(customerPaymentChannelInfo.getPaymentChannelId()), new NotNullValidator("支付渠道"))
                .on(customerPaymentChannelInfo.getRemark(), new NotNullValidator("备注"))
                .doValidate()
                .result(ResultCollectors.toComplex());
		return result;
	}
	
	@ApiOperation("编辑商户渠道")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:update")
    @RequestMapping(value = "/update/{customerId}/{customerPaymentChannelInfoId}",method = RequestMethod.GET)
	public String update(@PathVariable("customerId")Integer customerId,@PathVariable("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId,ModelMap modelMap) {
		ModelResult<Customer> customerCodelResult = customerServiceClient.selectByPrimaryKey(customerId);
		ModelResult<List<PaymentChannel>> paymentModelResult = paymentChannelServiceClient.list();
		ModelResult<CustomerPaymentChannelInfo> custmerPaymentChannelModelResult = customerPaymentChannelInfoServiceClient.selectByPrimaryKey(customerPaymentChannelInfoId);
		if(!customerCodelResult.isSuccess() || !paymentModelResult.isSuccess() || !custmerPaymentChannelModelResult.isSuccess()) {
			throw new NullPointerException("查询失败");
		}
		modelMap.put("customer", customerCodelResult.getModel());
		modelMap.put("paymentChannelList", paymentModelResult.getModel());
		modelMap.put("customerPaymentChannelInfo", custmerPaymentChannelModelResult.getModel());
		return "/manager/paymentchannelinfo/update";
	}
	
	@ApiOperation("编辑商户渠道")
    @RequiresPermissions("pattern:customerpaymentchannelinfo:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		ComplexResult result = valid(customerPaymentChannelInfo);
        if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        
        ModelResult<Integer> modelResult = customerPaymentChannelInfoServiceClient.updateByPrimaryKeySelective(customerPaymentChannelInfo);
        return ResultUtils.buildResult(modelResult);
	}
	
}
