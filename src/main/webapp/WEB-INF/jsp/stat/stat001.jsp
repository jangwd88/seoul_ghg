<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

input[type="radio"] {
	-webkit-appearance: checkbox !important; /* Chrome, Safari, Opera */
	-moz-appearance: checkbox !important; /* Firefox */
	-ms-appearance: checkbox !important; /* not currently supported */
}

.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
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
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="/resources/openlayers/ol.js"></script>
<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/common/common.js"></script>
<script src="/resources/js/excelExport/excellentexport.js"></script>
<script>
	var dynamicColors = function() {
		var r = Math.floor(Math.random() * 255);
		var g = Math.floor(Math.random() * 255);
		var b = Math.floor(Math.random() * 255);
		return "rgb(" + r + "," + g + "," + b + ",0.7)";
	};
	var globalSearchData;
	function search() {
		if($("#util").val() == ""){
			alert("건물 용도를 선택해 주세요.");
			return;
		}
		if($("#start_year").val() == ""){
			alert("조회기간을 선택해 주세요.");
			$("#start_year").focus();
			return;
		}
		if($("#end_year").val() == ""){
			alert("조회기간을 선택해 주세요.");
			$("#end_year").focus();
			return;
		}
		var startVar = null;
		var endVar = null;
		if ($("#acu").val() == "1") {
			if ($("#start_year").val() == "" || $("#end_year").val() == "") {
				$("#start_year").val("${minMaxYear.MIN_YYYY}");
				$("#end_year").val("${minMaxYear.MAX_YYYY}");
			}
			startVar = parseInt($("#start_year").val());
			endVar = parseInt($("#end_year").val());
		} else if ($("#acu").val() == "2") {
			if ($("#start_year").val() == "" || $("#end_year").val() == "") {
				$("#start_year").val("${minMaxYear.MAX_YYYY}");
				$("#end_year").val("${minMaxYear.MAX_YYYY}");
			}
			if ($("#start_month").val() == "" || $("#end_month").val() == "") {
				$("#start_month").val("01");
				$("#end_month").val("12");
			}
			startVar = parseInt($("#start_month").val());
			endVar = parseInt($("#end_month").val());
		}
		$("#end_year").prop("disabled", false);
		if ($("#start_totarea").val() != "" && $("#end_totarea").val() == "") {
			alert("연면적을 모두 입력해 주세요.");
			return;
		} else if ($("#start_totarea").val() == ""
				&& $("#end_totarea").val() != "") {
			alert("연면적을 모두 입력해 주세요.");
			return;
		}
		if ($("#start_permission").val() != ""
				&& $("#end_permission").val() == "") {
			alert("노후도를 모두 입력해 주세요.");
			return;
		} else if ($("#start_permission").val() == ""
				&& $("#end_permission").val() != "") {
			alert("노후도를 모두 입력해 주세요.");
			return;
		}
		var param = $("#searchFrm").serialize();
		callAjax(
				"${pageContext.request.contextPath}/stat/stat001_search.do",
				true,
				'json',
				param,
				function(data) {

					globalSearchData = data;
					$("#tHeader1").remove();
					$("#tHeader2").remove();
					$("#tHeader3").remove();
					$(".data").remove();
					var tr = "";
					tr += '<tr id="tHeader1">';
					tr += '<td rowspan="3" style="width: 200px; padding-left: 0px; word-break: normal;">용도</td>';
					var colspanCnt = 0;
					if ($("input[name='energy0']").prop("checked") == true) {
						colspanCnt += 1;
					}
					if ($("input[name='energy1']").prop("checked") == true) {
						colspanCnt += 1;
					}
					if ($("input[name='energy2']").prop("checked") == true) {
						colspanCnt += 1;
					}
					for (i = startVar; i <= endVar; i++) {
						tr += '<td colspan="'
								+ ((2 * colspanCnt) + 1)
								+ '" style="padding-left: 0px; word-break: normal;">'
								+ i + $("#acu option:selected").text()
								+ '</td>';
					}
					tr += '</tr>';
					tr += '<tr id="tHeader2">';

					for (i = startVar; i <= endVar; i++) {
						tr += '<td style="padding-left: 0px; word-break: normal;">합계</td>';
						if ($("input[name='energy0']").prop("checked") == true) {
							tr += '<td colspan="2" style="padding-left: 0px; word-break: normal;">전기</td>';
						}
						if ($("input[name='energy1']").prop("checked") == true) {
							tr += '<td colspan="2" style="padding-left: 0px; word-break: normal;">가스</td>';
						}
						if ($("input[name='energy2']").prop("checked") == true) {
							tr += '<td colspan="2" style="padding-left: 0px; word-break: normal;">지역난방</td>';
						}
					}
					tr += '</tr>';
					tr += '<tr id="tHeader3">';
					for (i = startVar; i <= endVar; i++) {
						tr += '<td style="padding-left: 0px; word-break: normal;">tCO₂</td>';
						if ($("input[name='energy0']").prop("checked") == true) {
							tr += '<td style="padding-left: 0px; word-break: normal;">MWh</td>';
							tr += '<td style="padding-left: 0px; word-break: normal;">tCO₂</td>';
						}
						if ($("input[name='energy1']").prop("checked") == true) {
							tr += '<td style="padding-left: 0px; word-break: normal;">1000㎥</td>';
							tr += '<td style="padding-left: 0px; word-break: normal;">tCO₂</td>';
						}
						if ($("input[name='energy2']").prop("checked") == true) {
							tr += '<td style="padding-left: 0px; word-break: normal;">Gcal</td>';
							tr += '<td style="padding-left: 0px; word-break: normal;">tCO₂</td>';
						}
					}
					tr += '</tr>';
					var dataset = new Array();
///////dddd
					for (key in data) {
						tr += '<tr class="data">'
						tr += '<td>' + data[key]["MAIN_PURPS_NM"] + '</td>'
						for (i = startVar; i <= endVar; i++) {
							tr += '<td>'
								+ num_comma((parseInt(data[key]["E_TCO2EQ_" + i]) + parseInt(data[key]["G_TCO2EQ_" + i]) + parseInt(data[key]["H_TCO2EQ_" + i])).toFixed(0)) + '</td>';
							if ($("input[name='energy0']").prop("checked") == true) {
								tr += '<td>'
										+ num_comma(data[key]["E_TOE_" + i].toFixed(0)) + '</td>';
								tr += '<td>'
										+ num_comma(data[key]["E_TCO2EQ_" + i].toFixed(0)) + '</td>';
							}
							if ($("input[name='energy1']").prop("checked") == true) {
								tr += '<td>'
										+ num_comma(data[key]["G_TOE_" + i].toFixed(0)) + '</td>';
								tr += '<td>'
										+ num_comma(data[key]["G_TCO2EQ_" + i].toFixed(0)) + '</td>';
							}
							if ($("input[name='energy2']").prop("checked") == true) {
								tr += '<td>'
										+ num_comma(data[key]["H_TOE_" + i].toFixed(0)) + '</td>';
								tr += '<td>'
										+ num_comma(data[key]["H_TCO2EQ_" + i].toFixed(0)) + '</td>';
							}
						}
						tr += '</tr>';
					}

					if (data.length == 0) {
						tr += '<tr class="data">'
						tr += '<td colspan="8">검색 결과가 존재하지 않습니다.</td>'
						tr += '</tr>'
					}

					$("#listTable").append(tr);

					createChartData(data, $("#TYPE").val(), startVar, endVar);

					$('#listTable tr:visible').each(function(row) {
						$('#listTable').colspan(row, 1);
					});
					$('#listTable tr:visible').each(function(col) {
						$('#listTable').rowspan(col, 1);
					});
				})
		$("#end_year").prop("disabled", false);
	}

	function createChartData(data, type, startVar, endVar) {
		console.log(data)
		console.log(type)
		var mode = $("#acu").val();

		var dataset = new Array();
		var timeset = new Array();
		var tempArr = new Array();
		var tempTimeArr = new Array();
		var uniArr = new Array();
		for (key in data) {
			tempArr.push(data[key]["MAIN_PURPS_NM"]);
		}

		for (i = startVar; i <= endVar; i++) {
			var unit = mode == 1 ? "년" : "월";
			tempTimeArr.push(i + unit);
		}

		$.each(tempArr, function(i, value) {
			if (uniArr.indexOf(value) == -1)
				uniArr.push(value);
		});

		var dColor = ['rgb(231,172,112,0.7)', 'rgb(141,151,92,0.7)', 'rgb(68,44,194,0.7)', 'rgb(184,109,205,0.7)', 'rgb(87,65,126,0.7)', 'rgb(127,231,79,0.7)', 'rgb(208,24,204,0.7)', 'rgb(203,168,29,0.7)', 'rgb(46,159,228,0.7)', 'rgb(66,248,49,0.7)', 'rgb(205,47,82,0.7)', 'rgb(73,159,172,0.7)', 'rgb(197,43,198,0.7)', 'rgb(128,31,7,0.7)', 'rgb(55,77,81,0.7)', 'rgb(57,151,3,0.7)', 'rgb(187,32,199,0.7)', 'rgb(76,138,195,0.7)', 'rgb(222,210,20,0.7)', 'rgb(19,239,156,0.7)', 'rgb(188,42,22,0.7)', 'rgb(214,86,144,0.7)', 'rgb(65,8,31,0.7)', 'rgb(106,240,187,0.7)', 'rgb(184,203,250,0.7)', 'rgb(29,53,109,0.7)', 'rgb(3,76,13,0.7)'];
		for (key in uniArr) {
			var jsonData = getJsonFilter(data, "MAIN_PURPS_NM", uniArr[key]);
			var TYPE_DATA = new Array();
			for (inKey in jsonData) {
				for (i = startVar; i <= endVar; i++) {
					TYPE_DATA.push(jsonData[inKey][type + "_" + i])
				}
			}
			/* var dColor = dynamicColors(); */
			dataset.push({
				label : uniArr[key],
				data : TYPE_DATA,
				backgroundColor : color(dColor[key]).alpha(0.5).rgbString(),
				borderColor : dColor[key],
			})
		}
		createChart(dataset, tempTimeArr);
	}

	function pickAll(ele) {
		for (i = 0; i < 3; i++) {
			if ($(ele).is(":checked")) {
				$("input[name='energy" + i + "']").prop("checked", true)
			} else {
				$("input[name='energy" + i + "']").prop("checked", false)
			}
		}
	}
