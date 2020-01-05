<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<style>
	.radio-inline-overwrite{
		width: 10%;
		height: 100%;
		line-height: 20px;
		display: inline-block;
		padding-left: 20px;
		margin-bottom: 0;
		font-weight: 400;
		vertical-align: middle;
		cursor: pointer;
	}
</style>


<div id="createOrUpdateDialog" class="crudDialog">
	<div style="margin-top: 10px;margin-bottom: 25px">
		<label style="margin-left: 28px;margin-right: 5px">选择允许支付时间范围</label>
		<input type="text" id="payTime" style="cursor: pointer" placeholder="hh:mm:ss-hh:mm:ss">
	</div>

	<form id="form" method="post">
		<div class="form-group">
			<label for="allowTime" id="allowTimeLabel">允许支付时间(格式hh:mm:ss-hh:mm:ss 24小时制 多条用|隔开 不输入则不限制)</label>
			<input id="allowTime" type="text" class="form-control" name="allowTime" maxlength="100" value="${payChannelInfoRisk.allowTime}" onpaste="return false" onkeyup="keyupAllowTime(this)">
		</div>
		<div class="form-group">
			<label for="payInterval">交易时间间隔(单位秒,不输入则不限制)</label>
			<input id="payInterval" type="text" class="form-control" name="payInterval" maxlength="30" value="${payChannelInfoRisk.payInterval}" onpaste="return false" onkeyup="keyupDaymoney(this)">
		</div>
		<div class="form-group">
			<label for="allowNum">交易次数限制(不输入则不限制)</label>
			<input id="allowNum" type="text" class="form-control" name="allowNum" maxlength="20" value="${payChannelInfoRisk.allowNum}" onpaste="return false" onkeyup="keyupDaymoney(this)">
		</div>
		<div class="form-group">
			<label for="singleMoney">单笔交易金额限制(单位元,格式50-1000 多条用|隔开 不输入则不限制)</label>
			<input id="singleMoney" type="text" class="form-control" name="singleMoney" maxlength="100" value="${payChannelInfoRisk.singleMoney}" onpaste="return false" onkeyup="keyupSingleMoney(this)">
		</div>
		<div class="form-group">
			<label for="dayMoney">交易日限额(单位元,不输入则不限制)</label>
			<input id="dayMoney" type="text" class="form-control" name="dayMoney" maxlength="10" value="${payChannelInfoRisk.dayMoney}" onpaste="return false" onkeyup="keyupDaymoney(this)">
		</div>
		<div class="form-group">
			<label for="userMostNumber">允许终端用户支付最多次数(不输入则不限制)</label>
			<input id="userMostNumber" type="text" class="form-control" name="userMostNumber" value="${payChannelInfoRisk.userMostNumber}" maxlength="10" onpaste="return false" onkeyup="keyupDaymoney(this)">
		</div>
		<div class="form-group">
			<label for="remark">备注</label>
			<input id="remark" type="text" class="form-control" name="remark" maxlength="50" value="${payChannelInfoRisk.remark}">
		</div>
		<c:choose>
			<c:when test="${empty payChannelInfoRisk}">
				<input type="hidden" id="payChannelInfoId" name="payChannelInfoId" value="${payChannelInfoId}">
				<input type="hidden" id="payTypeId" name="payTypeId" value="${payTypeId}">
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
				</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" id="payChannelInfoRiskId" name="payChannelInfoRiskId" value="${payChannelInfoRisk.payChannelInfoRiskId}">
				<input type="hidden" id="payChannelInfoId" name="payChannelInfoId" value="${payChannelInfoRisk.payChannelInfoId}">
				<input type="hidden" id="payTypeId" name="payTypeId" value="${payChannelInfoRisk.payTypeId}">
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">更新</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</c:otherwise>
		</c:choose>
	</form>
</div>
<script>

	//初始化时间选择器
    laydate.render({
        elem: '#payTime' //指定元素
        ,type: 'time'
        ,range: true
        ,done: function(value, date, endDate){
            /*console.log(value); //得到日期生成的值，如：2017-08-18
            console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。*/
			if(value != ''){
			    //去除所有空格
				value = value.replace(/\s/g, "");
				var allowTime = $("#allowTime").val().trim();
				if(allowTime == ''){
				    $("#allowTime").val(value);
				    $("#allowTimeLabel").addClass('active');
				}else{
				    $("#allowTime").val(allowTime + '|' + value);
                    $("#allowTimeLabel").addClass('active');
				}
			}
        }
    });

