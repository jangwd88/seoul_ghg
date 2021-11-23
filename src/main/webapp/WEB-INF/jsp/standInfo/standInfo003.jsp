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
     min-width:80px;
    width: 100%;
}
select{
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
var gloSelectId = -1;
var globalJson;

	function search() {
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo003_search.do",true,'json',param, function(json) {
			json = JSON.parse(JSON.stringify(json).replace(/PARENT/gi,'parent').replace(/ID/gi,'id').replace(/TEXT/gi,'text').replace(/UQID/gi,"uqid").replace(/ROOT_NAME/gi,"root_name")  );
			globalJson = json;
			$('#jstree').jstree(true).settings.core.data = json;
			$('#jstree').jstree(true).refresh();
			jsonData = json;
			 $('#jstree').on('changed.jstree', function (e, data) {
				 	deleteArr = new Array();
				    var i, j, r = [];
				    var rp = [];
				    for(i = 0, j = data.selected.length; i < j; i++) {
				      r.push(data.instance.get_node(data.selected[i]).original.id);
				      rp.push(data.instance.get_node(data.selected[i]).parents);
				    }
				    
				    
				    if(rp.length > 0){
					    var rpR = rp[0];
					    var treeNavi = new Array();
					    for(var i =0;i<rpR.length;i++){
					    	if(rpR[i] == "#"){
					    		continue;
					    	}
					    	treeNavi.unshift($("#jstree").jstree("get_node", rpR[i]).text)
					    }
					    $("#treeNavi").html("");
					    for(var i =0;i<treeNavi.length;i++){
					    	$("#treeNavi").append(treeNavi[i]+" > ")
					    	
					    }
				    }
				   var id = r.join(', ').split(">");
				   id = id[id.length-1]
				    
				   gloSelectId = id;
				   searchDetail();
				   searchDetailTalbe();
	 		}).jstree()
		});
	}
	
	function searchDetail() {
		var param = {INV_ENG_POINT_CD : gloSelectId}
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo003_searchDetail.do",true,'json',param, function(json) {
			json = json[0];
			
			var itemArray = ['INV_ENG_POINT_NM', 'CODE', 'DATA_INFO', 'FAC_START_DAY', 'FAC_END_DAY', 'OWNER_GUBUN'];
			for(key in itemArray){
				$("#VIEW_"+itemArray[key]).html("");
			}
			
			for(key in json){
				$("#VIEW_"+key).html(json[key]);
			} 
		});
	}
	function searchDetailTalbe() {
		var param = {INV_ENG_POINT_CD : gloSelectId}
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo003_searchDetailTalbe.do",true,'json',param, function(json) {
			var datainfoJson = JSON.parse('${dataInfo}');
			var tr = "";
			for(key in json){
				var code = json[key]["CODE"] == undefined ? "" : json[key]["CODE"];
				var infoNm = json[key]["DATA_INFO_NM"] == undefined ? "" : json[key]["DATA_INFO_NM"];
				var infoCd = json[key]["DATA_INFO_NM"] == undefined ? "" : json[key]["DATA_INFO"];
				
				var cefPointNm = json[key]["CEF_WORK_NM"] == undefined ? "" : json[key]["CEF_WORK_NM"];
				
				tr += "<tr>";
				tr += "<td><input type='checkbox' name='check_"+json[key]["INV_ENG_POINT_DETAIL_ID"]+"_"+json[key]["INV_ENG_POINT_CD"]+"  ' id='check_"+json[key]["INV_ENG_POINT_DETAIL_ID"]+"_"+json[key]["INV_ENG_POINT_CD"]+"' class='OLD DETAIL_TABLE_CHECK' ></td>"
				tr += "<td>-</td>"
				
				tr += "<td><input type='text' name='UPDATEROW_POINTNAME_"+json[key]["INV_ENG_POINT_ID"]+"' id='UPDATEROW_POINTNAME_"+json[key]["INV_ENG_POINT_DETAIL_ID"]+"' value='"+cefPointNm+"'></td>"
				tr += "<td><input type='text' name='UPDATEROW_CODE_"+json[key]["INV_ENG_POINT_ID"]+"' id='UPDATEROW_CODE_"+json[key]["INV_ENG_POINT_DETAIL_ID"]+"' value='"+code+"'></td>"
			/* 	tr += "<td>"
			 	tr += "<select name='UPDATEROW_INFONAME_"+json[key]["INV_ENG_POINT_ID"]+"' id='UPDATEROW_INFONAME_"+json[key]["INV_ENG_POINT_ID"]+"'>";
					tr += "<option value=''></option>";    
				for(var i =0;i<datainfoJson.length;i++){
					if(infoCd == datainfoJson[i].CODE){
						tr += "<option value='"+datainfoJson[i].CODE+"' selected>"+datainfoJson[i].NAME+"</option>";    
					}else{
						tr += "<option value='"+datainfoJson[i].CODE+"'>"+datainfoJson[i].NAME+"</option>";    
					}
				}
			 	tr += "</select>"; 
			 	tr += "</td>"*/
				
				tr += "</tr>";
			}
			
			if(json.length == 0){
				tr += "<tr class='noData'>";
				tr += "<td colspan='5'>조회된 자료가 없습니다.</td>"
				tr += "</tr>";
			}
			
			$("#detailTable_body").html(tr);
		});
	}

	var addRowCnt = 0;
	function addRow(){
		if(gloSelectId == -1){
			alert('시설을 선택해주세요.');
			return;
		}
		
		var datainfoJson = JSON.parse('${dataInfo}');
		$(".noData").remove();
		var tr = "<tr>";
		tr += "<td><input type='checkbox' id='NEW_ROW_"+addRowCnt+"'  class='NEW DETAIL_TABLE_CHECK' ></td>"
		tr += "<td>C</td>"
		tr += "<td><input type='text' name='ADDROW_POINTNAME_"+addRowCnt+"' id='ADDROW_POINTNAME_"+addRowCnt+"'></td>"
		tr += "<td><input type='text' name='ADDROW_CODE_"+addRowCnt+"' id='ADDROW_CODE_"+addRowCnt+"'></td>"
		/* tr += "<td>"
	 	tr += "<select name='ADDROW_INFONAME_"+addRowCnt+"' id='ADDROW_INFONAME_"+addRowCnt+"'>";
			tr += "<option value=''></option>";    
		for(var i =0;i<datainfoJson.length;i++){
			tr += "<option value='"+datainfoJson[i].CODE+"'>"+datainfoJson[i].NAME+"</option>";    
		}
	 	tr += "</select>";
	 	tr += "</td>" */
		
		tr += "</tr>";
		$("#detailTable_body").append(tr);
		
		addRowCnt++;
	}
	
	var deleteArr = new Array();
	function deleteRow(){
		if(gloSelectId == -1){
			alert('시설을 선택해주세요.');
			return;
		}
		deleteArr = new Array();
		var len = $(".DETAIL_TABLE_CHECK:checked").length;
		var flag = false;
		var upPointCd = $("#jstree").jstree("get_node", gloSelectId).id;
		var rootId = $("#jstree").jstree("get_node", gloSelectId).original.root_name;
		for(var i =0;i<len;i++){
			var isNew = $(".DETAIL_TABLE_CHECK:checked").eq(i).attr("class").indexOf("NEW") > -1;
			if(isNew){
				$(".DETAIL_TABLE_CHECK:checked").eq(i).parent().parent().remove();
			}else{
				var pointId = $(".DETAIL_TABLE_CHECK:checked").eq(i).attr("id").split("_")[1];
				var id = $(".DETAIL_TABLE_CHECK:checked").eq(i).attr("id").split("_")[2];
				
				/* var child = $("#jstree").jstree("get_node", id).children.length;
				if(child  > 0){
					flag = true;
					//alert('하위 배출원이 존재하는 항목은 삭제 할 수 없습니다.');
					continue;
				} */
				deleteArr.push({INV_ENG_POINT_DETAIL_ID : pointId , INV_ENG_POINT_CD : upPointCd, ROOT_ID : rootId})
				$(".DETAIL_TABLE_CHECK:checked").eq(i).parent().parent().find("td").eq(1).html("D");
				
			}
		}
		
		if(flag){
			alert('하위 배출원이 존재하는 항목은 삭제 할 수 없습니다.');
		}
		
	}
	function saveRow(){
		if(gloSelectId == -1){
			alert('시설을 선택해주세요.');
			return;
		}
		var saveArr = new Array();
		var newRow = $(".NEW").length;
		
		var upPointCd = $("#jstree").jstree("get_node", gloSelectId).id;
		var rootId = $("#jstree").jstree("get_node", gloSelectId).original.root_name;
		for(var i =0;i<newRow;i++){
			var id = $(".NEW").eq(i).attr("id").split("_")[2];
			var pointName = $("#ADDROW_POINTNAME_"+id).val();
			var code = $("#ADDROW_CODE_"+id).val();
			
			if(pointName == ""){
				alert('배출원은 필수 입력입니다.');
				return;
			}
			
			saveArr.push({ INV_ENG_POINT_NM : pointName , CODE : code , INV_ENG_POINT_CD : upPointCd, ROOT_ID : rootId  });
		} 
		
		var oldArr = new Array();
		var oldRow = $(".OLD").length;
		
		var upPointCd = $("#jstree").jstree("get_node", gloSelectId).id;
		for(var i =0;i<oldRow;i++){
			
			if($(".OLD").eq(i).parent().next().html()== "D"){
				continue;
			}
			
			var id = $(".OLD").eq(i).attr("id").split("_")[1];
			var pointID = $(".OLD").eq(i).attr("id").split("_")[1];
			var pointCD = $(".OLD").eq(i).attr("id").split("_")[2];
			var pointName = $("#UPDATEROW_POINTNAME_"+id).val();
			var code = $("#UPDATEROW_CODE_"+id).val();
			var infoName = $("#UPDATEROW_INFONAME_"+id).val();
			
			if(pointName == ""){
				alert('배출원은 필수 입력입니다.');
				return;
			}
			
			oldArr.push({ INV_ENG_POINT_NM : pointName , CODE : code, DATA_INFO : infoName , INV_ENG_POINT_CD : upPointCd , INV_ENG_POINT_DETAIL_ID : pointID, POINT_CD : pointCD , ROOT_ID : rootId });
		} 
		
		var param = {SAVE : JSON.stringify(saveArr) , DELETE : JSON.stringify(deleteArr), OLD : JSON.stringify(oldArr)};
		callAjax("${pageContext.request.contextPath}/standInfo/standInfo003_saveRow.do",true,'json',param, function(json) {
			alert(json);
			search();
			//$("#jstree").jstree("toggle_node", gloSelectId);
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
					<h1 class="page-title">배출시설 관리</h1>
					<p class="page-subtitle">서울특별시 인벤토리 배출시설 증폐설 관리</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">기준정보</li>
						<li class="breadcrumb-item active">
							<a href="/standInfo/standInfo003.do">배출시설 관리</a>
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
											<%-- <span class="type-name">기준년도</span>
											<select class="" id="year" name="year" style="width: 100px;">
												<option value="" selected>선택</option>
												<c:forEach items="${yearList}" var="list" varStatus="status">
													<option value="${list.YYYY}">${list.YYYY}</option>
												</c:forEach>
											</select> --%>
										</div>
										<div class="checkDiv"></div>
										<div class="checkDiv"></div>
										
										<div class="checkDiv">
											<div class="text-right">
<!-- 												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button> -->
											</div>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-3" style="overflow-y: auto">
									<div id="jstree" class="demo" style="height:457px;overflow:auto"></div>
								</div>
								<div class="col-lg-9" style="overflow-y: auto">
									<table id="listTable" class="table table-project-tasks">
										<colgroup>
											<col width="10%">
											<col width="40%">
											<col width="10%">
											<col width="40%">
										</colgroup>
										<tr>
											<th style="word-break: normal;">부문구분</th>
											<td colspan="3" style="word-break: normal;" id="treeNavi"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">시설 생성일</th>
											<td colspan="3" style="word-break: normal;" id="VIEW_FAC_START_DAY"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">배출 시설명</th>
											<td style="word-break: normal;" id="VIEW_INV_ENG_POINT_NM"></td>
											<th style="word-break: normal;">소유구분</th>
											<td style="word-break: normal;" id="VIEW_OWNER_GUBUN"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">CODE</th>
											<td style="word-break: normal;" id="VIEW_CODE"></td>
											<th style="word-break: normal;">시설 폐쇄 연도</th>
											<td style="word-break: normal;" id="VIEW_FAC_END_DAY"></td>
										</tr>
										<tr>
											<th style="word-break: normal;">배출 활동</th>
											
											<td colspan="3" style="word-break: normal;">
												<div  style="text-align: right; padding-bottom: 10px">
												<button type="button" class="btn btn-primary" aria-expanded="false" style="" onclick="addRow()">행추가</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" style="" onclick="deleteRow()">행삭제</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" style="" onclick="saveRow()">저장</button>
												</div>
												<div  style="max-height: 420px;min-height: 420px; overflow: auto">
													<table id="listTable" class="table table-striped table-project-tasks">
														<colgroup>
															<col width="5%">
															<col width="5%">
															<col width="35%">
															<col width="20%">
															<col width="35%">
														</colgroup>
														<thead>
														<tr>
															<td colspan="2" style="word-break: normal;"></td>
															<td style="word-break: normal;">배출원</td>
															<td style="word-break: normal;">Code</td>
														</tr>
														</thead>
														<tbody id="detailTable_body">
														</tbody>
													</table>
												</div>
											</td>
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
		/* 	 $('#jstree').jstree({
				"plugins" : [ "wholerow",  "changed" ,"checkbox"],
				'core' : {
					'data' : [ { "id" : "ajson1", "PARENT" : "#", "text" : "Simple root node" },
					       { "id" : "ajson2", "PARENT" : "#", "TEXT" : "Root node 2" },
					       { "id" : "ajson3", "PARENT" : "ajson2", "TEXT" : "Child 1" },
					       { "id" : "ajson4", "PARENT" : "ajson2", "TEXT" : "Child 2" }]
				}
			});  */
			
			$('#jstree').jstree({
				"plugins" : [ "wholerow",  "changed" ],
				'core' : {
					'data' : []
				}
			});
			
			search();
			
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