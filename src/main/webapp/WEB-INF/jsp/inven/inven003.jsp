<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<style>  
.merge { background-color:#FF0; color:#03F; text-align:center}  
table td {    vertical-align: middle !important;
    text-align: center !important;
    border: 1px solid #ccc !important;
    }
    
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
}
.display-none{ /*감추기*/
    display:none;
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
<script>
 function search(){
	 if($("#util").val() == ""){
		 alert("조회기간을 선택해 주세요.");
		 return;
	 }
	 var param = $("#searchFrm").serialize();
	 callAjax("${pageContext.request.contextPath}/inven/inven003_search.do", true, 'json', param, function(data){
		 var utilList = $("#util").val() != null && $("#util").val() != "" ? $("#util").val().split(",") : "";
			$("#listTable").html("");
			var tr = "<tbody>";
			tr += '<tr>'
			tr += '<td style="word-break: normal;">배출원</td>'
			tr += '<td style="word-break: normal;">배출원</td>'
			tr += '<td style="word-break: normal;">배출원</td>'
			tr += '<td style="word-break: normal;">배출원</td>'
			tr += '<td style="word-break: normal;">배출원</td>'
			tr += '<td style="word-break: normal;">배출원</td>'
				for (var i = 0; i < utilList.length; i++) {
					tr += '<td style="word-break: normal;">' + utilList[i] + '년</td>';
				}
			tr += '</tr> '

			var isNoData = true;
			for (key in data) {
				isNoData = false;
				tr += '<tr>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_1"] + '</td>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_2"] + '</td>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_3"] + '</td>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_4"] + '</td>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_5"] + '</td>'
				tr += '<td>' + data[key]["INV_ENG_POINT_NM_6"] + '</td>'
				for (var i = 0; i < utilList.length; i++) {
					tr += '<td>' + num_comma(data[key]["GHG_VAL_" + utilList[i]]) + '</td>';
				}
				tr += '</tr> '
			}

			if (isNoData) {
				var searchYearCnt = utilList.length;
				tr += '<tr>'
				tr += '<td colspan="' + (searchYearCnt + 6) + '">조회된 데이터가 없습니다.</td>'
				tr += '</tr>'
			}
			tr += '</tbody>'
			$("#listTable").append(tr);

		 	$('table tbody tr:visible').each(function(row) {  
			   $('#listTable').colspan(row, 6);  
			});
			$('table tbody tr:visible').each(function(cols) {
				$('#listTable').rowspan(cols, 6);
			});
	 });
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
					<h1 class="page-title">세부카테고리 조회</h1>
					<p class="page-subtitle">서울특별시 인벤토리 CRF형식 년간 검색</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">인벤토리 확정</li>
						<li class="breadcrumb-item active">
							<a href="/inven/inven003.do">세부카테고리 조회</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
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
						<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
							<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">엑셀다운로드</button>
						</div>
						<div class="row">
							<div class="col-lg-12" style="max-height: 600; overflow-y: auto">
								<table id="listTable" class="table table-striped table-project-tasks">
									<tr>
										<td style="word-break: normal;">배출원</td>
										<td style="word-break: normal;">배출원</td>
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

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>


<script>
var chart;
var chart2;
var color = Chart.helpers.color;
$(document).ready(function(){
 	$('table tbody tr:visible').each(function(row) {  
		   $('#listTable').colspan(row, 6);  
		 });  
	$('table tbody tr:visible').each(function(cols) {
		   $('#listTable').rowspan(cols, 6);  
		 });  


})

function excelExport() {
	
	
		ExcellentExport.excel(this, 'listTable', "세부카테고리 조회", "세부카테고리 조회", "name");
	}
	
function ExportToExcel(mytblId){
    var htmltable= document.getElementById(mytblId);
    var html = htmltable.outerHTML;
    window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html));
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

/*   
 *   
 * 같은 값이 있는 열을 병합함  
 *   
 * 사용법 : $('#테이블 ID').rowspan(0);  
 *   
 */       
$.fn.rowspan = function(colIdx, t_col, isStats) {         
    return this.each(function(){        
        var that;       
        $('tr', this).each(function(row) {        
            $('td',this).eq(colIdx).filter(':visible').each(function(col) {  
                if ($(this).html() == $(that).html()  
                    && (!isStats   
                            || isStats && $(this).prev().html() == $(that).prev().html()  
                            )  
                    ) {      
                	if(colIdx < t_col){
                    rowspan = $(that).attr("rowspan") || 1;  
                    rowspan = Number(rowspan)+1;  
  
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
 *   
 * 같은 값이 있는 행을 병합함  
 *   
 * 사용법 : $('#테이블 ID').colspan (0);  
 *   
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
							//$(this).remove()
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
	    <div><img src="/resources/images/ajax-loader.gif" /></div>
	</div>  
</body>
</html>