function keyupAllowTime(event){
    var value = $(event).val();
    var regex = /[^\d-:|]/g;

    //只能输入数字和符号-:|
    if(regex.test(value)){
        $(event).val($(event).val().replace(/[^\d-:|]/g,''));
    }else{
        //不能输入已-:|为开头的字符
        if(value == '-'){
            $(event).val($(event).val().substr(0,value.length-1));
        }
        if(value == ':'){
            $(event).val($(event).val().substr(0,value.length-1));
        }
        if(value == '|'){
            $(event).val($(event).val().substr(0,value.length-1));
        }
    }
}


function keyupSingleMoney(event){
    var value = $(event).val();
    var regex = /[^\d-|]/g;

    //只能输入数字和符号-|
    if(regex.test(value)){
        $(event).val($(event).val().replace(/[^\d-|]/g,''));
    }else{
        //不能输入已-|为开头的字符
        if(value == '-'){
            $(event).val($(event).val().substr(0,value.length-1));
		}
        if(value == '|'){
            $(event).val($(event).val().substr(0,value.length-1));
        }
    }
}

//新增支付通道风控
function createSubmit() {
    /*var singleMoney = $("#singleMoney").val().trim();
    var regex = /(^[0-9]-[0-9]$)|(\|[0-9]-[0-9]$)/;
    if(!regex.test(singleMoney)){
        layer.msg('单笔交易金额格式不正确！',{icon:0,time:2000});
        return false;
    }
    return;*/

    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelInfo/createRisk',
        data: $('#form').serialize(),
        beforeSend: function() {
            var payChannelInfoId = $("#payChannelInfoId").val();
            var payTypeId = $("#payTypeId").val().trim();
            if(payChannelInfoId == ''){
                layer.msg('支付通道ID获取失败！',{icon:0,time:2000});
                return false;
			}
            if(payTypeId == ''){
                layer.msg('交易类型ID获取失败！',{icon:0,time:2000});
                return false;
            }

            var allowTime = $("#allowTime").val().trim();
            var allowNum = $("#allowNum").val().trim();
            var payInterval = $("#payInterval").val().trim();
            var singleMoney = $("#singleMoney").val().trim();
            var dayMoney = $("#dayMoney").val().trim();
            var userMostNumber = $("#userMostNumber").val().trim();

            if(allowTime != ''){
                var regex = /(^(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))|(\|(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))/;
                if(!regex.test(allowTime)){
                    layer.msg('允许支付时间格式不正确！',{icon:0,time:2000});
                    return false;
                }
			}

            if(allowTime == '' && allowNum == '' && payInterval == '' && singleMoney == '' && dayMoney == '' && userMostNumber == ''){
                layer.msg('请至少设置一项风控条件限制！',{icon:0,time:2000});
                return false;
			}
        },
        success: function(result) {
			if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    createDialog.close();
                    $table.bootstrapTable('refresh');
                });
			} else {
                if (result.data instanceof Array) {
                    $.each(result.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.data,{icon:2});
                }
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
			layer.alert(textStatus,{icon:2});
        }
    });
}


//更新渠道账户
function updateSubmit() {
    var payChannelInfoId = $("#payChannelInfoId").val();
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelInfo/updateRisk',
        data: $('#form').serialize(),
        beforeSend: function() {
            if($("#payChannelInfoRiskId").val() == ''){
                layer.msg('风控ID获取失败！',{icon:0,time:2000});
                return false;
            }

            var payTypeId = $("#payTypeId").val().trim();
            if(payChannelInfoId == ''){
                layer.msg('支付通道ID获取失败！',{icon:0,time:2000});
                return false;
            }
            if(payTypeId == ''){
                layer.msg('交易类型ID获取失败！',{icon:0,time:2000});
                return false;
            }

            var allowTime = $("#allowTime").val().trim();
            if(allowTime != ''){
                var regex = /(^(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))|(\|(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))/;
                if(!regex.test(allowTime)){
                    layer.msg('允许支付时间格式不正确！',{icon:0,time:2000});
                    return false;
                }
            }

            var allowNum = $("#allowNum").val().trim();
            var payInterval = $("#payInterval").val().trim();
            var singleMoney = $("#singleMoney").val().trim();
            var dayMoney = $("#dayMoney").val().trim();
            var userMostNumber = $("#userMostNumber").val().trim();
            if(allowTime == '' && allowNum == '' && payInterval == '' && singleMoney == '' && dayMoney == '' && userMostNumber == ''){
                layer.msg('请至少设置一项风控条件限制！',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    updateDialog.close();
                    $("#child_table"+payChannelInfoId).bootstrapTable('refresh');
                });
            } else {
                if (result.data instanceof Array) {
                    $.each(result.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.data,{icon:2});
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            layer.alert(textStatus,{icon:2});
        }
    });
}

</script>