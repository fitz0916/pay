package com.github.pattern.web.controller;

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
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.utils.EmailValidator;
import com.github.pattern.utils.LengthValidator;
import com.github.pattern.utils.NotNullValidator;
import com.github.pattern.utils.PhoneValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/agent")
public class AgentController {

	@Autowired
	private AgentServiceClient agentServiceClient;
	
	@ApiOperation("代理商首页")
    @RequiresPermissions("pattern:agent:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
       return "/manager/agent/index";
    }
	
	
	@ApiOperation("代理商首页")
    @RequiresPermissions("pattern:agent:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody AgentRequest request) {
		ModelResult<PageVo> modelResult = agentServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	@ApiOperation("添加")
    @RequiresPermissions("pattern:agent:create")
    @RequestMapping(value = "/create",method = RequestMethod.GET)
	public String create() {
		return "/manager/agent/create";
	}
	
	@ApiOperation("增加权限")
    @RequiresPermissions("pattern:agent:create")
    @ResponseBody
    @RequestMapping(value = "/create", method = RequestMethod.POST)
	public Object create(Agent agent) {
		ComplexResult result = valid(agent);
        if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        
        ModelResult<Integer> modelResult = agentServiceClient.insertSelective(agent);
        return ResultUtils.buildResult(modelResult);
	}
	
	
	private ComplexResult valid(Agent agent) {
		ComplexResult result = FluentValidator.checkAll()
                .on(agent.getAgentName(), new LengthValidator(2, 50, "代理商名称"))
                .on(agent.getBusinessLicense(), new LengthValidator(2, 20, "营业执照号"))
                .on(agent.getAddress(), new LengthValidator(2, 100, "地址"))
                .on(agent.getCompanyPicPath(), new NotNullValidator("公司营业执照照片"))
                .on(agent.getIdCardFrontPath(), new NotNullValidator("身份证正面"))
                .on(agent.getIdCardBackPath(), new NotNullValidator("身份证反面"))
                .on(agent.getPhone(), new PhoneValidator("手机号码"))
                .on(agent.getEmail(), new EmailValidator("email"))
                .on(agent.getQq(), new LengthValidator(2, 20, "qq"))
                .on(agent.getWechat(), new LengthValidator(2, 30, "微信"))
                .doValidate()
                .result(ResultCollectors.toComplex());
		return result;
	}
	
	@ApiOperation("修改")
    @RequiresPermissions("pattern:agent:update")
    @RequestMapping(value = "/update/{id}",method = RequestMethod.GET)
	public String update(@PathVariable("id") int id, ModelMap modelMap) {
		ModelResult<Agent> modelResult = agentServiceClient.selectByPrimaryKey(id);
        if(!modelResult.isSuccess()) {
        	throw new NullPointerException("查询异常");
        }
        modelMap.put("agent", modelResult.getModel());
		return "/manager/agent/update";
	}
	
	@ApiOperation("修改角色")
    @RequiresPermissions("pattern:agent:update")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@PathVariable("id") int id, Agent agent) {
		ComplexResult result = valid(agent);
        if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        agent.setAgentId(id);
        ModelResult<Integer> modelResult =  agentServiceClient.updateByPrimaryKeySelective(agent);
        return ResultUtils.buildResult(modelResult);
    }
}
