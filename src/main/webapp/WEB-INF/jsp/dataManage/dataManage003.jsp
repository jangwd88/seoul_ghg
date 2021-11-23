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

td,th{
word-break: keep-all !important;
}

.onlyRead{
background-color: #DDD;
}

</style>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
</head>
<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/datatable/datatables.min.css" />
<script src="/resources/openlayers/ol.js"></script>
<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/datatable/datatables.js"></script>
<script src="/resources/js/common/common.js"></script>
<script src="/resources/js/excelExport/excellentexport.js"></script>
<script src="/resources/js/xlsx/xlsx.js"></script>
<script src="/resources/js/xlsx/xlsx.full.min.js"></script>
<script>
	var globalSearchData;
	
	function search() {
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/dataManage/dataManage003_search.do",true,'json',param, function(data) {
			$("#listTable_body").html("");
			
			var searchYear = $("#year").val();
			
			var tr = "";
			for (key in data) {
				isNoData = false;
				tr += '<tr id="'+data[key]["INV_ENG_POINT_ID"]+'_'+searchYear+'">';
				tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_1"]) + '</td>';
				tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_2"]) + '</td>';
				tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_3"]) + '</td>';
				tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_4"]) + '</td>';
				tr += '<td>' + undefinedReplaceEmpty(data[key]["DATA_INFO_NM"]) + '</td>';
				for (var i = 1; i <= 12; i++) {
					
					var isClose = data[key]["CLOSE_YN_" + i] == "Y" ? "readonly disabled" : "";
					tr += '<td>  <input type="text" class="comma" name="MON_'+i+'" id="MON_'+i+'" value="'+undefinedReplaceEmpty(num_comma(data[key]["GHG_VAL_MON_" + i]))+'" '+isClose+'></td>';
				}
				tr += '<td>' + num_comma(data[key]["GHG_VAL_MON_SUM"]) + '</td>';
				tr += '<td>  <input type="text" class="comma" name="GHG_VAL_YEAR" id="GHG_VAL_YEAR_'+data[key]["INV_ENG_POINT_ID"]+'" value="'+num_comma(undefinedReplaceEmpty(data[key]["GHG_VAL_YEAR"]))+'" onkeypress="return isNumberKey(event)" onkeyup="return delHangle(event)"> </td>';
				tr += '</tr>';
			}

			if (isNoData) {
				tr += '<tr>';
				tr += '<td colspan="20">조회된 데이터가 없습니다.</td>';
				tr += '</tr>';
			}
			$("#listTable_body").append(tr);
			
	 		 var t_col = 0;
	 		 if($("gubun").val() == "CRF"){
	 			t_col = 7;
	 		 } else {
	 			t_col = 4;	 			 
	 		 }
	 		 
	 		 $('#listTable_body tr:visible').each(function(row) {
				$('#listTable').colspan(row,t_col);
			});	 		 
	 		 
	 		 $('#listTable_body tr:visible').each(function(row) {
				$('#listTable').rowspan(row,t_col);
			}); 
			
	 	 	$('#listTable').rowspan(0, t_col);
	 	 	$('#listTable').rowspan(1, t_col);
		})
	}

	function saveData(){
		var data = new Object();
		$('#listTable_body tr:visible').each(function(row) {
			
			var len = $(this).find("input").length;
			var tempValueArray= new Array();
			for(var i =0;i<len;i++){
				tempValueArray.push({NAME :	$(this).find("input").eq(i).attr("name"), VALUE : 	$(this).find("input").eq(i).val()  })
			}
			data[$(this).attr("id")] = tempValueArray;
		}); 
		var param = {data : JSON.stringify(data)};
	 	 callAjax("${pageContext.request.contextPath}/dataManage/dataManage003_save.do",true,'text',param, function(data) {
			
		}) 
	}
	
	function sampleDown(){
		location.href= "/sample/GPC.xlsx";
	}
	
