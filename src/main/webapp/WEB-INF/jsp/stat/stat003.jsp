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

.modalPop_001 {
	max-width: 1270px !important;
	/* margin: 7rem auto; */
}
</style>

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/datatable/datatables.min.css" />
<script src="/resources/openlayers/ol.js"></script>

<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/common/common.js"></script>
<script src="/resources/js/excelExport/excellentexport.js"></script>

<script>
	function searchBuilding() {
		var param = $("#buildingFrm").serialize();
		callAjax(
				"${pageContext.request.contextPath}/stat/stat003_getBuildingList.do",
				true,
				'json',
				param,
				function(data) {
					$(".buildingdata").remove();
					var tr = "";
					for (key in data) {
						var id = "buildingItem_" + key;
						tr += "<tr class='buildingdata'>";
						tr += '<td><input type="checkbox" id="'+id+'" class="buildingCheckItem" value="'+key+'" onclick="checkLine('+id+")"+'"'+">"+'</td>';
						tr += '<td>' + data[key]["CONS_NM"] + '</td>'
						tr += '<td>' + data[key]["JUSO"] + '</td>'
						tr += '<td>' + data[key]["PROP_OFFICER"] + '</td>'
						tr += '<td style="display: none;">' + data[key]["MAIN_PURPS_CD"] + '</td>'
						tr += '<td>' + data[key]["MAIN_PURPS_NM"] + '</td>'
						tr += '<td>' + data[key]["USEAPR_DAY"] + '</td>'
						tr += '<td>' + num_comma(data[key]["TOTAREA"]) + '</td>'
						tr += '</tr>';
					}
					if (tr == "") {
						tr += '<tr class="data">'
						tr += '<td colspan="7">조회 결과가 없습니다.</td>'
						tr += '</tr>'
					}
					$("#buildingTable").append(tr);
				})
	}

	function saveBuilding() {
		frmNumCommaBreak();

		var trlen = $("#listTable tr.submitData").length;
		var submitArr = new Array();
		for (var i = 0; i < trlen; i++) {
			var inputLen = $("#listTable tr.submitData").eq(i).find("input[type!='checkbox']").length;
			var tempArr = new Object();
			for (var input = 0; input < inputLen; input++) {
				var ele = $("#listTable tr.submitData").eq(i).find("input[type!='checkbox']").eq(input);
				tempArr[$(ele).attr("sClass")] = $(ele).val();
				tempArr["ISNEW"] = $(ele).attr("class").indexOf("old") > -1 ? "old" : "new";
			}
			submitArr.push(tempArr)
		}

		if (submitArr.length == 0) {
			alert('저장 할 데이터가 없습니다. 다시 확인해주세요.');
			return;
		}
		$("#tableData").val(JSON.stringify(submitArr));
		$("#mode").val("all")
		var param = $("#submitFrm").serialize();
		
		callAjax(
				"${pageContext.request.contextPath}/stat/stat003_saveBuilding.do",
				true, 'text', param, function(data) {
					alert(data);
					frmNumComma();
					$("#tableData").val("");
				});
	}

	function deleteBuilding(){
		var deleteArr = $("input[name='DELETECHECK']:checked").length;
		var deleteList = "";
		for(var i =0;i < deleteArr;i++){
			deleteList += $("input[name='DELETECHECK']:checked").eq(i).val()+",";
		}
		deleteList = deleteList.substr(0,deleteList.lastIndexOf(","));
		
		var param = { DELETELIST  : deleteList}
		callAjax("${pageContext.request.contextPath}/stat/stat003_deleteBuilding.do",true,'text',param,function(data) {
			alert("삭제가 완료되었습니다.");
			search();
		});
		
	}
	
	function search() {
		if ($("#start_year").val() == "" || $("#end_year").val() == "") {
			alert('조회기간을 선택해주세요.');
			return;
		}

		var param = $("#searchFrm").serialize();
		callAjax(
				"${pageContext.request.contextPath}/stat/stat003_search.do",
				true,
				'json',
				param,
				function(data) {
					var startVal = $("#start_year").val();
					var endVal = $("#end_year").val();
					var tr = "";
					var excelTr = "";
					$(".submitData").remove();
					for (key in data) {
						tr += "<tr class='submitData' style='word-break: keep-all;'>";
						tr += "<td>"
								+ "<input type='checkbox'  name='DELETECHECK'  value='"+data[key]["ID_BLD_GOAL_LIST"]+"'></td>";
						tr += "<td>"
								+ data[key]["ID_BLD_GOAL_LIST"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingId' name='old_"+key+"_buildingId' id='old_"+key+"_buildingId' value='"+data[key]["ID_BLD_GOAL_LIST"]+"'></td>";
						tr += "<td>"
								+ data[key]["CONS_NM"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingName' name='old_"+key+"_buildingName' id='old_"+key+"_buildingName' value='"+data[key]["CONS_NM"]+"'></td>";
						tr += "<td>"
								+ data[key]["JUSO"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingJuso' name='old_"+key+"_buildingJuso' id='old_"+key+"_buildingJuso' value='"+data[key]["JUSO"]+"'></td>";
						tr += "<td>"
								+ data[key]["PROP_OFFICER"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingProp' name='old_"+key+"_buildingProp' id='old_"+key+"_buildingProp' value='"+data[key]["PROP_OFFICER"]+"'></td>";
						tr += "<td>"
								+ data[key]["COMPL_YEAR"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingCompl' name='old_"+key+"_buildingCompl' id='old_"+key+"_buildingCompl' value='"+data[key]["COMPL_YEAR"]+"'></td>";
						tr += "<td>"
								+ num_comma(data[key]["AREA"])
								+ "<input type='hidden' class='oldBuiling' sClass='buildingArea' name='old_"+key+"_buildingArea' id='old_"+key+"_buildingArea' value='"+data[key]["AREA"]+"'></td>";
						tr += "<td>"
								+ data[key]["USE_INT_NM"]
								+ "<input type='hidden' class='oldBuiling' sClass='buildingUse' name='old_"+key+"_buildingUse' id='old_"+key+"_buildingUse' value='"+data[key]["USE_INT_NM"]+"'></td>";
						for (var d = startVal; d <= endVal; d++) {
							tr += "<td><input type='text' class='oldBuiling toe comma' sClass='"
									+ d
									+ "_toe'  name='old_"
									+ d
									+ "_toe' id='new_"
									+ d
									+ "_toe' value='"
									+ num_comma(data[key]["TOE_" + d])
									+ "' onkeypress='return isNumberKey(event)' onkeyup='return delHangle(event)'></td>";
							tr += "<td><input type='text' class='oldBuiling tco2eq comma' sClass='"
									+ d
									+ "_tco2eq'  name='old_"
									+ d
									+ "_tco2eq' id='new_"
									+ d
									+ "_tco2eq' value='"
									+ num_comma(data[key]["TCO2EQ_" + d])
									+ "'  onkeypress='return isNumberKey(event)' onkeyup='return delHangle(event)'></td>";
							tr += "<td><input type='text' class='oldBuiling reduction comma' sClass='"
									+ d
									+ "_reduction'  name='old_"
									+ d
									+ "_reduction' id='new_"
									+ d
									+ "_reduction' value='"
									+ num_comma(data[key]["REDUCTION_" + d])
									+ "'  onkeypress='return isNumberKey(event)' onkeyup='return delHangle(event)'></td>";
						}
						tr += "</tr>";
					}
					$("#listTable").append(tr);

					for (key in data) {
						excelTr += "<tr>";
						excelTr += "<td>" + data[key]["ID_BLD_GOAL_LIST"]
								+ "</td>";
						excelTr += "<td>" + data[key]["CONS_NM"] + "</td>";
						excelTr += "<td>" + data[key]["JUSO"] + "</td>";
						excelTr += "<td>" + data[key]["PROP_OFFICER"] + "</td>";
						excelTr += "<td>" + data[key]["COMPL_YEAR"] + "</td>";
						excelTr += "<td>" + num_comma(data[key]["AREA"]) + "</td>";
						excelTr += "<td>" + data[key]["USE_INT_NM"] + "</td>";
						for (var d = startVal; d <= endVal; d++) {
							excelTr += "<td>"
									+ num_comma(data[key]["TOE_" + d])
									+ "</td>";
							excelTr += "<td>"
									+ num_comma(data[key]["TCO2EQ_" + d])
									+ "</td>";
							excelTr += "<td>"
									+ num_comma(data[key]["REDUCTION_" + d])
									+ "</td>";
						}
						excelTr += "</tr>";
					}
					$("#excelTable").append(excelTr);

				});
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
					<h1 class="page-title">목표 등록 및 조회</h1>
					<p class="page-subtitle">서울특별시 건축물 연도별 목표 등록</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"></i>
							Home
						</li>
						<li class="breadcrumb-item">온실가스 배출통계</li>
						<li class="breadcrumb-item active">
							<a href="/stat/stat003.do">목표 등록 및 조회</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card">
							<div class="project-heading">
								<form id="searchFrm" name="searchFrm" method="post">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">조회기간</span>
											<select class="" id="start_year" name="start_year">
												<option value="" selected>선택</option>
												<option value="2025">2025</option>
												<%-- <c:forEach var="item" items="${YYYY}">
														<option value="${item.CODE}">${item.VALUE}</option>
													</c:forEach> --%>
											</select>
											<span>~</span>
											<select class="" id="end_year" name="end_year">
												<option value="" selected>선택</option>
												<option value="2025">2025</option>
												<%-- <c:forEach var="item" items="${YYYY}">
														<option value="${item.CODE}">${item.VALUE}</option>
													</c:forEach> --%>
											</select>
										</div>
										<div class="checkDiv"></div>
										<div class="checkDiv"></div>
										<div class="text-right" style="margin-right: 10px">
											<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button>
											<c:if test="${loginInfo.AUTH_INFO == '1'}">
												<button type="button" class="btn btn-primary" aria-expanded="false" id="addBtn" onclick="saveBuilding()">저장</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="deleteBtn" onclick="deleteBuilding()">삭제</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="saveBtn" onclick="openModal('modalPop_001')">건물등록</button>
											</c:if>
											<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">엑셀다운로드</button>
										</div>

									</div>
									<hr class="hrSelect">
								</form>
							</div>

							

							<div class="text-right" style="margin-right: 15px; margin-bottom: 5px"></div>

							<div class="row">
								<div class="col-lg-12" style="min-height: 640; max-height: 640; overflow-y: auto; padding-right: 30px; padding-left: 30px">
									<form id="submitFrm" name="submitFrm" method="post">
										<input type="hidden" name="mode" id="mode" value="onlyBuilding">
										<input type="hidden" name="startYear" id="startYear">
										<input type="hidden" name="endYear" id="endYear">
										<input type="hidden" name="tableData" id="tableData">

										<table id="listTable" class="table table-striped table-project-tasks">
											<tr>
												<td style="word-break: normal;"></td>
												<td style="word-break: normal;">연번</td>
												<td style="word-break: normal;">건물명</td>
												<td style="word-break: normal;">주소</td>
												<td style="word-break: normal;">관리부서</td>
											</tr>
										</table>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal" tabindex="-1" id="modalPop_001">
		<div class="modal-dialog modalPop_001">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">건물등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<script>
					$("#modalPop_001").draggable({
						handle : ".modal-header"
					})
					<!-- make modal draggable -->
				</script>
				<div class="modal-body">
					<div class="project-heading">
						<form id="buildingFrm" name="buildingFrm">
							<div class="row">
								<div class="checkDiv">
									<span class="type-name">건물명</span>
									<input type="text" name="building_name" id="building_name">
								</div>
								<div class="checkDiv">
									<span class="type-name">주소</span>
									<input type="text" name="building_juso" id="building_juso">
								</div>
								<div class="checkDiv">
									<span class="type-name">관리부서</span>
									<input type="text" name="building_prop" id="building_prop">
								</div>
								<div class="text-right" style="margin-right: 10px">
									<button type="button" class="btn btn-primary" aria-expanded="false" id="searchBulingBtn" onclick="searchBuilding()">조회</button>
								</div>
							</div>
							<hr class="hrSelect">
						</form>
					</div>
					<div style="overflow: auto; height: 500px">
						<table class="table table-striped table-project-tasks" id="buildingTable">
							<tr>
								<td onclick="checkLine('all')">
									<input type="checkbox" value="all" id="all" onclick="checkLine('all')">
								</td>
								<td>건물명</td>
								<td>주소</td>
								<td>관리부서</td>
								<td>용도</td>
								<td>준공연도</td>
								<td>연면적(m<sup>2</sup>)</td>
							</tr>
						</table>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="confirmModal('modalPop_001')">확인</button>
				</div>
			</div>
		</div>
	</div>


	<table id="excelTable" class="table table-striped table-project-tasks" style="display: none">
		<tr>
			<td style="word-break: normal;"></td>
			<td style="word-break: normal;">연번</td>
			<td style="word-break: normal;">건물명</td>
			<td style="word-break: normal;">주소</td>
			<td style="word-break: normal;">관리부서</td>
			<td style="word-break: normal;">준공년도</td>
			<td style="word-break: normal;">연면적(m<sup>2</sup>)</td>
			<td style="word-break: normal;">용도</td>
		</tr>
	</table>

	<!-- END MAIN -->
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>


	<script>
		$(document).ready(
				function() {
					$("#start_year").on("change", function() {
						$("#end_year").val($(this).val())
						if ($("#start_month").val() == "") {
							$("#start_month").val('01');
							$("#end_month").val('01');
						}
						createTableHead()
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
								createTableHead()
							});

				})

		function checkLine(id) {
			var checked = $("#" + id).is(":checked");
			if (id == 'all') {
				$(".buildingCheckItem").prop("checked", !checked);
			} else {
				$("#all").prop("checked", false);
			}
			$("#" + id).prop("checked", !checked);
		}

		function excelExport() {
			ExcellentExport.excel(this, 'excelTable', "목표 등록 및 조회", "목표 등록 및 조회", "N");
		}

		function confirmModal(id) {
			if (id == "modalPop_001") {
				/*확인 버튼 누르면 DB에 저장*/
				$("#mode").val("onlyBuilding")
				$("#tableData").val("");
				var sumitArr = new Array();
				var len = $(".buildingCheckItem:checked").length;
				for (var i = 0; i < len; i++) {
					var value = $(".buildingCheckItem:checked").eq(i).val();
					var buildingName = $(".buildingCheckItem:checked").eq(i).parent().next().html();
					var buildingJuso = $(".buildingCheckItem:checked").eq(i).parent().next().next().html();
					var buildingProp = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().html();
					var buildingPurps = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().next().html();
					
					var buildingYear  = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().next().next().next().html();
					var buildingUseapr  = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().next().next().html();
					var buildingTotarea = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().next().next().next().next().html();
					sumitArr.push({
						buildingName : buildingName,
						buildingJuso : buildingJuso,
						buildingProp : buildingProp,
						buildingPurps : buildingPurps,
						buildingUseapr : buildingUseapr,
						buildingTotarea : buildingTotarea,
						buildingYear : buildingYear						
					});
					
					console.log("sumitArr", sumitArr);

				}
				$("#tableData").val(JSON.stringify(sumitArr));

				var param = $("#submitFrm").serialize();
				callAjax(
						"${pageContext.request.contextPath}/stat/stat003_saveBuilding.do",
						true, 'text', param, function(data) {
							alert(data);
							frmNumComma();
							$("#tableData").val("");
						});

				/* 확인 버튼 누르면 메인 그리드에 가상 데이터 생성 방식  */
				/* 
				var startVal = $("#start_year").val();
				var endVal = $("#end_year").val();
				
				var rowCount = $("#listTable tr").length - 1;
				var buildingArr = new Array();
				var len = $(".buildingCheckItem:checked").length;
				var tr = "";
				var excelTr = "";
				for(var i=0 ; i<len ; i++){
					var value = $(".buildingCheckItem:checked").eq(i).val();
					var buildingName = $(".buildingCheckItem:checked").eq(i).parent().next().html();
					var buildingJuso = $(".buildingCheckItem:checked").eq(i).parent().next().next().html();
					var buildingProp = $(".buildingCheckItem:checked").eq(i).parent().next().next().next().html();
					
					tr += "<tr class='submitData New'>";
					tr += "<td>New</td>";
					tr += "<td>"+buildingName+"<input type='hidden' class='newBuiling' sClass='buildingName' name='new_"+rowCount+"_buildingName' id='new_"+rowCount+"_buildingName' value='"+buildingName+"'></td>";
					tr += "<td>"+buildingJuso+"<input type='hidden' class='newBuiling' sClass='buildingJuso' name='new_"+rowCount+"_buildingJuso' id='new_"+rowCount+"_buildingJuso' value='"+buildingJuso+"'></td>";
					tr += "<td>"+buildingProp+"<input type='hidden' class='newBuiling' sClass='buildingProp' name='new_"+rowCount+"_buildingProp' id='new_"+rowCount+"_buildingProp' value='"+buildingProp+"'></td>";
					for(var d = startVal ; d<=endVal ; d++){
						tr += "<td><input type='text' class='newBuiling toe comma' sClass='"+d+"_toe'  name='new_"+d+"_toe' id='new_"+d+"_toe' onkeypress='return isNumberKey(event)' onkeyup='return delHangle(event)'></td>";
						tr += "<td><input type='text' class='newBuiling tco2eq comma' sClass='"+d+"_tco2eq'  name='new_"+d+"_tco2eq' id='new_"+d+"_tco2eq' onkeypress='return isNumberKey(event)' onkeyup='return delHangle(event)'></td>";
					}
					tr += "</tr>";
					
					excelTr += "<tr class='submitData'>";
					excelTr += "<td>New</td>";
					excelTr += "<td>"+buildingName+"</td>";
					excelTr += "<td>"+buildingJuso+"</td>";
					excelTr += "<td>"+buildingProp+"</td>";
					for(var d = startVal ; d<=endVal ; d++){
						excelTr += "<td>0</td>";
						excelTr += "<td>0</td>";
					}
					excelTr += "</tr>";
					rowCount++;
				}
				$("#listTable").append(tr);
				$("#excelTable").append(excelTr); */

			}
			$("#" + id).modal('hide');
		}

		function openModal(id) {
			if (id == "modalPop_001") {
				/* if($("#start_year").val() == "" || $("#end_year").val() == ""){
					alert('조회기간을 선택해주세요.');
					return;
				} */
				searchBuilding();
			}

			$("#" + id).modal('show');
		}

		var globalStartYear = 0;
		var globaEndYear = 0;

		function createTableHead() {
			var startYear = $("#start_year").val();
			var endYear = $("#end_year").val();
			if (startYear == "" || endYear == "") {
				alert('기간을 선택해주세요.');
				return;
			}

			if (startYear > endYear) {
				alert('시작년도는 종료년도보다 클 수 없습니다.');
				$("#start_year").val(globalStartYear);
				$("#end_year").val(globaEndYear);
				return;
			}

			globalStartYear = startYear;
			globaEndYear = endYear;

			$("#startYear").val(startYear);
			$("#endYear").val(endYear);

			$("#listTable").html("");
			var head = '<tr>';
			head += '		<td rowspan="2" style=" word-break: normal;"></td>';
			head += '		<td rowspan="2" style=" word-break: normal;">연번</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">건물명</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">주소</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">관리부서</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">준공연도</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">연면적(m<sup>2</sup>)</td>';
			head += '		   <td rowspan="2" style=" word-break: normal;">용도</td>';

			for (var i = startYear; i <= endYear; i++) {
				head += '<td colspan="3" style=" word-break: normal;">' + i
						+ '</td>';
			}
			head += '</tr>';
			head += '<tr>';

			for (var i = startYear; i <= endYear; i++) {
				head += '<td style=" word-break: normal;">배출허용(tCO<sub>2</sub>/m<sup>3</sup>)</td>';
				head += '<td style=" word-break: normal;">배출총량(tCO<sub>2</sub>/연)</td>';
				head += '<td style=" word-break: normal;">감축률</td>';
			}
			head += '</tr>';
			$("#listTable").append(head);

			$("#excelTable").html("");
			var head = '<tr><td rowspan="2">연번</td>';
			head += '		   <td rowspan="2">건물명</td>';
			head += '		   <td rowspan="2">주소</td>';
			head += '		   <td rowspan="2">관리부서</td>';
			head += '		   <td rowspan="2">준공년도</td>';
			head += '		   <td rowspan="2">연면적(m<sup>2</sup>)</td>';
			head += '		   <td rowspan="2">용도</td>';

			for (var i = startYear; i <= endYear; i++) {
				head += '<td colspan="3">' + i
						+ '</td>';
			}
			head += '</tr>';
			head += '<tr>';

			for (var i = startYear; i <= endYear; i++) {
				head += '<td>배출허용(tCO2/m3)</td>';
				head += '<td>배출총량(tCO2/연)</td>';
				head += '<td>감축률</td>';
			}
			head += '</tr>';

			$("#excelTable").append(head);
		}

		/*   
		 *   
		 * 같은 값이 있는 열을 병합함  
		 *   
		 * 사용법 : $('#테이블 ID').rowspan(0);  
		 *   
		 */
		$.fn.rowspan = function(colIdx, isStats) {
			return this
					.each(function() {
						var that;
						$('tr', this)
								.each(
										function(row) {
											$('td', this)
													.eq(colIdx)
													.filter(':visible')
													.each(
															function(col) {
																console
																		.log(col)
																if ($(this)
																		.html() == $(
																		that)
																		.html()
																		&& (!isStats || isStats
																				&& $(
																						this)
																						.prev()
																						.html() == $(
																						that)
																						.prev()
																						.html())) {
																	rowspan = $(
																			that)
																			.attr(
																					"rowspan") || 1;
																	rowspan = Number(rowspan) + 1;

																	$(that)
																			.attr(
																					"rowspan",
																					rowspan);

																	// do your action for the colspan cell here              
																	$(this)
																			.hide();

																	//$(this).remove();   
																	// do your action for the old cell here  

																} else {
																	that = this;
																}

																// set the that if not already set  
																that = (that == null) ? this
																		: that;
															});
										});
					});
		};

		/*   
		 *   
		 * 같은 값이 있는 행을 병합함  
		 *   
		 * 사용법 : $('#테이블 ID').colspan (0);  
		 *   
		 */
		$.fn.colspan = function(rowIdx) {
			return this.each(function() {

				var that;
				$('tr', this).filter(":eq(" + rowIdx + ")").each(function(row) {
					$(this).find('td').filter(':visible').each(function(col) {
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
					});
				});

			});
		}
	</script>

</body>
</html>