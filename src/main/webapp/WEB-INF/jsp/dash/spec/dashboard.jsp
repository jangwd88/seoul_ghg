<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />

<style>
:root { 
	--popover-header-color: #4661ae;
	--popover-border-color: #4661ae;
}

#invenBox {
	float: left;
	margin-right: 30px;
	width: 760px;
	height: 170px;
}

#archBox {
	display: inline-block;
	width: 760px;
	height: 170px;
	float: right;
}

#reducedH tr th {
	padding-top: 5px;
	padding-bottom: 5px;
}

#reducedH tr td {
	padding-top: 5px;
	padding-bottom: 5px;
}

td {
	border: 1px solid #d1d6e6;
}

/* popup css*/
.popover {
	border: 1px solid var(--popover-border-color) !important;
}
.popover .popover-header{
    background-color: var(--popover-header-color);
    padding: 6px 8px 6px 8px;
    border-bottom:0;
	font-family: 'SeoulNamsan';
	font-size: 8pt;
	line-height: 8pt;
	font-weight: 900;
	overflow: hidden;
	text-align: center;
	color: #FFFFFF;
	
	width:180px;
}

.popover .popover-body{
	padding:0;
	
	font-family: 'SeoulNamsan';
	font-size: 7pt;
	line-height: 7pt;
	
	color: #888888;
}

.popover .popup-row{
	display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    width:180px;
}

.popover .popup-th{
	padding: 6px 8px 6px 8px;
	border-top: 1px solid var(--popover-border-color) !important;
	border-right: 1px solid var(--popover-border-color) !important;
}

.popover .popup-td{
	padding: 6px 8px 6px 8px;
	border-top: 1px solid var(--popover-border-color) !important;
}

.popover .arrow::after, .popover .arrow::before{
    display: none !important;    
}
</style>


