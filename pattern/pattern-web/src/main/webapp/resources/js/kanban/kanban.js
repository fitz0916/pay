/**
 * 刷新报表
 *
 * @param startDate
 * @param endDate
 */
function freshChartDate(startDate, endDate) {
    $.ajax({
        type : 'GET',
        url : '/pattern/kanban/orders',
        data : {
            'startDate':startDate.format('YYYY-MM-DD HH:mm:ss'),
            'endDate':endDate.format('YYYY-MM-DD HH:mm:ss')
        },
        dataType : "json",
        success : function(data){
            lineChartInit(data)
        }
    });
}

function fresh(startDate,endDate) {

}

function freshOrderPie(startDate, endDate) {
    $.ajax({
        type : 'GET',
        url : '/pattern/kanban/pieChart',
        data : {
            'startDate':startDate.format('YYYY-MM-DD HH:mm:ss'),
            'endDate':endDate.format('YYYY-MM-DD HH:mm:ss')
        },
        dataType : "json",
        success : function(data){
            orderPieInit(data)
            fansPieInit(data)
        }
    });
}

/**
 * 折线图
 */
function lineChartInit(data) {
    // console.log(data.content)
    var option = {
        title: {
            text: '日期分布图'
        },
        tooltip : {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                label: {
                    backgroundColor: '#6a7985'
                }
            }
        },
        legend: {
            data:['出纸数','粉丝数']
        },
        toolbox: {
            feature: {
                /*saveAsImage: {}*/
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                boundaryGap : false,
                data : data.days
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'出纸数',
                type:'line',
                // stack: '总量',
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                data: data.orderCountList
            },
            {
                name:'粉丝数',
                type:'line',
                // stack: '总量',
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                data: data.fansCountList
            }
        ],
        color:['#00A65A', '#F39C12']
    };

    var lineChart = echarts.init(document.getElementById('lineChart'));
    lineChart.setOption(option);
}

function orderPieInit(data) {
    var option = {
        title : {
            text: '领纸比例图',
            /*subtext: 'subtext',*/
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['送纸数量','购纸数量']
        },
        series : [
            {
                name: '分布比例',
                type: 'pie',
                radius : '45%',
                center: ['60%', '60%'],
                data:[
                    {
                        value:data.givePaperCount,
                        name:'送纸数量'
                    },
                    {
                        value:data.buyOrderCount,
                        name:'购纸数量'
                    }
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ],
        color:['#00A65A', '#F39C12']
    };
    var orderPieChart = echarts.init(document.getElementById('orderPie'));
    orderPieChart.setOption(option);
}

function fansPieInit(data) {
    var option = {
        title : {
            text: '粉丝比例图',
            /*subtext: 'subtext',*/
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['关注数量','取关数量']
        },
        series : [
            {
                name: '分布比例',
                type: 'pie',
                radius : '45%',
                center: ['60%', '60%'],
                data:[
                    {
                        value:data.fansIncrease,
                        name:'关注数量'
                    },
                    {
                        value:data.fansCancel,
                        name:'取关数量'
                    }
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ],
        color:['#4876FF', '#8E8E8E']
    };
    var fansPieChart = echarts.init(document.getElementById('fansPie'));
    fansPieChart.setOption(option);
}