</script>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">주제별 사용 통계</h1>
					<p class="page-subtitle">서울특별시 건축물 주제별 에너지 사용량 통계</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">온실가스 배출통계</li>
						<li class="breadcrumb-item active">
							<a href="/stat/stat001.do">주제별 사용 통계</a>
						</li>
					</ol>
				</nav>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card">
							<form name="searchFrm" id="searchFrm">
								<div class="project-heading">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">에너지원</span>
											<label class="type-label" for="energy_all"> 
												<input type="checkbox" checked="checked" id="energy_all" value="all" onchange="pickAll(this)">
												전체
											</label>
											<c:forEach var="item" items="${ENERGY_TYPE}" varStatus="status">
												<label class="type-label" for="energy${status.index}"> 
													<input type="checkbox" checked="checked" name="energy${status.index}" id="energy${status.index}" value="${item.CODE}">
													${item.VALUE}
												</label>
											</c:forEach>
											<%-- <select class="" id="energy_type" name="energy_type">
												<option value="" selected>전체</option>
												
													<option value="${item.CODE}">${item.VALUE}</option>
												</c:forEach>
											</select> --%>
										</div>
										<div class="checkDiv" style="width: 800px">
											<span class="type-name">건물 용도</span>
											<input type="hidden" name="util" id="util">
											<button type="button" class="btn btn-primary" aria-expanded="false" id="statBtn" onclick="openModal('modalPop_001')">선택</button>
										</div>
									</div>
									<hr class="hrSelect">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">연면적(m<sup>2</sup>)</span>
											<input type="number" name="start_totarea" id="start_totarea" style="width: 80px;" placeholder="값 입력"/>
											<span>이상 ~ </span>
											<input type="number" name="end_totarea" id="end_totarea" style="width: 80px;" placeholder="값 입력"/ /><span> </span>
											<span>미만</span>
										</div>
										<div class="checkDiv">
											<span class="type-name">노후도(년)</span>
											<input type="number" name="start_permission" id="start_permission" style="width: 80px;" placeholder="값 입력"/ />
											<span>이상 ~ </span>
											<input type="number" name="end_permission" id="end_permission" style="width: 80px;" placeholder="값 입력"/ /><span> </span>
											<span>미만</span>
										</div>
									</div>
									<hr class="hrSelect">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">조회단위</span>
											<select class="" id="acu" name="acu">
												<c:forEach var="item" items="${ACU}">
													<option value="${item.CODE}">${item.VALUE}</option>
												</c:forEach>
											</select>
										</div>
										<div class="checkDiv">
											<span class="type-name">조회기간</span>
											<select class="" id="start_year" name="start_year">
												<option value="" selected>선택</option>
												<c:forEach var="item" items="${YYYY}">
													<c:if test="${item.VALUE >= '2014'}">
														<option value="${item.CODE}">${item.VALUE}</option>
													</c:if>
												</c:forEach>
											</select>
											<select class="" id="start_month" name="start_month" style="display: none">
												<option value="" selected>선택</option>
												<c:forEach var="item" items="${MM}">
													<option value="<fmt:formatNumber minIntegerDigits="2" value="${item.CODE}" type="number"/>">${item.VALUE}</option>
												</c:forEach>
											</select>
											<span>~</span>
											<select class="" id="end_year" name="end_year">
												<option value="" selected>선택</option>
												<c:forEach var="item" items="${YYYY}">
													<c:if test="${item.VALUE >= '2014'}">
														<option value="${item.CODE}">${item.VALUE}</option>
													</c:if>
												</c:forEach>
											</select>
											<select class="" id="end_month" name="end_month" style="display: none">
												<option value="" selected>선택</option>
												<c:forEach var="item" items="${MM}">
													<option value="<fmt:formatNumber minIntegerDigits="2" value="${item.CODE}" type="number"/>">${item.VALUE}</option>
												</c:forEach>
											</select>
										</div>
										<div class="checkDiv"></div>
										<div class="checkDiv"></div>
										<div class="text-right" style="margin-right: 10px">
											<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
								
							</form>
							<div class="row">
								<div class="col-lg-12" style="margin-left: 10px;">
									<div class="checkDiv">
										<span class="type-name">차트</span>
										<select class="" id="TYPE">
											<option value="E_TOE">전기 MWh</option>
											<option value="E_TCO2EQ">전기 tCO₂</option>
											<option value="G_TOE">가스 1000㎥</option>
											<option value="G_TCO2EQ">가스 tCO₂</option>
											<option value="H_TOE">지역난방 Gcal</option>
											<option value="H_TCO2EQ">지역난방 tCO₂</option>
										</select>
									</div>
									<canvas id="chart" width="1600" height="300"></canvas>
								</div>
							</div>
							<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
								<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">엑셀다운로드</button>
							</div>
							<div class="row">
								<div class="col-lg-12" style="max-height: 300; overflow: auto; padding-right: 30px; padding-left: 30px">
									<table id="listTable" class="table table-striped table-project-tasks">
										<tr id="tHeader1">
											<td rowspan="3" style="width: 200px; padding-left: 0px; word-break: normal;">용도</td>
											<td colspan="7" style="padding-left: 0px; word-break: normal;">연도</td>
										</tr>
										<tr id="tHeader2">
											<td colspan="2" style="padding-left: 0px; word-break: normal;">전기</td>
											<td colspan="2" style="padding-left: 0px; word-break: normal;">가스</td>
											<td colspan="2" style="padding-left: 0px; word-break: normal;">지역난방</td>
											<td style="padding-left: 0px; word-break: normal;">합계</td>
										</tr>
										<tr id="tHeader3">
											<td style="padding-left: 0px; word-break: normal;">MWh</td>
											<td style="padding-left: 0px; word-break: normal;">tCO₂</td>
											<td style="padding-left: 0px; word-break: normal;">1000㎥</td>
											<td style="padding-left: 0px; word-break: normal;">tCO₂</td>
											<td style="padding-left: 0px; word-break: normal;">Gcal</td>
											<td style="padding-left: 0px; word-break: normal;">tCO₂</td>
											<td style="padding-left: 0px; word-break: normal;">tCO₂</td>
										</tr>
										<!-- <tr class="data">
											<td colspan="7">검색 결과가 존재하지 않습니다.</td>
										</tr> -->
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
					<h5 class="modal-title">건물 용도</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 400px;">
					<table class="table table-striped table-project-tasks">
						<tr onclick="checkLine('all')">
							<td>
								<input type="checkbox" value="all" id="all" name="STAT_RADIO">
							</td>
							<td>전체</td>
						</tr>
						<c:forEach items="${PURPS}" var="list" varStatus="status">
							<tr onclick="checkLine('STAT_${status.index}')">
								<td>
									<input type="checkbox" value="${list.CODE}" id="STAT_${status.index}" class="tempPurps">
								</td>
								<td>${list.VALUE}</td>
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
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<script>
		var chart;
		var color = Chart.helpers.color;
		$(document).ready(
				function() {
					createChart([], []);

					$("#TYPE").on(
							"change",
							function() {
								if (globalSearchData != "") {
									createChartData(globalSearchData,
											$("#TYPE").val(), $("#start_year")
													.val(), $("#end_year")
													.val());
								}
							})

					$("#acu").on("change", function() {
						var value = $(this).val();
						if (value == 1) {
							$("#end_year").prop("disabled", false);
							$("#start_month").val("");
							$("#end_month").val("");
							$("#start_month").css("display", "none");
							$("#end_month").css("display", "none");
						} else if (value == 2) {
							$("#end_year").prop("disabled", true);
							$("#end_year").val($("#start_year").val());
							$("#start_month").val("");
							$("#end_month").val("");
							$("#start_month").css("display", "");
							$("#end_month").css("display", "");
						}
					})

					$("#start_year").on("change", function() {
						$("#end_year").val($(this).val())
						if ($("#start_month").val() == "") {
							$("#start_month").val('01');
							$("#end_month").val('01');
						}
					})

					$("#start_month").on("change", function() {
						$("#end_month").val($(this).val())
					})

					var endYearValue;
					$("#end_year").on('focus', function() {
						endYearValue = this.value;
					}).change(
							function() {
								var startYear = $("#start_year").val();
								var endYear = $("#end_year").val();

								var startDate = Number(String($("#start_year")
										.val())
										+ String($("#start_month").val()));
								var endDate = Number(String($("#end_year")
										.val())
										+ String($("#end_month").val()));

								if (startYear == "") {
									alert('시작년도를 우선 지정해주세요.');
									$("#end_year").val("");
								} else if (startYear != "" && endYear == "") {
									alert('시작년도가 정해졌을 경우 전체로 지정 할 수 없습니다.');
									$("#end_year").val(endYearValue);
								} else if (startDate > endDate) {
									alert('시작일자가 종료일자보다 클 수 없습니다.');
									$("#end_year").val(endYearValue);
								}
							});

					var endMonthValue;
					$("#end_month").on('focus', function() {
						endMonthValue = this.value;
					}).change(
							function() {
								var startMonth = $("#start_month").val();
								var endMonth = $("#end_month").val();

								var startDate = Number(String($("#start_year")
										.val())
										+ String($("#start_month").val()));
								var endDate = Number(String($("#end_year")
										.val())
										+ String($("#end_month").val()));

								if (startMonth == "") {
									alert('시작월을 우선 지정해주세요.');
									$("#end_month").val("");
								} else if (startMonth != "" && endMonth == "") {
									alert('시작년도가 정해졌을 경우 전체로 지정 할 수 없습니다.');
									$("#end_month").val(endMonthValue);
								} else if (startDate > endDate) {
									alert('시작일자가 종료일자보다 클 수 없습니다.');
									$("#end_month").val(endMonthValue);
								}
							});
				})

		function checkLine(id) {
			var type = $(event.srcElement).attr("type") == undefined ? "" : $(
					event.srcElement).attr("type");
			var checkpoint = $(event.srcElement).val() == "all" ? true : false;
			if (type.indexOf("checkbox") > -1) {
				var checked = $(event.srcElement).is(":checked");
				if (checkpoint) {
					$(".tempPurps").prop("checked", checked);
				}
				if (!checked) {
					$("#all").prop("checked", false);
				}
			} else {
				var checked = $("#" + id).is(":checked");
				if (id == 'all') {
					$(".tempPurps").prop("checked", !checked);
				} else {
					$("#all").prop("checked", false);
				}
				$("#" + id).prop("checked", !checked);
			}
		}

		function excelExport() {
			ExcellentExport.excel(this, 'listTable', "작업일보", "주제별사용통계", "name");
		}

		function confirmStat(id) {
			if (id == "modalPop_001") {
				var len = $('.tempPurps:checked').length;
				var name = "";
				for (var i = 0; i < len; i++) {
					if (i == 3) {
						break;
					}
					name += $('.tempPurps:checked').eq(i).parent().next()
							.html()
							+ ",";
				}
				name = name.substr(0, name.lastIndexOf(","));

				if (len > 3) {
					$("#statBtn").html(name + "외 " + (len - 3) + " 건");
				} else {
					$("#statBtn").html(name);
				}

				var value = "";
				for (var i = 0; i < len; i++) {
					value += $('.tempPurps:checked').eq(i).val() + ",";
				}
				value = value.substr(0, value.lastIndexOf(","));
				$("#util").val(value);
				
				if(len > 1){
					$("#start_totarea").attr("disabled", true);
					$("#end_totarea").attr("disabled", true);
					$("#start_permission").attr("disabled", true);
					$("#end_permission").attr("disabled", true);
				} else {
					$("#start_totarea").attr("disabled", false);
					$("#end_totarea").attr("disabled", false);
					$("#start_permission").attr("disabled", false);
					$("#end_permission").attr("disabled", false);
				}
				
				if (len == 0) {
					$("#statBtn").html("선택");
				}

			}
			$("#" + id).modal('hide');
		}

		function openModal(id) {
			$("#" + id).modal('show');
		}

		function createChart(dataset, timeset) {
			if (chart != undefined) {
				chart.destroy();
			}

			chart = new Chart(
					$("#chart"),
					{
						type : 'bar',
						data : {
							labels : timeset,
							datasets : dataset
						},
						options : {

							responsive : false,
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true,
										fontSize : 10,
										userCallback : function(value, index,
												values) {
											return num_comma(value);
										}
									}
								} ]
							},
							title : {
								display : true,
								text : '',
							},
							animation : false,
							legend : {
								display : true,
								position : 'right',
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

		/*   
		 * 같은 값이 있는 열을 병합함  
		 * 사용법 : $('#테이블 ID').rowspan(0);  
		 */
		$.fn.rowspan = function(colIdx, t_col, isStats) {
			return this.each(function() {
				var that;
				$('tr', this).each(
						function(row) {
							$('td', this).eq(colIdx).filter(':visible').each(
									function(col) {
										console.log(col);
										if ($(this).html() == $(that).html()
												&& (!isStats || isStats
														&& $(this).prev()
																.html() == $(
																that).prev()
																.html())) {
											if (colIdx < t_col) {
												rowspan = $(that).attr(
														"rowspan") || 1;
												rowspan = Number(rowspan) + 1;
												$(that)
														.attr("rowspan",
																rowspan);
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
						if (col < t_col) {
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
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>