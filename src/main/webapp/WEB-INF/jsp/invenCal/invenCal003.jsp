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
var dynamicColors = function() {
	var r = Math.floor(Math.random() * 255);
	var g = Math.floor(Math.random() * 255);
	var b = Math.floor(Math.random() * 255);
	return "rgb(" + r + "," + g + "," + b + ",0.7)";
};

var globalSearchData;

 function search(){
	if($("#year").val() == ""){
		alert("검색년도 선택해 주세요.");
		$("#year").focus();
		return;
	}
	var param = $("#searchFrm").serialize();
	callAjax("${pageContext.request.contextPath}/invenCal/invenCal003_search.do", true, 'json', param, function(data){
		globalSearchData = data;
		console.log(data)
		
		var tr = "";
		for (key in data) {
			isNoData = false;
			tr += '<tr>';
			tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_1"]) + '</td>';
			tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_2"]) + '</td>';
			tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_3"]) + '</td>';
			tr += '<td>' + undefinedReplaceEmpty(data[key]["INV_ENG_POINT_NM_4"]) + '</td>';
			tr += '<td>' + num_comma(data[key]["YEAR_VAL_RATIO"]) + '</td>';
			tr += '<td>' + num_comma(data[key]["GHG_VAL"]) + '</td>';
			tr += '</tr>';
		}

		if (isNoData) {
			tr += '<tr>';
			tr += '<td colspan="6">조회된 데이터가 없습니다.</td>';
			tr += '</tr>';
		}
		$("#tbody").append(tr);
		
		 $('#tbody tr:visible').each(function(row) {
				$('#listTable tbody').colspan(row,4);
		}); 
		
	 	$('#tbody tr:visible').each(function(cols) {
			$('#listTable tbody').rowspan(cols, 4);
		});
 		createChartData(data);
	});
 }
 
 
 function createChartData(data){
 	var dataset = new Array();
 	var labelArr = new Array();
 	
 	labelArr.push("에너지");
 	labelArr.push("폐기물");
 	labelArr.push("산업공정 및 제품생산");
 	labelArr.push("농업, 산림 및 기타 토지이용");
 	
 	var dColor1 = dynamicColors();
	var dColor2 = dynamicColors();
 	
	dataset.push({
		type: 'bar',
		label : '배출량합계(Tco2)',
		yAxisID: 'y-axis-1',
		data : [getJsonFilter(data,"ENG_CODE","ENG_TOT")[0]["GHG_VAL"], 
			    getJsonFilter(data,"ENG_CODE","WASTE")[0]["GHG_VAL"],
			    getJsonFilter(data,"ENG_CODE","I_TOT")[0]["GHG_VAL"],
			    getJsonFilter(data,"ENG_CODE","F_TOT")[0]["GHG_VAL"]
		],
		backgroundColor : color(dColor1).alpha(0.5).rgbString(),
		borderColor : dColor1,
		fill :false
	})
 	
	dataset.push({
		type: 'line',
		label : '3년 평균비중(%)',
		yAxisID: 'y-axis-2',
		data : [getJsonFilter(data,"ENG_CODE","ENG_TOT")[0]["YEAR_VAL_RATIO"].replace(/%/gi,""), 
			    getJsonFilter(data,"ENG_CODE","WASTE")[0]["YEAR_VAL_RATIO"].replace(/%/gi,""),
			    getJsonFilter(data,"ENG_CODE","I_TOT")[0]["YEAR_VAL_RATIO"].replace(/%/gi,""),
			    getJsonFilter(data,"ENG_CODE","F_TOT")[0]["YEAR_VAL_RATIO"].replace(/%/gi,"")
		],
		backgroundColor : color(dColor2).alpha(0.5).rgbString(),
		linetenstion:0.2,
		borderColor : dColor2,
		fill :false
	})
 	createChart(dataset);
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
					<h1 class="page-title">부문별 통계</h1>
					<p class="page-subtitle">서울특별시 인벤토리 부문별 통계 검색</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">인벤토리 추정</li>
						<li class="breadcrumb-item active">
							<a href="invenCal/invenCal003.do">부문별 통계</a>
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
										<span class="type-name">조회기간</span> <!-- <input type="hidden" name="util" id="util">
										<button type="button" class="btn btn-primary" aria-expanded="false" id="invenBtn" onclick="openModal('modalPop_001')">전체</button> -->
										<select class="" id="year" name="year">
											<option value="" selected>선택</option>
											<option value="2020" selected>2020</option>
											<%-- <c:forEach items="${yearList}" var="list" varStatus="status">
												<option value="${list.YYYY}">${list.YYYY}</option>
											</c:forEach> --%>
										</select>
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
									<canvas id="chart" width="1500" height="220"></canvas>
								</div>
							</div>
						<div class="text-right" style="margin-right: 15px; margin-bottom: 5px">
							<button type="button" class="btn btn-primary" aria-expanded="false" id="excelDownload" onclick="excelExport();">엑셀다운로드</button>
						</div>
						<div class="row">
							<div class="col-lg-12" style="max-height: 400; overflow-y: auto">
								<table id="listTable" class="table table-striped table-project-tasks">
									<tr>
										<td colspan="4" style="word-break: normal;">배출원</td>
										<td style="word-break: normal;">3년평균 비중(%)</td>
										<td style="word-break: normal;">배출량 합계(Tco2)</td>
									</tr>
									<tbody id="tbody">
									
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


<script>
var chart;
var color = Chart.helpers.color;
$(document).ready(function(){
	createChart();
	$('table tbody tr:visible').each(function(cols) {
		   $('#listTable').rowspan(cols, 4);  
		 })  


 	$('table tbody tr:visible').each(function(row) {  
		   $('#listTable').colspan(row, 4);  
		 })  
})

function excelExport() {
		ExcellentExport.excel(this, 'listTable', "세부카테고리 조회", "세부카테고리 조회", "name");
	}
	
function confirmStat(id) {
	if (id == "modalPop_001") {
		var len = $('.tempYYYYs:checked').length;
		var name = $('.tempYYYYs:checked').eq(0).parent().next().html();
		if (len > 1) {
			$("#invenBtn").html(name + "외 " + (len - 1) + " 건");
		} else if (len == 1) {
			$("#invenBtn").html(name);
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

function createChart(dataset) {
	if(chart != undefined){
		chart.destroy();
	}
	var chartData ={
		labels: ['에너지','폐기물','산업공정 및 제품생산','농업, 산림 및 기타 토지이용'],
		datasets : dataset
	}
	
	chart = new Chart($("#chart"),
			{
				type : 'bar',
				data : chartData,
				options : {

					responsive : false,
					scales : {
						yAxes: [{
							type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
							display: true,
							position: 'left',
							id: 'y-axis-1',
						}, {
							type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
							display: true,
							position: 'right',
							id: 'y-axis-2',
							gridLines: {
								drawOnChartArea: false
							}
						}]
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
    return this.each(function(){  
          
 var that;  
  $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
	  console.log(this)
  $(this).find('td').filter(':visible').each(function(col) {  
	  if(col < t_col) {
      if ($(this).html() == $(that).html()) {  
        colspan = $(that).attr("colSpan");  
        if (colspan == undefined) {  
          $(that).attr("colSpan",1);  
          colspan = $(that).attr("colSpan");  
        }  
        colspan = Number(colspan)+1;  
        $(that).attr("colSpan",colspan);  
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
	    <div><img src="/resources/images/ajax-loader.gif" /></div>
	</div>  
</body>
</html>