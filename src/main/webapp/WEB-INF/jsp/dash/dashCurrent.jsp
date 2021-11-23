<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />

<style>
#invenBox {
	float: left;
	margin-right: 30px;
	width: 760px;
	height: 170px;
}

#archBox {
	display: inline-block;
	width: 760px;
	height: 170px;
	float: right;
}

#reducedH tr th {
	padding-top: 5px;
	padding-bottom: 5px;
}

#reducedH tr td {
	padding-top: 5px;
	padding-bottom: 5px;
}

td {
	border: 1px solid #d1d6e6;
}
</style>


<body>

	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<div class="main">

		<!-- MAIN CONTENT -->
		<div class="main-content">

			<div class="container-fluid" style="margin-top: 15px;">
				<div class="row">
					<div class="col-md-8">
						<div class="card" style="height: 830px;">
							<div class="card-body">
								<!-- METRICS -->
								<div id="map" style="height: 800px;">
								</div>
								<!-- END METRICS -->
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" style="height: 190px;">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h3 class="card-title">
									<span class="milestone-title">
										<i class="fas fa-industry"></i>
										<span>건물개요</span>
									</span>
								</h3>
							</div>

							<div style="margin: 10px;">
								<table id="reducedH" class="table table-project-tasks" style="border: 1px solid #d1d6e6;">
									<tr style="text-align: center">
										<td>건물명</td>
										<td id="cons_nm">-</td>
									</tr>
									<tr style="text-align: center">
										<td>주소</td>
										<td id="juso">-</td>
									</tr>
									<tr style="text-align: center">
										<td>재산관리관</td>
										<td id="prop_officer">-</td>
									</tr>
									<tr style="text-align: center">
										<td>건물용도</td>
										<td id="main_purps_nm">-</td>
									</tr>
									<tr style="text-align: center">
										<td>준공연도</td>
										<td id="useapr_day">-</td>
									</tr>
								</table>
							</div>
						</div>

						<div class="card" style="height: 126px;">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h3 class="card-title">
									<span class="milestone-title">
										<i class="fas fa-industry"></i>
										<span>온실가스 배출목표</span>
									</span>
								</h3>
							</div>

							<div style="margin: 10px;">
								<table id="reducedH" class="table table-project-tasks" style="border: 1px solid #d1d6e6;">
									<tr style="text-align: center">
										<td>
											25년 배출이용량(tCO<sub>2</sub>/m<sup>2</sup>)
										</td>
										<td id="allow_2025">-</td>
									</tr>
									<tr style="text-align: center">
										<td>
											25년 배출총량(tCO<sub>2</sub>/년)
										</td>
										<td id="emiss_2025">-</td>
									</tr>
								</table>
							</div>
						</div>

						<div class="card">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h3 class="card-title">
									<span class="milestone-title">
										<i class="fas fa-industry"></i>
										<span>2020년 온실가스 배출량 현황</span>
									</span>
								</h3>
							</div>
							<div style="margin: 10px">
								
								<table id="reducedH" class="table table-project-tasks" style="border: 1px solid #d1d6e6; margin: 0px;">
									<tr>
										<th></th>
										<th>에너지사용량</th>
										<th>온실가스</th>
									</tr>
									<tr>
										<td>합계</td>
										<td></td>
										<td id="tco2eq_t" style="text-align: right;">-</td>
									</tr>
									<tr>
										<td>전기</td>
										<td id="energy_use_e" style="text-align: right;">-</td>
										<td id="tco2eq_e" style="text-align: right;">-</td>
									</tr>
									<tr>
										<td>가스</td>
										<td id="energy_use_g" style="text-align: right;">
											-(m<sup>3</sup>)
										</td>
										<td id="tco2eq_g" style="text-align: right;">-</td>
									</tr>
									<tr>
										<td>지역난방</td>
										<td id="energy_use_l" style="text-align: right;">-(Gcal)</td>
										<td id="tco2eq_l" style="text-align: right;">-</td>
									</tr>
								</table>
							</div>
						</div>

						<div class="card">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h3 class="card-title">
									<span class="milestone-title">
										<i class="fas fa-industry"></i>
										<span id="chartTitle">2018년 인벤토리 추정치</span>
									</span>
								</h3>
							</div>
							<div class="col-lg-12">
								<div id="chartDiv1">
									<canvas id="chart" width="500" height="250"></canvas>
								</div>
								<div id="chartDiv2" style="display: none">
									<canvas id="chart2" width="500" height="250"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- END WRAPPER -->

	<script src="/resources/openlayers/ol.js"></script>
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<!-- DASH.JS -->
	<script src="/resources/js/useEmission.js"></script>
	<!-- Chart.js -->
	<script src="/resources/js/chart.js"></script>
	
	
