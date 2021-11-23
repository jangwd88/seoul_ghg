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
input[type="text"]{
	border: 0;
    background-color: transparent;
    height: 100%;
     min-width:80px;
    width: 100%;
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
<script src="/resources/openlayers/ol.js"></script>
<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/datatable/datatables.js"></script>
<script src="/resources/js/common/common.js"></script>
<script src="/resources/js/excelExport/excellentexport.js"></script>
<script>
	function search() {
		var param = $("#searchFrm").serialize();
		callAjax("${pageContext.request.contextPath}/invenCal/invenCal001_search.do",true,'json',param, function(data) {
		
		});
	}


</script>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<!-- LEFT SIDEBAR -->
	<div id="sidebar-nav" class="sidebar">
		<nav>
			<ul class="nav" id="sidebar-nav-menu">
			
				<li class="">
					<a href="/inven/inven009.do" aria-expanded="" class="">
						<i class="ti-layout-grid2"></i>
						<span class="title">인벤토리 추세</span>
					</a>
				</li>
				
				<li class="panel"><a href="#inven" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class=""> <i class="ti-layout-grid2"></i> <span class="title">인벤토리</span> <i
						class="icon-submenu ti-angle-left"></i>
				</a>
					<div id="inven" class="collapse  ">
						<ul class="submenu">
							<li><a href="/inven/inven001.do" class="">부문별 조회</a></li>
							<li><a href="/inven/inven002.do" class="">직.간접 조회</a></li>
							<li><a href="/inven/inven003.do" class="">세부카테고리 조회</a></li>
							<!-- <li><a href="/inven/inven004.do" class="">GPC 조회</a></li> -->
						</ul>
					</div></li>
				<li class="panel"><a href="#invenCal" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class=""> <i class="ti-layout-grid2"></i> <span class="title">인벤토리 추정</span> <i
						class="icon-submenu ti-angle-left"></i>
				</a>
					<div id="invenCal" class="collapse  ">
						<ul class="submenu">
							<li><a href="/invenCal/invenCal001.do" class="">부문별 추정배출량</a></li>
							
							<li><a href="/invenCal/invenCal003.do" class="">부문별 통계</a></li>
						</ul>
					</div></li>
				<c:if test="${loginInfo.AUTH_INFO == '1'}">
				<li class="panel"><a href="#standInfo" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class=""> <i class="ti-layout-grid2"></i> <span class="title">기준정보</span> <i
						class="icon-submenu ti-angle-left"></i>
				</a>
					<div id="standInfo" class="collapse  show">
						<ul class="submenu">
							<li><a href="/standInfo/standInfo003.do" class="">배출시설 관리</a></li>
							<li><a href="/standInfo/standInfo004.do" class="">배출계수 관리</a></li>
						</ul>
					</div></li>
				<li class="panel"><a href="#dataManage" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class=""> <i class="ti-layout-grid2"></i> <span class="title">데이터관리</span> <i
						class="icon-submenu ti-angle-left"></i>
				</a>
					<div id="dataManage" class="collapse  ">
						<ul class="submenu">
							<li><a href="/dataManage/dataManage001.do" class="">활동자료 등록(직접배출)</a></li>
							<li><a href="/dataManage/dataManage003.do" class="">활동자료 등록(간접배출) </a></li>
							<li><a href="/dataManage/dataManage002.do" class="">마감관리</a></li>
						</ul>
					</div></li>
				</c:if>
			</ul>
			<button type="button" class="btn-toggle-minified" title="Toggle Minified Menu">
				<i class="ti-arrows-horizontal"></i>
			</button>
		</nav>
	</div>
	<!-- END LEFT SIDEBAR -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">배출원 관리(간접)</h1>
					<p class="page-subtitle">서울특별시 인벤토리 간접 배출원별 계수 관리</p>
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
											<button type="button" class="btn btn-primary" aria-expanded="false" >외부전기</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" >외부열</button>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-12" style="max-height: 300; overflow-y: auto">
									<div class="row">
										<div class="col-md-3">
											<span> > 배출원 등록 </span>
										</div>
										<div class="col-md-9" style="text-align: right;padding-left:10px; padding-bottom: 10px">
											<button type="button" class="btn btn-primary" aria-expanded="false" >편집</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" >삭제</button>
										</div>
														
									</div>
									<table id="listTable" class="table table-striped table-project-tasks">
										<thead>
										<tr>
											<td rowspan="2" style="word-break: normal;"></td>
											<td rowspan="2" style="word-break: normal;">사용에너지원</td>
											<td rowspan="2" style="word-break: normal;">정부보고 에너지원</td>
											<td rowspan="2" style="word-break: normal;">단위</td>
											<td rowspan="2" style="word-break: normal;">정부보고 단위</td>
											<td rowspan="2" style="word-break: normal;">단위환산계수</td>
											<td rowspan="2" style="word-break: normal;">배출활동구분</td>
											<td colspan="3" style="word-break: normal;">산정 Tier</td>
										</tr>
										<tr>
											<td style="word-break: normal;">산정식</td>
											<td style="word-break: normal;">활동도</td>
											<td style="word-break: normal;">배출계수</td>
										</tr>
										</thead>
										<tbody>
											<tr>
											<td style="word-break: normal;"><input type="checkbox"></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><select><option></option></select></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><select><option></option></select></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><select><option></option></select></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><input type="text"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12" style="max-height: 300; overflow-y: auto">
								<div class="row">
										<div class="col-md-3">
											<span> > 배출계수 등록 </span>
										</div>
										<div class="col-md-9" style="text-align: right;padding-left:10px; padding-bottom: 10px">
											<button type="button" class="btn btn-primary" aria-expanded="false" >편집</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" >삭제</button>
										</div>
														
									</div>
									<table id="listTable" class="table table-striped table-project-tasks">
										<thead>
										<tr>
											<td rowspan="2" style="word-break: normal;"></td>
											<td rowspan="2" style="word-break: normal;">연도</td>
											<td rowspan="2" style="word-break: normal;">총발열량 <br> (MJ / 정부보고 단위)</td>
											<td colspan="3" style="word-break: normal;">배출계수</td>
										</tr>
										<tr>
											<td style="word-break: normal;">CO2(kgCO2/toe)</td>
											<td style="word-break: normal;">CH4(kgCH4/toe)</td>
											<td style="word-break: normal;">N2O(kgN2O/toe)</td>
										</tr>
										</thead>
										<tbody>
											<tr>
											<td style="word-break: normal;"><input type="checkbox"></td>
											<td style="word-break: normal;"><select><option></option></select></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><input type="text"></td>
											<td style="word-break: normal;"><input type="text"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="text-align: right">
									<button type="button" class="btn btn-primary" aria-expanded="false" >수정</button>
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
	<script>
		$(document).ready(function() {
			$('table tbody tr:visible').each(function(cols) {
				$('#listTable').rowspan(cols);
			})

			$('table tbody tr:visible').each(function(row) {
				$('#listTable').colspan(row);
			})
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

		
		/*   
		 * 같은 값이 있는 열을 병합함  
		 * 사용법 : $('#테이블 ID').rowspan(0);  
		 */
		$.fn.rowspan = function(colIdx, isStats) {
			return this.each(function() {
				var that;
				$('tr', this).each(function(row) {
					$('td', this).eq(colIdx).filter(':visible').each(function(col) {
						console.log(col);
						if ($(this).html() == $(that).html() && (!isStats || isStats && $(this).prev().html() == $(that).prev().html())) {
							rowspan = $(that).attr("rowspan") || 1;
							rowspan = Number(rowspan) + 1;
							$(that).attr("rowspan",rowspan);
							// do your action for the colspan cell here              
							$(this).hide();
							//$(this).remove();   
							// do your action for the old cell here  

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
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>