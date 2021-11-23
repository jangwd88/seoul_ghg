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

table .onSelect td {
	background-color: #999;
	color: white;
}
.modalPop_001{
  	max-width: 900px !important;
    /* margin: 7rem auto; */
}

#masterFrm .checkDiv{
	width:280px
}

</style>
</head>
<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/datatable/datatables.min.css" />
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar2.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">코드관리</h1>
					<p class="page-subtitle">서울특별시 인벤토리 부문별 년간 검색</p>
				</div>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card">
							<form name="searchFrm" id="searchFrm">
								<div class="project-heading">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">코드구분</span> 
											<label class="type-label">
												<input type="text" class="input" id="code_nm" name="code_nm" placeholder="검색어를 입력하세요" value="">
											</label>
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
								<div class="col-lg-12" >
									<div class="row">
										<div class="col-md-3">
											<span> > 코드구분 관리 </span>
										</div>
										<div class="col-md-9" style="text-align: right;padding-left:10px; padding-bottom: 10px;padding-right: 32px;">
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="openModal('MmodalPop_001')">추가</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="deleteMaster()">삭제</button>
										</div>
														
									</div>
									<div class="row">
										<div class="col-md-12" style="min-height: 280;max-height: 280; overflow-y: auto">
											<table id="masterListTable" class="table table-striped table-project-tasks">
												<tr>
													<td style="word-break: normal;"></td>
													<td style="word-break: normal;">구분</td>
													<td style="word-break: normal;">구분명</td>
													<td style="word-break: normal;">구분설명</td>
													<td style="word-break: normal;">삭제여부</td>
													<td style="word-break: normal;">사용여부</td>
													<td style="word-break: normal;">편집여부</td>
												</tr>
											</table>
										</div>
									</div>
									
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
								<div class="row">
										<div class="col-md-3">
											<span> > 코드 관리 </span>
										</div>
										<div class="col-md-9" style="text-align: right;padding-left:10px; padding-bottom: 10px;padding-right: 32px;">
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="openModal('DmodalPop_001')">추가</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="deleteDetail()">삭제</button>
										</div>
														
									</div>
									
									<div class="row">
										<div class="col-md-12" style="min-height: 280;max-height: 280; overflow-y: auto">
											<table id="detailLstTable" class="table table-striped table-project-tasks">
												<tr>
													<td style="word-break: normal;"></td>
													<td style="word-break: normal;">코드</td>
													<td style="word-break: normal;">코드명</td>
													<td style="word-break: normal;">코드설명</td>
													<td style="word-break: normal;">코드값</td>
													<td style="word-break: normal;">정렬순서</td>
													<td style="word-break: normal;">삭제여부</td>
													<td style="word-break: normal;">사용여부</td>
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
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal" tabindex="-1" id="MmodalPop_001">
		<div class="modal-dialog modalPop_001">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">코드구분 관리</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" >
						<div class="project-heading">
							<form id="masterFrm" name="masterFrm" onsubmit="return false;">
								<div class="row">
									<div class="checkDiv">
										<span class="type-name">코드 ID</span>
										<input type="text" name="ID_CAT" id="ID_CAT" readonly="readonly">	
									</div>
								</div>
								<div class="row">
									
									<div class="checkDiv">
										<span class="type-name">구분</span>
										<input type="text" name="S_CAT" id="S_CAT">	
									</div>
									<div class="checkDiv">
										<span class="type-name">구분명</span>
										<input type="text" name="S_CAT_DESC" id="S_CAT_DESC">	
									</div>
									<div class="checkDiv">
										<span class="type-name">구분설명</span>
										<input type="text" name="S_CAT_EXP" id="S_CAT_EXP">	
									</div>
								</div>
								<div class="row">
									<div class="checkDiv">
										<span class="type-name">삭제여부</span>
										<input type="checkbox" name="C_DEL_YN" id="C_DEL_YN" value="Y">	
									</div>
									<div class="checkDiv">
										<span class="type-name">사용여부</span>
										<input type="checkbox" name="S_USE_YN" id="S_USE_YN" value="Y">	
									</div>
									<div class="checkDiv">
										<span class="type-name">편집여부</span>
										<input type="checkbox" name="S_EDIT_YN" id="S_EDIT_YN" value="Y">	
									</div>
								</div>
							</form>
						</div>
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="confirmModal('MmodalPop_001')">저장</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" tabindex="-1" id="DmodalPop_001">
		<div class="modal-dialog modalPop_001">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">코드구분 관리</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" >
						<div class="project-heading">
							<form id="detailFrm" name="detailFrm" onsubmit="return false;">
							<input type="hidden" name="ID_CODE" id="ID_CODE">	
								<div class="row">
									<div class="checkDiv">
										<span class="type-name">코드</span>
										<input type="text" name="S_CAT" id="S_CAT" readonly="readonly">	
									</div>
								</div>
								<div class="row">
									<div class="checkDiv">
										<span class="type-name">코드 명</span>
										<input type="text" name="S_CD" id="S_CD">	
									</div>
									<div class="checkDiv">
										<span class="type-name">코드 설명</span>
										<input type="text" name="S_DESC" id="S_DESC">	
									</div>
									<div class="checkDiv">
										<span class="type-name">코드 값</span>
										<input type="text" name="S_VAL" id="S_VAL">	
									</div>
								</div>
								<div class="row">
									<div class="checkDiv">
										<span class="type-name">정렬순서</span>
										<input type="text" name="N_ORDER" id="N_ORDER" value="0">	
									</div>
									<div class="checkDiv">
										<span class="type-name">삭제여부</span>
										<input type="checkbox" name="C_DEL_YN" id="C_DEL_YN" value="Y">	
									</div>
									
								</div>
							</form>
						</div>
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="confirmModal('DmodalPop_001')">저장</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
	
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<script>
	
		 $(document).on("click",".codeMaster td",function(){
			var trele = $(this).parent();
			var tdele = $(this);
			$(".onSelect").removeClass("onSelect");
			$(trele).addClass("onSelect");
			var codeId = $(trele).attr("id");
			var rowidx = $(trele).attr("rowidx");
			globalMasterSelect = rowidx;
			reloadDetailGid(codeId)
		}); 
		
		function reloadDetailGid(codeId){
			detailArr = new Array();
			var param = {S_CAT : codeId};
			callAjax("${pageContext.request.contextPath}/codeManage/detailCodeData.do",true,'json',param, function(data) {
				var tr = "";
				for(key in data){
					detailArr.push(data[key]);
					tr += "<tr class='codeDetail' id='"+data[key]["ID_CODE"]+"' rowidx='"+key+"'>";
					tr += "<td><input type='checkbox' name='detailCheckbox' ></td>";
					tr += "<td>"+data[key]["S_CAT"]+"</td>";
					tr += "<td>"+data[key]["S_CD"]+"</td>";
					tr += "<td>"+data[key]["S_DESC"]+"</td>";
					tr += "<td>"+data[key]["S_VAL"]+"</td>";
					tr += "<td>"+data[key]["N_ORDER"]+"</td>";
					tr += "<td>"+data[key]["C_DEL_YN"]+"</td>";
					tr += "<td>Y</td>";
					tr += "</tr>";
				}
				
				if(data.length == 0){
					tr += "<tr class='codeDetail'>";
					tr += "<td colspan='8'>조회된 결과가 없습니다.</td>";
					tr += "</tr>";
				}
				
				$(".codeDetail").remove();
				$("#detailLstTable").append(tr);
			});
		}
		 
		$(document).on("dblclick",".codeMaster td",function(){
			$("#masterFrm")[0].reset();
			var trele = $(this).parent();
			var tdele = $(this);
			
			var codeId = $(trele).attr("id");
			var selectArr = getJsonFilter(masterArr,"S_CAT",codeId)[0];
			for(key in selectArr ){
				if(key == "S_USE_YN" || key == "S_EDIT_YN" || key == "C_DEL_YN"){
					if(selectArr[key] == "Y"){
						$("#masterFrm #"+key).prop("checked",true);
					}else{
						$("#masterFrm #"+key).prop("checked",false);
					}
				}else{
					$("#masterFrm #"+key).val(selectArr[key]);
				}
			}
			$("#MmodalPop_001").modal('show');
		});
		
		$(document).on("dblclick",".codeDetail td",function(){
			$("#detailFrm")[0].reset();
			var trele = $(this).parent();
			var tdele = $(this);
			var codeId = $(trele).attr("id");
			
			var selectMasterData = masterArr[globalMasterSelect];
			$("#detailFrm #S_CAT").val(selectMasterData["S_CAT"]);
			var selectArr = getJsonFilter(detailArr,"ID_CODE",codeId)[0];
			for(key in selectArr ){
				if(key == "C_DEL_YN"){
					if(selectArr[key] == "Y"){
						$("#detailFrm #"+key).prop("checked",true);
					}else{
						$("#detailFrm #"+key).prop("checked",false);
					}
				}else{
					$("#detailFrm #"+key).val(selectArr[key]);
				}
			}
			$("#DmodalPop_001").modal('show');
		});
	
		$(document).ready(function() {
			search(); 
		})

		function excelExport() {
			ExcellentExport.excel(this, 'listTable', "부문별 추정 배출량", "부문별 추정 배출량", "name");
		}

		function confirmModal(id) {
			if (id == "MmodalPop_001") {
				var param = $("#masterFrm").serialize();
				callAjax("${pageContext.request.contextPath}/codeManage/addNUpdateCodeMaster.do",true,'json',param, function(data) {
					search();
				});

			}else if(id == "DmodalPop_001"){
				var param = $("#detailFrm").serialize();
				callAjax("${pageContext.request.contextPath}/codeManage/addNUpdateCodeDetail.do",true,'json',param, function(data) {
					reloadDetailGid(masterArr[globalMasterSelect]["S_CAT"]);
				});
			}
			$("#" + id).modal('hide');
		}

		function openModal(id) {
			if (id == "MmodalPop_001") {
				$("#masterFrm")[0].reset();
			}else if(id == "DmodalPop_001"){
				$("#detailFrm")[0].reset();
				var selectMasterData = masterArr[globalMasterSelect];
				$("#detailFrm #S_CAT").val(selectMasterData["S_CAT"]);
			}
			
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

		function deleteMaster(){
			var len = $("input[name='masterCheckbox']:checked").length;
			if(len == 0){
				alert('항목이 선택되지 않았습니다.');
				return;
			}
			
			var deleteIdArr = "";
			for(var i =0;i<len;i++){
				var rowidx = $("input[name='masterCheckbox']:checked").eq(i).parent().parent().attr("rowidx");
				
				console.log(masterArr[rowidx])
				deleteIdArr += masterArr[rowidx]["ID_CAT"]+",";
			}
			deleteIdArr = deleteIdArr.substr(0,deleteIdArr.lastIndexOf(","));
			
			if(confirm('하위 코드 모두가 삭제됩니다. 계속하시겠습니까?')){
				var param = {DELETE_LIST : deleteIdArr}
				callAjax("${pageContext.request.contextPath}/codeManage/deleteCodeMaster.do",true,'json',param, function(data) {
					search();
					reloadDetailGid(masterArr[globalMasterSelect]["S_CAT"]);
				});
			}
		}
		
		function deleteDetail(){
			var len = $("input[name='detailCheckbox']:checked").length;
			if(len == 0){
				alert('항목이 선택되지 않았습니다.');
				return;
			}
			
			var deleteIdArr = "";
			for(var i =0;i<len;i++){
				var rowidx = $("input[name='detailCheckbox']:checked").eq(i).parent().parent().attr("rowidx");
				deleteIdArr += detailArr[rowidx]["ID_CODE"]+",";
			}
			deleteIdArr = deleteIdArr.substr(0,deleteIdArr.lastIndexOf(","));
			
			if(confirm('선택하신 코드가 삭제됩니다. 계속하시겠습니까?')){
				var param = {DELETE_LIST : deleteIdArr}
				callAjax("${pageContext.request.contextPath}/codeManage/deleteCodeDetail.do",true,'json',param, function(data) {
					reloadDetailGid(masterArr[globalMasterSelect]["S_CAT"]);
				});
			}
		}
		
	</script>
	<script src="/resources/js/datatable/datatables.js"></script>
	<script src="/resources/js/excelExport/excellentexport.js"></script>
	<script>
	var masterArr = new Array();
	var detailArr = new Array();
	var globalMasterSelectIdx = "";
		function search() {
			var param = $("#searchFrm").serialize();
			callAjax("${pageContext.request.contextPath}/codeManage/masterCodeData.do",true,'json',param, function(data) {
				var tr = "";
				masterArr = new Array();
				for(key in data){
					masterArr.push(data[key]);
					tr += "<tr class='codeMaster' id='"+data[key]["S_CAT"]+"' rowidx='"+key+"'>";
					tr += "<td><input type='checkbox' name='masterCheckbox'></td>";
					tr += "<td>"+data[key]["S_CAT"]+"</td>";
					tr += "<td>"+data[key]["S_CAT_DESC"]+"</td>";
					tr += "<td>"+data[key]["S_CAT_EXP"]+"</td>";
					tr += "<td>"+data[key]["C_DEL_YN"]+"</td>";
					tr += "<td>"+data[key]["S_USE_YN"]+"</td>";
					tr += "<td>"+data[key]["S_EDIT_YN"]+"</td>";
					tr += "</tr>";
				}
				
				if(data.length == 0){
					tr += "<tr class='codeMaster'>";
					tr += "<td colspan='7'>조회된 결과가 없습니다.</td>";
					tr += "</tr>";
				}
				
				$(".codeMaster").remove();
				$("#masterListTable").append(tr);
			});
		}
	
	
	</script>
</body>
</html>