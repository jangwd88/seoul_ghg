<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<style>
.merge {
	background-color: #FF0;
	color: #03F;
	text-align: center
}

table td {
	vertical-align: middle !important;
	text-align: center !important;
	border: 1px solid #ccc !important;
}

.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000'); /* ie */
}

.wrap-loading div { /*로딩 이미지*/
	position: fixed;
	top: 50%;
	left: 50%;
	margin-left: -21px;
	margin-top: -21px;
}

.display-none { /*감추기*/
	display: none;
}
</style>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/common/common.js"></script>
</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<script src="/resources/openlayers/ol.js"></script>

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
	vertical-align: middle !important;
}

.nm-td{
	min-width:140px;
}
</style>
<script>
var globalToTData; 
	var backColor = [	window.chartColors.red,
		window.chartColors.orange,
		window.chartColors.yellow,
		window.chartColors.green,
		window.chartColors.blue]


	var dynamicColors = function() {
		var r = Math.floor(Math.random() * 255);
		var g = Math.floor(Math.random() * 255);
		var b = Math.floor(Math.random() * 255);
		return "rgb(" + r + "," + g + "," + b + ",0.7)";
	};
	
	var globalSearchData;
	var reportJsonData = "";
	function search() {
		if($("#util").val() == ""){
			 alert("조회기간을 선택해 주세요.");
			 return;
		}
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/inven/inven001_search.do",false,'json',param, function(data) {
			globalToTData = data;
			var utilList = $("#util").val() != null && $("#util").val() != "" ? $("#util").val().split(",") : "";

			reportJsonData = JSON.stringify(data);
			
			$("#listTable").html("");
			var tr = "<tbody>";
			tr += '<tr align="center">';
			tr += '<td rowspan="2" style="word-break: normal;">배출원</td>';
			tr += '<td rowspan="2" style="word-break: normal;">배출원</td>';
			tr += '<td rowspan="2" style="word-break: normal;">배출원</td>';
			tr += '<td rowspan="2" style="word-break: normal;">배출원</td>';
			for (var i = 0; i < utilList.length; i++) {
				tr += '<td style="word-break: normal;" align="center">' + data[0]["FIX_YN_" + utilList[i]] + '</td>';
			}
			tr += '</tr> ';
			tr += '<tr>';
			for (var i = 0; i < utilList.length; i++) {
				tr += '<td style="word-break: normal;" align="center">' + utilList[i] + '년</td>';
			}
			tr += '</tr> ';

			var isNoData = true;
			for (key in data) {
				isNoData = false;
				tr += '<tr>'
				tr += '<td style="cursor: hand;" align="center" onClick="javascript:inven001_search_chart(\''+data[key]["UP_INV_ENG_POINT_CD"]+'\');">' + data[key]["INV_ENG_POINT_NM_1"] + '</td>'
				tr += '<td style="cursor: hand;" align="center" onClick="javascript:inven001_search_chart(\''+data[key]["UP_INV_ENG_POINT_CD"]+'\');">' + data[key]["INV_ENG_POINT_NM_2"] + '</td>'
				tr += '<td style="cursor: hand;" align="center" onClick="javascript:inven001_search_chart(\''+data[key]["UP_INV_ENG_POINT_CD"]+'\');">' + data[key]["INV_ENG_POINT_NM_3"] + '</td>'
				tr += '<td align="center">' + data[key]["INV_ENG_POINT_NM_4"] + '</td>'
				for (var i = 0; i < utilList.length; i++) {
					tr += '<td align="right">' + num_comma(data[key]["GHG_VAL_" + utilList[i]]) + '</td>';
				}
				tr += '</tr> '
			}

			if (isNoData) {
				var searchYearCnt = utilList.length;
				tr += '<tr>'
				tr += '<td colspan="' + (searchYearCnt + 4) + '">조회된 데이터가 없습니다.</td>'
				tr += '</tr>'
			}
			tr += '</tbody>'
			$("#listTable").append(tr);
			
			$('table tbody tr:visible').each(function(row) {
				$('#listTable').colspan(row, 4);
			});
		
			$('table tbody tr:visible').each(function(cols) {
				$('#listTable').rowspan(cols, 4);
			});

		});
		
		inven001_search_chart("0");	
	}
	
	function inven001_search_chart(UP_INV_ENG_POINT_CD){
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/inven/inven001_search_chart.do?UP_INV_ENG_POINT_CD="+UP_INV_ENG_POINT_CD,true,'json',param, function(data) {
			globalSearchData = data;
			
			createChartData_Line(data, "GHG_VAL");
		});
	}

	function createChartData_Line(data, type, utilList) {
		var utilList = $("#util").val() != null && $("#util").val() != "" ? $("#util").val().split(",") : "";
		var mode = 1;

		var dataset = new Array();
		var timeset = new Array();
		var tempArr = new Array();
		var tempTimeArr = new Array();
		var uniArr = new Array();
		for (key in data) {
			tempArr.push(data[key]["INV_ENG_POINT_NM_1"]);
		}
		
		for (i = 0; i < utilList.length; i++) {
			var unit = "년";
			tempTimeArr.push(utilList[i]+unit);
		}

		$.each(tempArr, function(i, value) {
			if (uniArr.indexOf(value) == -1)
				uniArr.push(value);
		});
		var jsonData = getJsonFilter(globalToTData, "INV_ENG_POINT_NM_1", '합계');
		var TYPE_DATA = new Array();
		for (i = 0; i < utilList.length; i++) {
			var value = jsonData[0][type + "_" + utilList[i]];
			TYPE_DATA.push(value.replace('<br/>','') )
		}
		
		dataset.push({
			label : '합계',
			data : TYPE_DATA,
			backgroundColor : color(backColor[5]).alpha(0.5).rgbString(),
			borderColor : backColor[5],
			fill :false,
			legend: {
		        display: false
		    },
			yAxisID: 'y-axis-1',
		})
		
		for (key in uniArr) {
			var jsonData = getJsonFilter(data, "INV_ENG_POINT_NM_1", uniArr[key]);
			var TYPE_DATA = new Array();
			for (inKey in jsonData) {
				for (i = 0; i < utilList.length; i++) {
					var value = jsonData[inKey][type + "_" + utilList[i]];
					TYPE_DATA.push(value )
				}
			}
			var dColor = dynamicColors();
			dataset.push({
				label : uniArr[key],
				data : TYPE_DATA,
				backgroundColor : color(backColor[key]).alpha(0.5).rgbString(),
				borderColor : backColor[key],
				fill :false,
				yAxisID: 'y-axis-1',
			})
			
		}
		
		
		createChartLine(dataset, tempTimeArr);
	}
	