<body>

	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar3.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<div class="main">

		<!-- MAIN CONTENT -->
		<div class="main-content">

			<div class="container-fluid" style="margin-top: 15px;">
				<div class="row">
					<div class="col-md-12">
						<div class="card" style="height: 830px;">
							<div class="card-body">
								<!-- METRICS -->
								<div id="map" style="height: 800px;">
								</div>
								<!-- END METRICS -->
								<div id="popupArea" style="display: none;">
									<!-- Popup vertual -->
							    </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal" tabindex="-1" id="modalPop_002">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content" style="width: 1300px;">
				<div class="modal-header">
					<h5 class="modal-title">건축물 정보</h5>
					<div class="checkDiv" style="width: 200px; margin-left: 20px;">
						<span class="type-name">조회 기간</span>
						<select id="year" name="year" onchange="javascript:fnSelectYear();">
							<option value="2021">2021</option>
							<option value="2020" selected>2020</option>
							<option value="2019">2019</option>
							<option value="2018">2018</option>
							<option value="2017">2017</option>
							<option value="2016">2016</option>
							<option value="2015">2015</option>
							<option value="2014">2014</option>
						</select>
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto;">
					<input type="hidden" id="arch_totarea">
					<table style="float: left;" class="table table-striped table-project-tasks" summary="조회 항목 모달창">
						<tr>
							<td style="text-align: center">건축물 관리번호</td>
							<td style="text-align: center" id="selected_bd_mgm_bld_pk"></td>
						</tr>
						<tr>
							<td style="text-align: center">주소</td>
							<td style="text-align: center" id="selected_bd_juso"></td>
						</tr>
						<tr>
							<td style="text-align: center" >
								건축물 기준 연면적(m<sup>2</sup>)
							</td>
							<td style="text-align: center" id="selected_bd_totarea" colspan="2">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >건물용도</td>
							<td style="text-align: center" id="selected_bd_main_purps_nm" colspan="2">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >노후도(년)</td>
							<td style="text-align: center" id="selected_bd_useapr_day" colspan="2">-</td>
						</tr>
					</table>
					<table class="table table-project-tasks" summary="조회 항목 모달창" style="width: 1250px;">
						<tr>
							<td style="text-align: center" >구분</td>
							<td style="text-align: center" >단위</td>
							<td style="text-align: center" >합계</td>
							<td style="text-align: center" >1월</td>
							<td style="text-align: center" >2월</td>
							<td style="text-align: center" >3월</td>
							<td style="text-align: center" >4월</td>
							<td style="text-align: center" >5월</td>
							<td style="text-align: center" >6월</td>
							<td style="text-align: center" >7월</td>
							<td style="text-align: center" >8월</td>
							<td style="text-align: center" >9월</td>
							<td style="text-align: center" >10월</td>
							<td style="text-align: center" >11월</td>
							<td style="text-align: center" >12월</td>
						</tr>
						<tr>
							<td style="text-align: center" >총 온실가스</td>
							<td style="text-align: center" >
								tCO<sub>2</sub>
							</td>
							<td id="tco2eq_t_all" style="text-align: right">-</td>
							<td id="tco2eq_t_1" style="text-align: right">-</td>
							<td id="tco2eq_t_2" style="text-align: right">-</td>
							<td id="tco2eq_t_3" style="text-align: right">-</td>
							<td id="tco2eq_t_4" style="text-align: right">-</td>
							<td id="tco2eq_t_5" style="text-align: right">-</td>
							<td id="tco2eq_t_6" style="text-align: right">-</td>
							<td id="tco2eq_t_7" style="text-align: right">-</td>
							<td id="tco2eq_t_8" style="text-align: right">-</td>
							<td id="tco2eq_t_9" style="text-align: right">-</td>
							<td id="tco2eq_t_10" style="text-align: right">-</td>
							<td id="tco2eq_t_11" style="text-align: right">-</td>
							<td id="tco2eq_t_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >
								<p>단위면적당</p>
								온실가스
							</td>
							<td style="text-align: center" >
								tCO<sub>2</sub>/m<sup>2</sup>
							</td>
							<td id="tco2eq_t_area_t" style="text-align: right">-</td>
							<td id="tco2eq_t_area_1" style="text-align: right">-</td>
							<td id="tco2eq_t_area_2" style="text-align: right">-</td>
							<td id="tco2eq_t_area_3" style="text-align: right">-</td>
							<td id="tco2eq_t_area_4" style="text-align: right">-</td>
							<td id="tco2eq_t_area_5" style="text-align: right">-</td>
							<td id="tco2eq_t_area_6" style="text-align: right">-</td>
							<td id="tco2eq_t_area_7" style="text-align: right">-</td>
							<td id="tco2eq_t_area_8" style="text-align: right">-</td>
							<td id="tco2eq_t_area_9" style="text-align: right">-</td>
							<td id="tco2eq_t_area_10" style="text-align: right">-</td>
							<td id="tco2eq_t_area_11" style="text-align: right">-</td>
							<td id="tco2eq_t_area_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center" >전기</td>
							<td style="text-align: center" >MWh</td>
							<td id="energy_use_e_t" style="text-align: right">-</td>
							<td id="energy_use_e_1" style="text-align: right">-</td>
							<td id="energy_use_e_2" style="text-align: right">-</td>
							<td id="energy_use_e_3" style="text-align: right">-</td>
							<td id="energy_use_e_4" style="text-align: right">-</td>
							<td id="energy_use_e_5" style="text-align: right">-</td>
							<td id="energy_use_e_6" style="text-align: right">-</td>
							<td id="energy_use_e_7" style="text-align: right">-</td>
							<td id="energy_use_e_8" style="text-align: right">-</td>
							<td id="energy_use_e_9" style="text-align: right">-</td>
							<td id="energy_use_e_10" style="text-align: right">-</td>
							<td id="energy_use_e_11" style="text-align: right">-</td>
							<td id="energy_use_e_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >
								tCO<sub>2</sub>
							</td>
							<td id="tco2eq_e_t" style="text-align: right">-</td>
							<td id="tco2eq_e_1" style="text-align: right">-</td>
							<td id="tco2eq_e_2" style="text-align: right">-</td>
							<td id="tco2eq_e_3" style="text-align: right">-</td>
							<td id="tco2eq_e_4" style="text-align: right">-</td>
							<td id="tco2eq_e_5" style="text-align: right">-</td>
							<td id="tco2eq_e_6" style="text-align: right">-</td>
							<td id="tco2eq_e_7" style="text-align: right">-</td>
							<td id="tco2eq_e_8" style="text-align: right">-</td>
							<td id="tco2eq_e_9" style="text-align: right">-</td>
							<td id="tco2eq_e_10" style="text-align: right">-</td>
							<td id="tco2eq_e_11" style="text-align: right">-</td>
							<td id="tco2eq_e_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center" >가스</td>
							<td style="text-align: center" >
								1,000m<sup>3</sup>
							</td>
							<td id="energy_use_g_t" style="text-align: right">-</td>
							<td id="energy_use_g_1" style="text-align: right">-</td>
							<td id="energy_use_g_2" style="text-align: right">-</td>
							<td id="energy_use_g_3" style="text-align: right">-</td>
							<td id="energy_use_g_4" style="text-align: right">-</td>
							<td id="energy_use_g_5" style="text-align: right">-</td>
							<td id="energy_use_g_6" style="text-align: right">-</td>
							<td id="energy_use_g_7" style="text-align: right">-</td>
							<td id="energy_use_g_8" style="text-align: right">-</td>
							<td id="energy_use_g_9" style="text-align: right">-</td>
							<td id="energy_use_g_10" style="text-align: right">-</td>
							<td id="energy_use_g_11" style="text-align: right">-</td>
							<td id="energy_use_g_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >
								tCO<sub>2</sub>
							</td>
							<td id="tco2eq_g_t" style="text-align: right">-</td>
							<td id="tco2eq_g_1" style="text-align: right">-</td>
							<td id="tco2eq_g_2" style="text-align: right">-</td>
							<td id="tco2eq_g_3" style="text-align: right">-</td>
							<td id="tco2eq_g_4" style="text-align: right">-</td>
							<td id="tco2eq_g_5" style="text-align: right">-</td>
							<td id="tco2eq_g_6" style="text-align: right">-</td>
							<td id="tco2eq_g_7" style="text-align: right">-</td>
							<td id="tco2eq_g_8" style="text-align: right">-</td>
							<td id="tco2eq_g_9" style="text-align: right">-</td>
							<td id="tco2eq_g_10" style="text-align: right">-</td>
							<td id="tco2eq_g_11" style="text-align: right">-</td>
							<td id="tco2eq_g_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center" >지역난방</td>
							<td style="text-align: center" >Gcal</td>
							<td id="energy_use_l_t" style="text-align: right">-</td>
							<td id="energy_use_l_1" style="text-align: right">-</td>
							<td id="energy_use_l_2" style="text-align: right">-</td>
							<td id="energy_use_l_3" style="text-align: right">-</td>
							<td id="energy_use_l_4" style="text-align: right">-</td>
							<td id="energy_use_l_5" style="text-align: right">-</td>
							<td id="energy_use_l_6" style="text-align: right">-</td>
							<td id="energy_use_l_7" style="text-align: right">-</td>
							<td id="energy_use_l_8" style="text-align: right">-</td>
							<td id="energy_use_l_9" style="text-align: right">-</td>
							<td id="energy_use_l_10" style="text-align: right">-</td>
							<td id="energy_use_l_11" style="text-align: right">-</td>
							<td id="energy_use_l_12" style="text-align: right">-</td>
						</tr>
						<tr>
							<td style="text-align: center" >
								tCO<sub>2</sub>
							</td>
							<td id="tco2eq_l_t" style="text-align: right">-</td>
							<td id="tco2eq_l_1" style="text-align: right">-</td>
							<td id="tco2eq_l_2" style="text-align: right">-</td>
							<td id="tco2eq_l_3" style="text-align: right">-</td>
							<td id="tco2eq_l_4" style="text-align: right">-</td>
							<td id="tco2eq_l_5" style="text-align: right">-</td>
							<td id="tco2eq_l_6" style="text-align: right">-</td>
							<td id="tco2eq_l_7" style="text-align: right">-</td>
							<td id="tco2eq_l_8" style="text-align: right">-</td>
							<td id="tco2eq_l_9" style="text-align: right">-</td>
							<td id="tco2eq_l_10" style="text-align: right">-</td>
							<td id="tco2eq_l_11" style="text-align: right">-</td>
							<td id="tco2eq_l_12" style="text-align: right">-</td>
						</tr>
					</table>
					<p style="color: orange; margin-bottom: 0px;">
							※노후도 : 건물 준공년도 부재시 1800년을 기준으로 산정함
						</p>
					<p style="color: orange; margin-bottom: 0px;">
							※동일 필지의 다중 건축물일 경우 대표 에너지 값으로 일괄 적용
					</p>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(".modal-dialog").draggable({
			handle : ".modal-header"
		})<!-- make modal draggable -->
	</script>


	<!-- END WRAPPER -->

	<script src="/resources/openlayers/ol.js"></script>
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	
	<script src="/resources/js/dashboard/map.js"></script>
	
</body>
</html>