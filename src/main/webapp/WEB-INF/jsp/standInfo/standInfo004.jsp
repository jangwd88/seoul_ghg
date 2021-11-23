<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.table th{
	    background-color: #dee2e6;
}


input[type="text"]{
    background-color: transparent;
    height: 100%;
     min-width:50px;
    width: 50px;
}
select{
	border: 0;
    background-color: transparent;
    height: 100%;
    min-width:80px;
    width: 100%;
}


</style>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
</head>
<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/datatable/datatables.min.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/jstree/jstreestyle.css" />
<script src="/resources/openlayers/ol.js"></script>
<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/datatable/datatables.js"></script>
<script src="/resources/js/common/common.js"></script>
<script src="/resources/js/excelExport/excellentexport.js"></script>

<script>
	function search() {
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo004_search.do",true,'json',param, function(json) {
			
			var isGwp = $("#CEF_GUBUN").val();
			
			if(isGwp == "1"){
				$("#listTable1").css("display","");
				$("#listTable2").css("display","none");
				$("#listTable4").css("display","none");
				$("#listTable5").css("display","none");
				var tr = "";
				for(key in json){
					
					tr += "<tr id='"+$("#year").val()+"_"+json[key]["CEF_GUBUN"]+"_"+json[key]["FUEL_DIV"]+"'>";
					tr += "<td>"+json[key]["FUEL_DIV_NM"]+"</td>"
					tr += "<td>"+json[key]["UNIT_NM"]+"</td>"
					tr += "<td>"+json[key]["N_TOT_HEAT"]+"</td>"
					tr += "<td>"+json[key]["N_HEAT"]+"</td>"
					tr += "<td>"+json[key]["GHG_UNIT"]+"</td>"
					tr += "<td>"+json[key]["TJ"]+"</td>"
					tr += "<td>"+json[key]["FUEL_DIV_IPCC"]+"</td>"
					
					
					tr += '<td>  <input type="text" class="comma" name="ENG_CO2_'+key+'" id="ENG_CO2_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["ENG_CO2"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="ENG_CH4_'+key+'" id="ENG_CH4_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["ENG_CH4"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="ENG_N2O_'+key+'" id="ENG_N2O_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["ENG_N2O"]))+'"></td>';
					
					tr += '<td>  <input type="text" class="comma" name="MANU_CO2_'+key+'" id="MANU_CO2_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["MANU_CO2"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="MANU_CH4_'+key+'" id="MANU_CH4_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["MANU_CH4"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="MANU_N2O_'+key+'" id="MANU_N2O_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["MANU_N2O"]))+'"></td>';
					
					tr += '<td>  <input type="text" class="comma" name="COMM_CO2_'+key+'" id="COMM_CO2_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["COMM_CO2"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="COMM_CH4_'+key+'" id="COMM_CH4_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["COMM_CH4"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="COMM_N2O_'+key+'" id="COMM_N2O_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["COMM_N2O"]))+'"></td>';
					
					tr += '<td>  <input type="text" class="comma" name="HOME_CO2_'+key+'" id="HOME_CO2_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["HOME_CO2"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="HOME_CH4_'+key+'" id="HOME_CH4_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["HOME_CH4"]))+'"></td>';
					tr += '<td>  <input type="text" class="comma" name="HOME_N2O_'+key+'" id="HOME_N2O_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["HOME_N2O"]))+'"></td>';
					
					tr += "</tr>";
				}
				
				if(json.length == 0){
					tr += "<tr class='noData'>";
					tr += "<td colspan='19'>조회된 자료가 없습니다.</td>"
					tr += "</tr>";
				}
				
				$("#tbody1").html(tr);
				
			}else if(isGwp == "2" || isGwp == "3"){
				$("#listTable1").css("display","none");
				$("#listTable2").css("display","");
				$("#listTable4").css("display","none");
				$("#listTable5").css("display","none");
				
				
				var tr = "";
				for(key in json){
					
					tr += "<tr id='"+$("#year").val()+"_"+json[key]["CEF_GUBUN"]+"_"+json[key]["FUEL_DIV"]+"'>";
						tr += "<td>"+json[key]["FUEL_DIV_NM"]+"</td>"
						tr += "<td>"+json[key]["UNIT_NM"]+"</td>"
						tr += "<td>"+json[key]["N_TOT_HEAT"]+"</td>"
						tr += "<td>"+json[key]["N_HEAT"]+"</td>"
						tr += "<td>"+json[key]["GHG_UNIT"]+"</td>"
						tr += "<td>"+json[key]["TJ"]+"</td>"
						tr += "<td>"+json[key]["FUEL_DIV_IPCC"]+"</td>"
						tr += '<td>  <input type="text" class="comma" name="CO2_'+key+'" id="CO2_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["CO2"]))+'"></td>';
						tr += '<td>  <input type="text" class="comma" name="CH4_'+key+'" id="CH4_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["CH4"]))+'"></td>';
						tr += '<td>  <input type="text" class="comma" name="N2O_'+key+'" id="N2O_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["N2O"]))+'"></td>';
					tr += "</tr>";
				}
				
				if(json.length == 0){
					tr += "<tr class='noData'>";
					tr += "<td colspan='10'>조회된 자료가 없습니다.</td>"
					tr += "</tr>";
				}
				
				$("#tbody2").html(tr);
				
			}else if(isGwp == "4"){
				$("#listTable1").css("display","none");
				$("#listTable2").css("display","none");
				$("#listTable4").css("display","");
				$("#listTable5").css("display","none");
				var tr = "";
				for(key in json){
					
					tr += "<tr id='"+$("#year").val()+"_"+json[key]["CEF_GUBUN"]+"_"+json[key]["GWP_GHG"]+"'>";
					tr += "<td>"+json[key]["UNIT_NM"]+"</td>"
					tr += "<td>"+json[key]["N_TOT_HEAT"]+"</td>"
					tr += "<td>"+json[key]["N_HEAT"]+"</td>"
					tr += "<td>"+json[key]["GHG_UNIT"]+"</td>"
					tr += "<td>"+json[key]["TJ"]+"</td>"
					tr += "<td>"+json[key]["FUEL_DIV_IPCC"]+"</td>"
					tr += '<td>  <input type="text" class="comma" name="GWP_VALUE_'+key+'" id="GWP_VALUE_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["GWP_VALUE"]))+'"></td>';
					
					tr += "</tr>";
				}
				
				if(json.length == 0){
					tr += "<tr class='noData'>";
					tr += "<td colspan='19'>조회된 자료가 없습니다.</td>"
					tr += "</tr>";
				}
				
				$("#tbody4").html(tr);
			}else if(isGwp == "5" ){
				$("#listTable1").css("display","none");
				$("#listTable2").css("display","none");
				$("#listTable4").css("display","none");
				$("#listTable5").css("display","");
				var tr = "";
				for(key in json){
					
					tr += "<tr id='"+$("#year").val()+"_"+json[key]["CEF_GUBUN"]+"_"+json[key]["FUEL_DIV"]+"'>";
					tr += "<td>"+json[key]["FUEL_DIV_NM"]+"</td>"
					tr += "<td>"+json[key]["UNIT_NM"]+"</td>"
					tr += "<td>"+json[key]["N_TOT_HEAT"]+"</td>"
					tr += "<td>"+json[key]["N_HEAT"]+"</td>"
					tr += "<td>"+json[key]["GHG_UNIT"]+"</td>"
					tr += "<td>"+json[key]["TJ"]+"</td>"
					tr += "<td>"+json[key]["FUEL_DIV_IPCC"]+"</td>"
					tr += '<td>  <input type="text" class="comma" name="GWP_VALUE_'+key+'" id="GWP_VALUE_'+key+'" value="'+undefinedReplaceEmpty(num_comma(json[key]["GWP_VALUE"]))+'"></td>';
					
					tr += "</tr>";
				}
				
				if(json.length == 0){
					tr += "<tr class='noData'>";
					tr += "<td colspan='19'>조회된 자료가 없습니다.</td>"
					tr += "</tr>";
				}
				
				$("#tbody5").html(tr);
			}
			
			
		});
	}

	function getPreYearData(){
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo004_checkYearData.do",true,'json',param, function(json) {
			alert(json);
		});
		/* callAjax("${pageContext.request.contextPath}/standInfo/standInfo004_getPreYearData.do",true,'json',param, function(json) {
			search();
		}) */
	}
	
	function saveData(){
		var isGwp = $("#CEF_GUBUN").val();
		
		var searchGwp = isGwp == 3 ? 2 : isGwp;
		
		var data = new Object();
		$('#tbody'+searchGwp+' tr:visible').each(function(row) {
			
			var len = $(this).find("input").length;
			var tempValueArray= new Array();
			for(var i =0;i<len;i++){
				tempValueArray.push({NAME :	$(this).find("input").eq(i).attr("name"), VALUE : 	$(this).find("input").eq(i).val()  })
			}
			data[$(this).attr("id")] = tempValueArray;
		}); 
		
		var param = {data : JSON.stringify(data) , CEF_TYPE : searchGwp};
	 	 callAjax("${pageContext.request.contextPath}/standInfo/standInfo004_save.do",true,'text',param, function(data) {
			alert('저장 되었습니다.')
		})  
	}
	