</script>

<body>

	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar3.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid" style="margin-top: 15px;">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card">
							<form name="searchFrm" id="searchFrm">
								<div class="project-heading">
									<hr class="hrSelect">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">조회기간</span> <input type="hidden" name="util" id="util">
											<button type="button" class="btn btn-primary" aria-expanded="false" id="invenBtn" onclick="openModal('modalPop_001')">선택</button>
										</div>
										<div class="checkDiv"></div>
										<div class="checkDiv"></div>
										<div class="checkDiv">
											<div class="text-right">
												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button>
											</div>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-12">
									<canvas id="chart" width="1600" height="300"></canvas>
								</div>
							</div>
							<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
								<!-- <button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">엑셀다운로드</button> -->
								<!-- report button 20201224 solbitech yyc -->
								<!-- button type="button" class="btn btn-primary" aria-expanded="false" id="goReport" onclick="goReport();">리포트출력</button> -->
								&nbsp;
							</div>
							<div class="row">
								<div class="col-lg-12" style="max-height: 420; overflow-y: auto">
									<table id="listTable" class="table table-striped table-project-tasks">
										<tr>
											<td style="word-break: normal;">배출원</td>
											<td style="word-break: normal;">배출원</td>
											<td style="word-break: normal;">배출원</td>
											<td style="word-break: normal;">배출원</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal" tabindex="-1" id="modalPop_001">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">조회기간</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 400px;">
					<table class="table table-striped table-project-tasks">
						<tr onclick="checkLine('all')">
							<td><input type="checkbox" value="all" id="all" name="INVEN_RADIO"></td>
							<td>전체</td>
						</tr>
						<c:forEach items="${yearList}" var="list" varStatus="status">
							<tr onclick="checkLine('INVEN_${status.index}')">
								<td><input type="checkbox" value="${list.YYYY}" id="INVEN_${status.index}" class="tempYYYYs"></td>
								<td>${list.YYYY}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="confirmStat('modalPop_001')">확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		$(".modal-dialog").draggable({
			handle : ".modal-header"
		})
		<!-- make modal draggable -->
	</script>

	<!-- END WRAPPER -->
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<!-- DASH.JS -->
	<script src="/resources/js/useEmissionSub.js"></script>
	
	<script>
		var chart;
		var chart2;
		var color = Chart.helpers.color;
		$(document).ready(function() {
			$(".tempYYYYs").prop("checked",true);
			$("#all").prop("checked",true);
			
			confirmStat('modalPop_001');
			
			search();
			
			createChartLine();
			
			/* $('table tbody tr:visible').each(function(row) {
				$('#listTable').colspan(row, 4);
			});
			
			$('table tbody tr:visible').each(function(cols) {
				$('#listTable').rowspan(cols, 4);
			}); */				
		})

		function excelExport() {
			ExcellentExport.excel(this, 'listTable', "부문별조회", "부문별조회", "name");
		}
		
		/* <!-- report function 20201224 solbitech yyc --> */
		function goReport(){
			
			if(reportJsonData == ""){
				alert('데이터를 먼저 조회하세요.');
				return;
			}
			
			$('#jsonData').val(reportJsonData);
			$('#report_util').val($("#util").val());
			
			var title = "report";
			window.open("", title, "width=1200, height=930, top=30 left=200");
			var frm = $('#aiForm');
			frm.attr('target', title);
			frm.attr('action', '/AISERVER');
			frm.submit();
			
		}
		
		
		function confirmStat(id) {
			if (id == "modalPop_001") {
				var len = $('.tempYYYYs:checked').length;
				var name ="";
				for(var i=0;i<len;i++){
					if(i==3){
						break;
					}
					name += $('.tempYYYYs:checked').eq(i).parent().next().html() + "년,";
				}
				name = name.substr(0,name.lastIndexOf(","));
				
				if(len > 3){
					$("#invenBtn").html(name+"외 "+(len-3)+" 건");	
				}else{
					$("#invenBtn").html(name);	
				}

				var value = "";
				for (var i = 0; i < len; i++) {
					value += $('.tempYYYYs:checked').eq(i).val() + ",";
				}
				value = value.substr(0, value.lastIndexOf(","));
				$("#util").val(value);
				
				if(len == 0){
					$("#invenBtn").html("선택");
				}
			}
			$("#" + id).modal('hide');
		}

		function openModal(id) {
			$("#" + id).modal('show');
		}

		function checkLine(id) {
			var type= $(event.srcElement).attr("type") == undefined ? "" :$(event.srcElement).attr("type");
			var checkpoint = $(event.srcElement).val() == "all" ? true : false;
			if(type.indexOf("checkbox") > -1 ){
				var checked = $(event.srcElement).is(":checked"); 
				if(checkpoint){
					$(".tempYYYYs").prop("checked",checked);
				}
				if(!checked){
					$("#all").prop("checked",false);
				}
			}else{
				var checked = $("#"+ id).is(":checked"); 
				if(id == 'all'){
					$(".tempYYYYs").prop("checked",!checked);
				}else{
					$("#all").prop("checked",false);
				}
				$("#"+ id).prop("checked",!checked);
			}
			
			
		}
		
		function createChartLine(dataset, tempTimeArr) {
			if(chart != undefined){
				chart.destroy();
			}
			
			chart = new Chart($("#chart"),
					{
						type : 'line',
						data : {
							labels : tempTimeArr,
							datasets : dataset
						},
						options : {
							responsive : false,
							scales : {
								yAxes : [ {
									id:'y-axis-1',
									scaleLabel: {
								           display: true,
								           labelString: 'tCO2'
								         },
									ticks : {
										beginAtZero : true,
										fontSize : 10
									}
								}/* ,{
									id:'y-axis-2',
									position: 'right',
								   
									scaleLabel: {
								           display: true,
								           labelString: 'tCO2 합계'
								         },
									ticks : {
										fontSize : 10
									}
								} */ 
								]
							},
							title : {
								display : true,
								text : '',
							},
							animation : false,
							legend : {
								display : true,
								position : 'bottom',
							},
							  tooltips: {
				                     enabled: true,
				                     mode: 'single',
				                     callbacks: {
				                              label: function (tooltipItems, data) {
				                                   return  data["datasets"][tooltipItems.datasetIndex]["label"] + " : " + num_comma(tooltipItems.value);
				                              }
				                     }
								}

						}
					});			
			
		}
		
		/*   
		 * 같은 값이 있는 열을 병합함  
		 * 사용법 : $('#테이블 ID').rowspan(0);  
		 */
		$.fn.rowspan = function(colIdx, t_col, isStats) {
			return this.each(function() {
				var that;
				$('tr', this).each(function(row) {
					$('td', this).eq(colIdx).filter(':visible').each(function(col) {
						if ($(this).html() == $(that).html() && (!isStats || isStats && $(this).prev().html() == $(that).prev().html())) {
							if(colIdx < t_col){
							rowspan = $(that).attr("rowspan") || 1;
							rowspan = Number(rowspan) + 1;
							$(that).attr("rowspan",rowspan);
							// do your action for the colspan cell here              
							$(this).hide();
							//$(this).remove();   
							// do your action for the old cell here
							}

						} else {
							that = this;
						}
						// set the that if not already set  
						that = (that == null) ? this : that;
					});
				});
			});
		};

		/*   
		 * 같은 값이 있는 행을 병합함  
		 * 사용법 : $('#테이블 ID').colspan (0);  
		 */
		 $.fn.colspan = function(rowIdx, t_col) {
				return this.each(function() {
					var that;
					$('tr', this).filter(":eq(" + rowIdx + ")").each(function(row) {					
						$(this).find('td').filter(':visible').each(function(col) {
							if(col < t_col) {
								if ($(this).html() == $(that).html()) {
									colspan = $(that).attr("colSpan");
									if (colspan == undefined) {
										$(that).attr("colSpan", 1);
										colspan = $(that).attr("colSpan");
									}
									colspan = Number(colspan) + 1;
									$(that).attr("colSpan", colspan);
									$(this).hide(); // .remove();
								} else {
									that = this;
								}
								that = (that == null) ? this : that; // set the that if not already set
							}
						});
					});

				});
			}
		 
			
	</script>

</body>
</html>