</script>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<form id="excelForm" name="excelForm" >
		<input type="hidden" name="excelData" id="excelData">
	</form>
	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/inv_sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">활동자료 등록(간접배출) </h1>
					<p class="page-subtitle">서울특별시 인벤토리 GPC 배출별 자료 등록</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">데이터관리</li>
						<li class="breadcrumb-item active">
							<a href="/dataManage/dataManage003.do">활동자료 등록(간접배출)</a>
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
												<span class="type-name">입력 연도</span> 
												<select class="" id="year" name="year">
													<c:forEach var="item" items="${yearList}">
														<option value="${item.YYYY}">${item.YYYY}</option>
													</c:forEach>
												</select>
											</div>
										
											<div class="checkDiv">
												<span class="type-name">준용연도</span>
												 <select class="" id="applicationYear" name="applicationYear">
													<option value="" selected>전체</option>
													<c:forEach var="item" items="${yearList}">
														<option value="${item.YYYY}">${item.YYYY}</option>
													</c:forEach>
												</select>
											</div>
											<div class="checkDiv">
											</div>
											<div class="checkDiv">
												<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="search();">조회</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="saveData();">저장</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="execute();">등록</button>
												<!-- <button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="openModal('excelUploadModal');">일괄등록</button> -->
												<!-- <button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="sampleDown();">엑셀샘플</button> -->
												
												<!-- <button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">일괄등록 샘플</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="openModal('excelUploadModal');">일괄 등록</button> -->
											</div>
										</div>
								</div>
							</form>
							<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
							</div>
								<div class="col-lg-12" style="max-height: 600; min-height: 600;overflow-y: auto">
									<table id="listTable" class="table table-striped table-project-tasks">
									
										<tr>
											<td colspan="4" style="word-break: normal;">구분</td>
											<td  style="word-break: normal;">입력방법</td>
											<td  style="word-break: normal;">1월</td>
											<td  style="word-break: normal;">2월</td>
											<td  style="word-break: normal;">3월</td>
											<td  style="word-break: normal;">4월</td>
											<td  style="word-break: normal;">5월</td>
											<td  style="word-break: normal;">6월</td>
											<td  style="word-break: normal;">7월</td>
											<td  style="word-break: normal;">8월</td>
											<td  style="word-break: normal;">9월</td>
											<td  style="word-break: normal;">10월</td>
											<td  style="word-break: normal;">11월</td>
											<td  style="word-break: normal;">12월</td>
											<td  style="word-break: normal;">합계</td>
											<td  style="word-break: normal;">확정</td>
										</tr>
										<tbody id="listTable_body">
										</tbody>
									</table>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal fade" id="excelUploadModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog excelUploadModal" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">엑셀 업로드</h5>
					<span id="excelMode" class="red"></span>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form name="excelUploadFrm" id="excelUploadFrm" class="form-inline" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-4 control-label">엑셀 파일 업로드</label>
							<div class="col-sm-8">
								<input id="excelfile" type="file" name="file" class="">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"data-dismiss="modal">취소</button>
					<button onclick="javascript: uploadExcelItem()" type="button" class="btn btn-success pull-right">업로드</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#excelfile").on("change", function(e) {
				var menuId = "${paramMap.menu_id}"
				var files = e.target.files; //input file 객체를 가져온다.
				var i, f;
				var EXCEL_JSON;
				for (i = 0; i != files.length; ++i) {
					f = files[i];
					var reader = new FileReader(); //FileReader를 생성한다.         

					//성공적으로 읽기 동작이 완료된 경우 실행되는 이벤트 핸들러를 설정한다.
					reader.onload = function(e) {

						var data = e.target.result; //FileReader 결과 데이터(컨텐츠)를 가져온다.

						//바이너리 형태로 엑셀파일을 읽는다.
						var workbook = XLSX.read(data,{
										type : 'binary'
									});

						//엑셀파일의 시트 정보를 읽어서 JSON 형태로 변환한다.
						if (workbook.SheetNames[0] != "Sheet1") {
							alert('템플릿 엑셀 다운로드를 통해 받은 엑셀 파일을 첨부하세요.\n시트명을 변경하면 정상적으로 동작하지 않습니다.');
							return;
						}

						workbook.SheetNames.forEach(function(item,index, array) {
							EXCEL_JSON = XLSX.utils.sheet_to_json(workbook.Sheets[item]);
							$("#excelData").val(JSON.stringify(EXCEL_JSON));
						});//end. forEach

					}; //end onload

					//파일객체를 읽는다. 완료되면 원시 이진 데이터가 문자열로 포함됨.
					reader.readAsBinaryString(f);
				}//end. for
			})
		})

		function uploadExcelItem(){
			var originData = $("#excelData").val();
			originData = originData.replace(/12월/gi,"MON_12")
								   .replace(/11월/gi,"MON_11")
								   .replace(/10월/gi,"MON_10")
								   .replace(/1월/gi,"MON_1")
								   .replace(/2월/gi,"MON_2")
								   .replace(/3월/gi,"MON_3")
								   .replace(/4월/gi,"MON_4")
								   .replace(/5월/gi,"MON_5")
								   .replace(/6월/gi,"MON_6")
								   .replace(/7월/gi,"MON_7")
								   .replace(/8월/gi,"MON_8")
								   .replace(/9월/gi,"MON_9")
								   .replace(/확정해당년도/gi,"tot_year")
			var data = JSON.parse(originData);
			var tr = "";
			for(key in data){
				for(var i=1;i<=12;i++){
					$("#"+data[key]["INV_ENG_GHG_YEAR_ID"]+"_"+$("#year").val() + " input[name='MON_"+i+"']").val(data[key]["MON_"+i])
				}
				$("#GHG_VAL_YEAR_"+data[key]["INV_ENG_GHG_YEAR_ID"]).val(data[key]["tot_year"]);
				
			}
				$("#excelUploadModal").modal('hide');
				$("#excelData").val("");
		}
		
		function confirmStat(id) {
			if (id == "modalPop_001") {
				var len = $('.tempYYYYs:checked').length;
				var name = $('.tempYYYYs:checked').eq(0).parent().next().html();
				if (len > 1) {
					$("#dataManageBtn").html(name + "외 " + (len - 1) + " 건");
				} else if (len == 1) {
					$("#dataManageBtn").html(name);
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
			if(id=="excelUploadModal"){
				if($("#listTable_body tr").length == 0){
					alert('조회 후 이용해주세요.');
					return;
				}
				
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
		
		/*   
		 * 같은 값이 있는 열을 병합함  
		 * 사용법 : $('#테이블 ID').rowspan(0);  
		 */
		$.fn.rowspan = function(colIdx, t_col, isStats) {
			return this.each(function() {
				var that;
				$('tr', this).each(function(row) {
					$('td', this).eq(colIdx).filter(':visible').each(function(col) {
						console.log(col);
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

		 function execute(){
			 if($("#year").val() == ""){
				 alert("입력연도를 선택해 주세요.");
				 $("#year").focus();
				 return;
			 }
			 if($("#applicationYear").val() == ""){
				 alert("준용연도를 선택해 주세요.");
				 $("#applicationYear").focus();
				 return;
			 }
			 var param = $("#searchFrm").serialize();
			 callAjax("${pageContext.request.contextPath}/dataManage/dataManage003_execute.do",true,'json',param, function(data) {
				 console.log("data", data);
				 if(data == "S"){
					 alert("성공적으로 처리되었습니다.");
				 }
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