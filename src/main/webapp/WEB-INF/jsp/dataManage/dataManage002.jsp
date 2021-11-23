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

.monthDataManager{
  	max-width: 1600px !important;
    /* margin: 7rem auto; */
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
		var gubun = $("#gubun").val();
		if( gubun == "CRF" ){
			callAjax("${pageContext.request.contextPath}/dataManage/dataManage001_search.do",true,'json',param, function(data) {
				$("#listTable").html("");
				var tr = "<thead>";
					tr += '<tr>'
					tr += '<td  style="word-break: normal;">1</td>'
					tr += '<td  style="word-break: normal;">1A</td>'
					tr += '<td  style="word-break: normal;">1A1</td>'
					tr += '<td  style="word-break: normal;">1A1a</td>'
					tr += '<td  style="word-break: normal;">1A1ai</td>'
					tr += '<td  style="word-break: normal;">1A1ai1</td>'
					tr += '<td  style="word-break: normal;">Code</td>'
					tr += '<td  style="word-break: normal;">입력방법</td>'
					tr += '<td  style="word-break: normal;">1월</td>'
					tr += '<td  style="word-break: normal;">2월</td>'
					tr += '<td  style="word-break: normal;">3월</td>'
					tr += '<td  style="word-break: normal;">4월</td>'
					tr += '<td  style="word-break: normal;">5월</td>'
					tr += '<td  style="word-break: normal;">6월</td>'
					tr += '<td  style="word-break: normal;">7월</td>'
					tr += '<td  style="word-break: normal;">8월</td>'
					tr += '<td  style="word-break: normal;">9월</td>'
					tr += '<td  style="word-break: normal;">10월</td>'
					tr += '<td  style="word-break: normal;">11월</td>'
					tr += '<td  style="word-break: normal;">12월</td>'
					tr += '<td  style="word-break: normal;">합계</td>'
					tr += '<td  style="word-break: normal;">확정</td>'
					tr += '</tr>'
					tr += '</thead>'
			
					tr +='<tbody id="listTable_body">';
				for (key in data) {
					console.log(data[key])
					isNoData = false;
					if(data[key]["DATA_INFO"] == "3"){
						
						tr += "<tr onclick='openModal(\"monthDataManager\",\""+data[key]["CODE"]+"\")' style='cursor:pointer;'>";
					}else{
						tr += '<tr>';
					}
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_1"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_2"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_3"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_4"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_5"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_6"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["CODE"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["DATA_INFO_NM"]) + '</td>';
					for (var i = 1; i <= 12; i++) {
						var isCloseClass = data[key]["CLOSE_YN_" + i] == "Y" ? "onlyRead" : ""; 
						
						
						tr += '<td class="'+isCloseClass+'">' + undefinedReplaceEmpty(num_comma(data[key]["GHG_VAL_MON_" + i])) + '</td>';
					}
					tr += '<td>' + num_comma(data[key]["GHG_VAL_MON_SUM"]) + '</td>';
					tr += '<td>'+num_comma(data[key]["GHG_VAL_YEAR"])+'</td>';
					tr += '</tr>';
				}
				tr +='</tbody>';
				if (isNoData) {
					tr += '<tr>';
					tr += '<td colspan="20">조회된 데이터가 없습니다.</td>';
					tr += '</tr>';
				}
				$("#listTable").append(tr);
				
		 		$('#listTable_body tr:visible').each(function(row) {
					$('#listTable').colspan(row, 6);
				}); 
				
				$('#listTable_body tr:visible').each(function(cols) {
					$('#listTable').rowspan(cols, 4);
				});
				
			})
		}else{
			callAjax("${pageContext.request.contextPath}/dataManage/dataManage003_search.do",true,'json',param, function(data) {
				$("#listTable").html("");
				
				var searchYear = $("#year").val();
				
				var tr = "<tbody>";
					tr +='<tr>'
					tr +='<td colspan="4" style="word-break: normal;">구분</td>'
					tr +='<td  style="word-break: normal;">입력방법</td>'
					tr +='<td  style="word-break: normal;">1월</td>'
					tr +='<td  style="word-break: normal;">2월</td>'
					tr +='<td  style="word-break: normal;">3월</td>'
					tr +='<td  style="word-break: normal;">4월</td>'
					tr +='<td  style="word-break: normal;">5월</td>'
					tr +='<td  style="word-break: normal;">6월</td>'
					tr +='<td  style="word-break: normal;">7월</td>'
					tr +='<td  style="word-break: normal;">8월</td>'
					tr +='<td  style="word-break: normal;">9월</td>'
					tr +='<td  style="word-break: normal;">10월</td>'
					tr +='<td  style="word-break: normal;">11월</td>'
					tr +='<td  style="word-break: normal;">12월</td>'
					tr +='<td  style="word-break: normal;">합계</td>'
					tr +='<td  style="word-break: normal;">확정</td>'
					tr +='</tr>'
					tr +='</tbody>'
					
					tr +='<tbody id="listTable_body">';
				
				for (key in data) {
					isNoData = false;
					tr += '<tr id="'+data[key]["INV_ENG_POINT_ID"]+'_'+searchYear+'">';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_1"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_2"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_3"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_4"]) + '</td>';
					tr += '<td>' + undefinedReplaceEmpty(data[key]["DATA_INFO_NM"]) + '</td>';
					for (var i = 1; i <= 12; i++) {
						tr += '<td>'+undefinedReplaceEmpty(num_comma(data[key]["GHG_VAL_MON_" + i]))+'</td>';
					}
					tr += '<td>'+num_comma(data[key]["GHG_VAL_MON_SUM"]) + '</td>';
					tr += '<td>'+num_comma(undefinedReplaceEmpty(data[key]["GHG_VAL_YEAR"]))+'</td>';
					tr += '</tr>';
				}
				tr +='</tbody>';
				
				if (isNoData) {
					tr += '<tr>';
					tr += '<td colspan="20">조회된 데이터가 없습니다.</td>';
					tr += '</tr>';
				}
				$("#listTable").html(tr);
				
		 		 $('#listTable_body tr:visible').each(function(row) {
					$('#listTable').colspan(row,4);
				}); 
				
		 	 	$('#listTable').rowspan(0, 4);
		 	 	$('#listTable').rowspan(1, 4);
			})
		}
	}
	
	function closemMonth(){
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/dataManage/dataManage002_close.do",true,'json',param, function(data) {
			alert(data);
			search();
		})
	}
	
	function closeCancel(){
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/dataManage/dataManage002_closeCancel.do",true,'json',param, function(data) {
			alert(data);
			search();
		})
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
					<h1 class="page-title">마감관리</h1>
					<p class="page-subtitle">서울특별시 인벤토리 배출별 자료 월별로 마감처리</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">데이터관리</li>
						<li class="breadcrumb-item active">
							<a href="/dataManage/dataManage002.do">마감관리</a>
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
											<span class="type-name">구분</span> 
											 <select class="" id="gubun" name="gubun">
												<option value="CRF" >활동자료 등록(직접배출)</option>
												<option value="GPC" >활동자료 등록(간접배출)</option>
											</select>
										</div>
										<div class="checkDiv">
											<span class="type-name">년월</span> 
											<select class="" id="year" name="year">
												<c:forEach var="item" items="${yearList}">
													<option value="${item.YYYY}">${item.YYYY}</option>
												</c:forEach>
											</select>
											<select class="" id="month" name="month">
												<c:forEach begin="1" end="12" var="i">
													<option value="${i}">  ${i}</option>
												</c:forEach>
											</select> 
										</div>
										<div class="checkDiv">
										</div>
										<div class="checkDiv">
											<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
												<button type="button" class="btn btn-primary" aria-expanded="false" onclick="search()">조회</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" onclick="closemMonth()">마감</button>
												<button type="button" class="btn btn-primary" aria-expanded="false" onclick="closeCancel()">마감취소</button>
											</div>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-12" style="max-height: 600; min-height: 600;overflow-y: auto">
									<table id="listTable" class="table table-striped table-project-tasks">
										<tr>
											<td  style="word-break: normal;"></td>
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
	
	<div class="modal fade" id="monthDataManager" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog monthDataManager" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="title"></h5>
					<span id="excelMode" class="red"></span>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body" style="    max-height: 400px; overflow: auto;">
					<form name="tableFrm" id="tableFrm" class="form-inline" method="post" enctype="multipart/form-data">
						
						<table id="monthTable" class="table table-striped table-project-tasks">
										<tr>
											<td  style="word-break: normal;">에너지원</td>
											<td  style="word-break: normal;">필수여부</td>
											<td  style="word-break: normal;">단위</td>
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
											<td  style="word-break: normal;" id="month_year">2019</td>
											
										</tr>
										<tbody id="monthTable_body">
										</tbody>
										
										
									</table>
						
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"data-dismiss="modal">닫기</button>
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

		})

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

		function openModal(id,title) {
			
			if(id == "monthDataManager"){
				$("#month_year").html($("#year").val());
				$("#title").html(title);
				
				var param = {INV_ENG_POINT_CODE : title , year : $("#year").val()}
				
				callAjax("${pageContext.request.contextPath}/dataManage/dataManage001_getCRFMonthData.do",true,'json',param, function(data) {
					var tr = "";
					for(key in data){
						//tr += "<tr>";
						tr += "<tr id='"+data[key]["S_CD"]+"_"+$("#year").val()+"_"+data[key]["ENG_UNIT"]+"'>";
						tr += "<td>"+ data[key]["S_DESC"] +"</td>";
						tr += "<td>"+ undefinedReplaceEmpty(data[key]["VITAL_YN"]) +"</td>";
						tr += "<td>"+ undefinedReplaceEmpty(data[key]["ENG_UNIT_NM"]) +"</td>";
						
						var sum = 0;
						var isVital = '';
						for(var i=1;i<=12;i++){
							var id = data[key]["S_CD"] + "_"  + $("#year").val()+ "_" + "N_ENG_"+ i;
							var val = data[key]["N_ENG_"+i] == undefined ? 0 : Number( String(data[key]["N_ENG_"+i]).replace(/,/gi,""));
							sum += val;
							if(data[key]["VITAL_YN"] == "Y"){
								isVital = 'req';
							}else{
								isVital = '';
							}
							tr += "<td>"+num_comma(val)+"</td>";
						}
							tr += "<td>"+num_comma(sum)+"</td>";
						
						tr += "</tr>"
					}
					
					if(data.length == 0){
						tr += "<tr>"
						tr += "<td colspan='16'>조회된 데이터가 없습니다.</td>"
						tr += "<tr>"
					}
					
						$("#monthTable_body").html(tr);
				})
				
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
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>