</script>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/inv_sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">배출계수 관리</h1>
					<p class="page-subtitle">서울특별시 인벤토리 배출계수 통합 관리</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">기준정보</li>
						<li class="breadcrumb-item active">
							<a href="/standInfo/standInfo004.do">배출계수 관리</a>
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
											<span class="type-name">기준년도</span>
											<select class="" id="year" name="year" style="width: 100px;">
												<c:forEach items="${yearList}" var="list" varStatus="status">
													<option value="${list.YYYY}">${list.YYYY}</option>
												</c:forEach>
											</select>
										</div>
										<div class="checkDiv">
											<span class="type-name">구분</span>
											<select class="" id="CEF_GUBUN" name="CEF_GUBUN" style="width: 200px;">
												<c:forEach items="${gubunList}" var="list" varStatus="status">
													<option value="${list.CODE}">${list.VALUE}</option>
												</c:forEach>
											</select>
										</div>
										<div class="checkDiv"></div>
										
										<div class="checkDiv">
											<div class="text-right">
												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="getPreYearData()">가져오기</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="saveData()">등록</button>
											</div>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-12" style="overflow-y: auto; max-height:670px; min-height: 670px" >
											<table id="listTable1" class="table table-project-tasks">
										<colgroup>
											<col width="10%">
											<col width="5%">
											<col width="5%">
											<col width="5%">
											<col width="5%">
											<col width="5%">
											<col width="10%">
										</colgroup>
										<tr>
											<td rowspan="3" style="word-break: normal;">연료구분<br>(에너지기본법 기준)</td>
											<td rowspan="3" style="word-break: normal;">단위</td>
											<td rowspan="3" style="word-break: normal;">총발열량</td>
											<td rowspan="3" style="word-break: normal;">순발열량</td>
											<td rowspan="3" style="word-break: normal;">단위</td>
											<td rowspan="3" style="word-break: normal;">MJ<br>(순발열량 기준)</td>
											<td rowspan="3" style="word-break: normal;">연료구분<br>(2006 IPCC G/L기준)</td>
											<td colspan="12" style="word-break: normal;">배출계수 (단위 : kg/TJ)</td>
										</tr>
										<tr>
											<td colspan="3" style="word-break: normal;">에너지산업</td>
											<td colspan="3" style="word-break: normal;">제조업/건설업</td>
											<td colspan="3" style="word-break: normal;">상업/공공</td>
											<td colspan="3" style="word-break: normal;">가정/농림어업</td>
										</tr>
										<tr>
											<td style="word-break: normal;">CO₂</td>
											<td  style="word-break: normal;">CH₄</td>
											<td style="word-break: normal;">N₂O</td>
											<td style="word-break: normal;">CO₂</td>
											<td  style="word-break: normal;">CH₄</td>
											<td style="word-break: normal;">N₂O</td>
											<td style="word-break: normal;">CO₂</td>
											<td  style="word-break: normal;">CH₄</td>
											<td style="word-break: normal;">N₂O</td>
											<td style="word-break: normal;">CO₂</td>
											<td  style="word-break: normal;">CH₄</td>
											<td style="word-break: normal;">N₂O</td>
										</tr>
										<tbody id="tbody1">
										
										
										</tbody>
										
										
									</table> 
									
									<table id="listTable2" class="table table-project-tasks" style="display:none">
										<colgroup>
											<col width="10%">
											<col width="10%">
										</colgroup>
										<tr>
											<td style="word-break: normal;">연료구분<br>(에너지기본법 기준)</td>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">총발열량</td>
											<td style="word-break: normal;">순발열량</td>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">MJ<br>(순발열량 기준)</td>
											<td style="word-break: normal;">연료구분<br>(2006 IPCC G/L기준)</td>
											<td  style="word-break: normal;">CO2 배출계수 (단위 : kg/TJ)</td>
											<td  style="word-break: normal;">CH4 배출계수 (단위 : kg/TJ)</td>
											<td  style="word-break: normal;">N2O 배출계수 (단위 : kg/TJ)</td>
										</tr>
										<tbody id="tbody2">
										
										
										</tbody>
									</table> 
									
									<table id="listTable4" class="table table-project-tasks" style="display:none">
										<colgroup>
											<col width="10%">
											<col width="10%">
										</colgroup>
										<tr>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">총발열량</td>
											<td style="word-break: normal;">순발열량</td>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">MJ<br>(순발열량 기준)</td>
											<td style="word-break: normal;">연료구분<br>(2006 IPCC G/L기준)</td>
											<td  style="word-break: normal;">value</td>
										</tr>
										<tbody id="tbody4">
										
										
										</tbody>
									</table> 
									
									<table id="listTable5" class="table table-project-tasks" style="display:none">
										<colgroup>
											<col width="10%">
											<col width="10%">
										</colgroup>
										<tr>
											<td style="word-break: normal;">연료구분<br>(에너지기본법 기준)</td>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">총발열량</td>
											<td style="word-break: normal;">순발열량</td>
											<td style="word-break: normal;">단위</td>
											<td style="word-break: normal;">MJ<br>(순발열량 기준)</td>
											<td style="word-break: normal;">연료구분<br>(2006 IPCC G/L기준)</td>
											<td  style="word-break: normal;">value</td>
										</tr>
										<tbody id="tbody5">
										
										
										</tbody>
									</table> 
										
										<%-- 
										<table id="listTable" class="table table-project-tasks">
										<colgroup>
											<col width="10%">
											<col width="40%">
											<col width="10%">
											<col width="40%">
										</colgroup>
										<tr>
											<th style="word-break: normal;">부문구분</th>
											<td colspan="3" style="word-break: normal;">에너지 / 산업 / ...</td>
										</tr>
										<tr>
											<th style="word-break: normal;">시설 생성일</th>
											<td colspan="3" style="word-break: normal;"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">배출 시설명</th>
											<td style="word-break: normal;"></td>
											<th style="word-break: normal;">소유구분</th>
											<td style="word-break: normal;"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">CODE</th>
											<td style="word-break: normal;"></td>
											<th style="word-break: normal;">시설 폐쇄 연도</th>
											<td style="word-break: normal;"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">에너지원</th>
											<td colspan="3" style="word-break: normal;">
											<button type="button" class="btn btn-primary" aria-expanded="false" style="float:right;margin-left:10px " >-</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" style="float:right;" >+</button>
													<table id="listTable" class="table table-striped table-project-tasks">
														<thead>
														<tr>
															<td rowspan="2" style="word-break: normal;">에너지원</td>
															<td rowspan="2" style="word-break: normal;">단위</td>
															<td rowspan="2" style="word-break: normal;">배출활동구분</td>
															<td rowspan="2" style="word-break: normal;">시설용량</td>
															<td rowspan="2" style="word-break: normal;">용량단위</td>
															<td colspan="2" style="word-break: normal;">이력연도</td>
														</tr>
														<tr>
															<td style="word-break: normal;">시작</td>
															<td style="word-break: normal;">종료</td>
														</tr>
														</thead>
														<tbody>
															<tr>
															<td style="word-break: normal;"><select><option></option></select></td>
															<td style="word-break: normal;"><input type="text"></td>
															<td style="word-break: normal;"><input type="text"></td>
															<td style="word-break: normal;"><input type="text"></td>
															<td style="word-break: normal;"><input type="text"></td>
															<td style="word-break: normal;"><input type="text"></td>
															<td style="word-break: normal;"><input type="text"></td>
															</tr>
														</tbody>
													</table>
											
											
											</td>
										</tr>
									</table> 
									--%>
								</div>
							</div>
						</div>
					</div>
				</div>
			<!-- 	<div class="row"> 
					<div class="col-md-12" style="text-align: right"> 
						<button type="button" class="btn btn-primary" aria-expanded="false" >저장</button>
						<button type="button" class="btn btn-primary" aria-expanded="false" >닫기</button>
					</div>
				</div> -->
				
				
			</div>
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal" tabindex="-1" id="modalPop_001">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">용도</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 400px;">
					<table class="table table-striped table-project-tasks">
						<tr onclick="checkLine('all')">
							<td><input type="radio" value="all" id="all" name="INVEN_RADIO"></td>
							<td>전체</td>
						</tr>
						<c:forEach items="${yearList}" var="list" varStatus="status">
							<tr onclick="checkLine('STAT_${status.index}')">
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
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<script src="/resources/js/jstree/jstree.js"></script>
	<script>
		$(document).ready(function() {
			
		})

		function excelExport() {
			ExcellentExport.excel(this, 'listTable', "부문별 추정 배출량", "부문별 추정 배출량", "name");
		}

		function confirmStat(id) {
			if (id == "modalPop_001") {
				var len = $('.tempYYYYs:checked').length;
				var name = $('.tempYYYYs:checked').eq(0).parent().next().html();
				if (len > 1) {
					$("#invenCalBtn").html(name + "외 " + (len - 1) + " 건");
				} else if (len == 1) {
					$("#invenCalBtn").html(name);
				}

				var value = "";
				for (var i = 0; i < len; i++) {
					value += $('.tempYYYYs:checked').eq(i).val() + ",";
				}
				value = value.substr(0, value.lastIndexOf(","));
				$("#util").val(value);

			}
			$("#" + id).modal('hide');
		}

		function openModal(id) {
			$("#" + id).modal('show');
		}

		function checkLine(id) {
			var checked = $("#" + id).is(":checked");
			if (id == 'all') {
				$(".tempYYYYs").prop("checked", !checked);
			} else {
				$("#all").prop("checked", false);
			}
			$("#" + id).prop("checked", !checked);
		}

		
	</script>
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>