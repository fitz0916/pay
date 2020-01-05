/**
 * input 输入框格式验证工具 zsl
 */

//验证接入费率，销售费率等涉及费率的格式(格式:小数点前面只能有一位，小数点后面最多8位)，用法：onpaste="return false" onkeyup="keyupRate(this)"
function keyupRate(event){
    var value = $(event).val();
    var regex = /[^\d.]/g;

    //只能输入数字和小数点的字符
    if(regex.test(value)){
        $(event).val($(event).val().replace(/[^\d.]/g,''));
    }else{
        //小数点不能为第一位
        if(value == '.'){
            $(event).val($(event).val().substr(0,value.length-1));
        }else{
            //小数点只允许存在一位
            if(value.split(".").length > 2){
                $(event).val($(event).val().substr(0,value.length-1));
                value = $(event).val();
            }
            //如果有小数点，则保留后八位 
            if(value.indexOf('.') > -1){
                var decimalValue = value.substr(value.indexOf('.')+1,value.length);
                if(decimalValue.length > 8){
                    $(event).val($(event).val().substr(0,value.length-1));
                }
                var intValue = value.substr(0,value.indexOf('.'));
                if(intValue.length > 1){
                    $(event).val($(event).val().substr(0,intValue.length-1));
                }
                
            }else{
                //如果没有小数点，则只能输入一位数字
                if(value.length > 1){
                    $(event).val($(event).val().substr(0,value.length-1));
                }
            }
        }
    }
}

//验证交易日限额等(格式:只能输入整数，不能输入已0开头的整数)，用法：onpaste="return false" onkeyup="keyupDaymoney(this)"
function keyupDaymoney(event){
    var value = $(event).val();
    var regex = /[^\d]/g;

    //只能输入数字
    if(regex.test(value)){
        $(event).val($(event).val().replace(/[^\d]/g,''));
    }else{
        //不能输入以0为开头的数字
        if(value == '0'){
            $(event).val('');
        }

        //去除以0开头的数字（防止用户输入正常数字后移动光标到首位输入0）
        if(event.value.substr(0,1) == '0'){
            event.value= event.value.substr(1,event.value.length);
        }
    }
}

//验证允许支付时间，允许代付时间等
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


//金额输入时验证(只允许保留两位小数点) 用法：onpaste="return false" onkeyup="keyupInputMoney(this)"
function keyupInputMoney(obj){

    //去除第一个字符是小数点的情况
    if(obj.value != '' && obj.value.substr(0,1) == '.'){
        obj.value="";
    }
    obj.value = obj.value.replace(/^0*(0\.|[1-9])/, '$1');//解决 粘贴不生效
    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数

    //以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额，不能大于8位数
    if(obj.value.indexOf(".") < 0 && obj.value != ""){
        if(obj.value.substr(0,1) == '0' && obj.value.length == 2){
            obj.value= obj.value.substr(1,obj.value.length);
        }
        if(obj.value.length > 8){
            obj.value= obj.value.substr(0,obj.value.length-1);
        }
    }
}