<script>
var dynamicColors = function() {
	var r = Math.floor(Math.random() * 255);
	var g = Math.floor(Math.random() * 255);
	var b = Math.floor(Math.random() * 255);
	return "rgb(" + r + "," + g + "," + b + ",0.7)";
};

var chart;
var chart2;
var color = Chart.helpers.color;
var currChart = 1;

$(document).ready(function(){
	lotationChart();  
 	setInterval(function(){
   	lotationChart()
	}, 1000 * 10    )  
})

function lotationChart(){
	if(currChart == 1){
		$("#chartDiv1").css("display","")
		$("#chartDiv2").css("display","none")
		if(chart2 != undefined){
			chart2.destroy();
		}
		var param = {year : "2020"};
			callAjax("${pageContext.request.contextPath}/invenCal/invenCal003_search.do", true, 'json', param, function(data){
			console.log(data);
			createChartData(data);
			$("#chartTitle").html("2020년 추정");
		})
		currChart = 2;
	} else {
		$("#chartDiv1").css("display","none")
		$("#chartDiv2").css("display","")
		if(chart != undefined){
		   chart.destroy();
		}
		var param = {util : "2018", UP_INV_ENG_POINT_CD : "0"};
		console.log("param", param);
		callAjax("${pageContext.request.contextPath}/inven/inven001_search_chart.do",true,'json',param, function(data) {
		   console.log("2018 data", data);            
		   createChartData_Bar(data);
		   $("#chartTitle").html("2018년 확정");
		});
		currChart = 1;
	}
}



	function createChartData_Bar(data) {

		var utilList = "2018";
		type = "2018"
		var mode = 1;

		var dataset = new Array();
		var timeset = new Array();
		var tempArr = new Array();
		var tempTimeArr = new Array();
		var uniArr = new Array();
		for (key in data) {
			tempArr.push(data[key]["INV_ENG_POINT_NM_1"]);
		}

		$.each(tempArr, function(i, value) {
			if (uniArr.indexOf(value) == -1)
				uniArr.push(value);
		});

		var TYPE_DATA = new Array();
		var dColorArrAlpha = new Array();
		var dColorArr = new Array();
		var dColor = "";
		for (key in uniArr) {
			var jsonData = getJsonFilter(data, "INV_ENG_POINT_NM_1",
					uniArr[key]);
			dColor = dynamicColors();
			dColorArrAlpha.push(color(dColor).alpha(0.5).rgbString());
			dColorArr.push(dColor);

			for (inKey in jsonData) {
				var value = jsonData[inKey]["GHG_VAL_" + type];
				TYPE_DATA.push(value)
			}
		}

		dataset.push({
			label : "tCO" + "\u2082",
			data : TYPE_DATA,
			backgroundColor : dColorArrAlpha,
			borderColor : dColorArr,
			fill : false
		})

		createChartBar(dataset, uniArr);
	}

	
	function createChartBar(dataset, tempTimeArr) {
		if (chart2 != undefined) {
			chart2.destroy();
		}

		chart2 = new Chart(
			$("#chart2"),
			{
				type : 'bar',
				data : {
					labels : tempTimeArr,
					datasets : dataset
				},
				options : {

					responsive : false,
					scales : {
						xAxes : [ {
							ticks : {
								beginAtZero : true,
								fontSize : 12
							}

						} ],
						yAxes : [ {
							ticks : {
								fontSize : 12,
								min : 0
							}
						} ]
					},
					legend : {
						display : true,
						position : 'right',
					},
					animation : false,
					tooltips : {
						enabled : true,
						mode : 'single',
						callbacks : {
							label : function(tooltipItems, data) {
								return data["datasets"][tooltipItems.datasetIndex]["label"]
										+ " : "
										+ num_comma(tooltipItems.value);
							}
						}
					}
				}
			});
	}

	
	function createChartData(data) {
		var dataset = new Array();
		var labelArr = new Array();

		labelArr.push("에너지");
		labelArr.push("폐기물");
		labelArr.push("산업공정 및 제품생산");
		labelArr.push("농업, 산림 및 기타 토지이용");

		var dColor1 = dynamicColors();
		var dColor2 = dynamicColors();

		dataset.push({
			type : 'bar',
			label : "배출량합계(tCO\u2082)",
			yAxisID : 'y-axis-1',
			data : [ getJsonFilter(data, "ENG_CODE", "ENG_TOT")[0]["GHG_VAL"],
					getJsonFilter(data, "ENG_CODE", "WASTE")[0]["GHG_VAL"],
					getJsonFilter(data, "ENG_CODE", "I_TOT")[0]["GHG_VAL"],
					getJsonFilter(data, "ENG_CODE", "F_TOT")[0]["GHG_VAL"] ],
			backgroundColor : color(dColor1).alpha(0.5).rgbString(),
			borderColor : dColor1,
			fill : false
		})

		dataset
			.push({
				type : 'line',
				label : '3년 평균비중(%)',
				yAxisID : 'y-axis-2',
				data : [
						getJsonFilter(data, "ENG_CODE", "ENG_TOT")[0]["YEAR_VAL_RATIO"]
								.replace(/%/gi, ""),
						getJsonFilter(data, "ENG_CODE", "WASTE")[0]["YEAR_VAL_RATIO"]
								.replace(/%/gi, ""),
						getJsonFilter(data, "ENG_CODE", "I_TOT")[0]["YEAR_VAL_RATIO"]
								.replace(/%/gi, ""),
						getJsonFilter(data, "ENG_CODE", "F_TOT")[0]["YEAR_VAL_RATIO"]
								.replace(/%/gi, "") ],
				backgroundColor : color(dColor2).alpha(0.5).rgbString(),
				linetenstion : 0.2,
				borderColor : dColor2,
				fill : false
			})
		createChart(dataset);
	}

	
	function createChart(dataset) {

		if (chart != undefined) {
			chart.destroy();
		}
		var chartData = {
			labels : [ '에너지', '폐기물', '산업공정 및 제품생산', '농업, 산림 및 기타 토지이용' ],
			datasets : dataset
		}

		chart = new Chart(
			$("#chart"),
			{
				type : 'bar',
				data : chartData,
				options : {

					responsive : false,
					scales : {
						yAxes : [ {
							type : 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
							display : true,
							position : 'left',
							id : 'y-axis-1',
							ticks : {
								fontSize : 12
							}
						}, {
							type : 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
							display : true,
							position : 'right',
							id : 'y-axis-2',
							ticks : {
								fontSize : 12
							},
							gridLines : {
								drawOnChartArea : false
							}
						} ],
						xAxes : [ {
							ticks : {
								fontSize : 10
							}
						} ]
					},
					title : {
						display : false,
						text : '',
					},
					animation : false,
					legend : {
						display : true,
						position : 'right',
						"labels" : {
							"fontSize" : 15,
						}
					},
					tooltips : {
						enabled : true,
						mode : 'single',
						callbacks : {
							label : function(tooltipItems, data) {
								return data["datasets"][tooltipItems.datasetIndex]["label"]
										+ " : "
										+ num_comma(tooltipItems.value);
							}
						}
					}
				}
			});
	}
</script>
</body>
</html>