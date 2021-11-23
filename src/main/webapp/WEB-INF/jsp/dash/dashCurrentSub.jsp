<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/common/common.js"></script>
</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<script src="/resources/openlayers/ol.js"></script>

<style>
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

tr {
	height: 30px;
}

td {
	border: 1px solid #d1d6e6;
	vertical-align: middle !important;
}

.nm-td {
	min-width: 140px;
}

.text-center {
	text-align: center;
}

.text-right {
	text-align: right;
}

.hilight {
	background-color: #6c7ae0;
	color: white;
}

.change-tr {
	background-color: #f8f6ff;
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

			<div class="container-fluid" style="margin-top: 5px;">
				<div class="row">
					<div class="col-md-12">
						<div class="card" style="height: 550px;">
							<div class="card-body">
								<!-- METRICS -->
								<div id="map" style="height: 500px;"></div>
								<!-- END METRICS -->
							</div>
						</div>
					</div>

					<div class="container-fluid">
						<div class="row">
							<div class="col-md-4 col-lg-3">
								<div class="card project-item">
									<div class="card-header d-flex justify-content-between align-items-center">
										<span class="milestone-title">
											<i class="fas fa-bookmark"></i>
											<span>건물개요</span>
										</span>
									</div>
									<div class="card-body" style="padding: 5px; height: 280px;">
										<input type="hidden" id="arch_totarea">
										<table class="table table-project-tasks" style="border: 1px solid #d1d6e6; height: 265px;">
											<tr style="text-align: center">
												<td class="hilight">건축물 관리번호</td>
												<td id="selected_bd_mgm_bld_pk">-</td>
											</tr>
											<tr style="text-align: center">
												<td class="hilight">주소</td>
												<td class="change-tr" id="selected_bd_juso">-</td>
											</tr>
											<tr style="text-align: center">
												<td class="hilight">
													연면적(m<sup>2</sup>)
												</td>
												<td id="selected_bd_totarea">-</td>
											</tr>
											<tr style="text-align: center">
												<td class="hilight">건물용도</td>
												<td class="change-tr" id="selected_bd_main_purps_nm">-</td>
											</tr>
											<tr style="text-align: center">
												<td class="hilight">노후도(년)</td>
												<td id="selected_bd_useapr_day">-</td>
											</tr>
										</table>
									</div>
								</div>
							</div>

							<div class="col-md-4 col-lg-9">
								<div class="card project-item">
									<div class="card-header d-flex justify-content-between align-items-center">
										<span class="milestone-title">
											<i class="far fa-calendar-alt"></i>
											<span>건물별 조회 현황</span>
										</span>
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
									<div class="card-body" style="padding: 5px; height: 280px;">
										<table id="reducedH" class="table table-project-tasks" summary="조회 항목 모달창">
											<tr class="text-center hilight">
												<td>구분</td>
												<td>단위</td>
												<td>합계</td>
												<td>1월</td>
												<td>2월</td>
												<td>3월</td>
												<td>4월</td>
												<td>5월</td>
												<td>6월</td>
												<td>7월</td>
												<td>8월</td>
												<td>9월</td>
												<td>10월</td>
												<td>11월</td>
												<td>12월</td>
											</tr>
											<tr>
												<td class="nm-td text-center hilight">총 온실가스</td>
												<td class="text-center">
													tCO<sub>2</sub>
												</td>
												<td class="text-right" id="tco2eq_t_all">-</td>
												<td class="text-right" id="tco2eq_t_1">-</td>
												<td class="text-right" id="tco2eq_t_2">-</td>
												<td class="text-right" id="tco2eq_t_3">-</td>
												<td class="text-right" id="tco2eq_t_4">-</td>
												<td class="text-right" id="tco2eq_t_5">-</td>
												<td class="text-right" id="tco2eq_t_6">-</td>
												<td class="text-right" id="tco2eq_t_7">-</td>
												<td class="text-right" id="tco2eq_t_8">-</td>
												<td class="text-right" id="tco2eq_t_9">-</td>
												<td class="text-right" id="tco2eq_t_10">-</td>
												<td class="text-right" id="tco2eq_t_11">-</td>
												<td class="text-right" id="tco2eq_t_12">-</td>
											</tr>
											<tr class="change-tr">
												<td class="nm-td text-center hilight">단위면적당 온실가스</td>
												<td class="text-center">
													tCO<sub>2</sub>/m<sup>2</sup>
												</td>
												<td class="text-right" id="tco2eq_t_area_t">-</td>
												<td class="text-right" id="tco2eq_t_area_1">-</td>
												<td class="text-right" id="tco2eq_t_area_2">-</td>
												<td class="text-right" id="tco2eq_t_area_3">-</td>
												<td class="text-right" id="tco2eq_t_area_4">-</td>
												<td class="text-right" id="tco2eq_t_area_5">-</td>
												<td class="text-right" id="tco2eq_t_area_6">-</td>
												<td class="text-right" id="tco2eq_t_area_7">-</td>
												<td class="text-right" id="tco2eq_t_area_8">-</td>
												<td class="text-right" id="tco2eq_t_area_9">-</td>
												<td class="text-right" id="tco2eq_t_area_10">-</td>
												<td class="text-right" id="tco2eq_t_area_11">-</td>
												<td class="text-right" id="tco2eq_t_area_12">-</td>
											</tr>
											<tr>
												<td rowspan="2" class="nm-td text-center hilight">전기</td>
												<td class="text-center">MWh</td>
												<td class="text-right" id="energy_use_e_t">-</td>
												<td class="text-right" id="energy_use_e_1">-</td>
												<td class="text-right" id="energy_use_e_2">-</td>
												<td class="text-right" id="energy_use_e_3">-</td>
												<td class="text-right" id="energy_use_e_4">-</td>
												<td class="text-right" id="energy_use_e_5">-</td>
												<td class="text-right" id="energy_use_e_6">-</td>
												<td class="text-right" id="energy_use_e_7">-</td>
												<td class="text-right" id="energy_use_e_8">-</td>
												<td class="text-right" id="energy_use_e_9">-</td>
												<td class="text-right" id="energy_use_e_10">-</td>
												<td class="text-right" id="energy_use_e_11">-</td>
												<td class="text-right" id="energy_use_e_12">-</td>
											</tr>
											<tr class="change-tr">
												<td class="text-center">
													tCO<sub>2</sub>
												</td>
												<td class="text-right" id="tco2eq_e_t">-</td>
												<td class="text-right" id="tco2eq_e_1">-</td>
												<td class="text-right" id="tco2eq_e_2">-</td>
												<td class="text-right" id="tco2eq_e_3">-</td>
												<td class="text-right" id="tco2eq_e_4">-</td>
												<td class="text-right" id="tco2eq_e_5">-</td>
												<td class="text-right" id="tco2eq_e_6">-</td>
												<td class="text-right" id="tco2eq_e_7">-</td>
												<td class="text-right" id="tco2eq_e_8">-</td>
												<td class="text-right" id="tco2eq_e_9">-</td>
												<td class="text-right" id="tco2eq_e_10">-</td>
												<td class="text-right" id="tco2eq_e_11">-</td>
												<td class="text-right" id="tco2eq_e_12">-</td>
											</tr>
											<tr>
												<td rowspan="2" class="nm-td text-center hilight">가스</td>
												<td class="text-center">
													1,000m<sup>3</sup>
												</td>
												<td class="text-right" id="energy_use_g_t">-</td>
												<td class="text-right" id="energy_use_g_1">-</td>
												<td class="text-right" id="energy_use_g_2">-</td>
												<td class="text-right" id="energy_use_g_3">-</td>
												<td class="text-right" id="energy_use_g_4">-</td>
												<td class="text-right" id="energy_use_g_5">-</td>
												<td class="text-right" id="energy_use_g_6">-</td>
												<td class="text-right" id="energy_use_g_7">-</td>
												<td class="text-right" id="energy_use_g_8">-</td>
												<td class="text-right" id="energy_use_g_9">-</td>
												<td class="text-right" id="energy_use_g_10">-</td>
												<td class="text-right" id="energy_use_g_11">-</td>
												<td class="text-right" id="energy_use_g_12">-</td>
											</tr>
											<tr class="change-tr">
												<td class="text-center">
													tCO<sub>2</sub>
												</td>
												<td class="text-right" id="tco2eq_g_t">-</td>
												<td class="text-right" id="tco2eq_g_1">-</td>
												<td class="text-right" id="tco2eq_g_2">-</td>
												<td class="text-right" id="tco2eq_g_3">-</td>
												<td class="text-right" id="tco2eq_g_4">-</td>
												<td class="text-right" id="tco2eq_g_5">-</td>
												<td class="text-right" id="tco2eq_g_6">-</td>
												<td class="text-right" id="tco2eq_g_7">-</td>
												<td class="text-right" id="tco2eq_g_8">-</td>
												<td class="text-right" id="tco2eq_g_9">-</td>
												<td class="text-right" id="tco2eq_g_10">-</td>
												<td class="text-right" id="tco2eq_g_11">-</td>
												<td class="text-right" id="tco2eq_g_12">-</td>
											</tr>
											<tr>
												<td rowspan="2" class="nm-td text-center hilight">지역난방</td>
												<td class="text-center">Gcal</td>
												<td class="text-right" id="energy_use_l_t">-</td>
												<td class="text-right" id="energy_use_l_1">-</td>
												<td class="text-right" id="energy_use_l_2">-</td>
												<td class="text-right" id="energy_use_l_3">-</td>
												<td class="text-right" id="energy_use_l_4">-</td>
												<td class="text-right" id="energy_use_l_5">-</td>
												<td class="text-right" id="energy_use_l_6">-</td>
												<td class="text-right" id="energy_use_l_7">-</td>
												<td class="text-right" id="energy_use_l_8">-</td>
												<td class="text-right" id="energy_use_l_9">-</td>
												<td class="text-right" id="energy_use_l_10">-</td>
												<td class="text-right" id="energy_use_l_11">-</td>
												<td class="text-right" id="energy_use_l_12">-</td>
											</tr>
											<tr class="change-tr">
												<td class="text-center">
													tCO<sub>2</sub>
												</td>
												<td class="text-right" id="tco2eq_l_t">-</td>
												<td class="text-right" id="tco2eq_l_1">-</td>
												<td class="text-right" id="tco2eq_l_2">-</td>
												<td class="text-right" id="tco2eq_l_3">-</td>
												<td class="text-right" id="tco2eq_l_4">-</td>
												<td class="text-right" id="tco2eq_l_5">-</td>
												<td class="text-right" id="tco2eq_l_6">-</td>
												<td class="text-right" id="tco2eq_l_7">-</td>
												<td class="text-right" id="tco2eq_l_8">-</td>
												<td class="text-right" id="tco2eq_l_9">-</td>
												<td class="text-right" id="tco2eq_l_10">-</td>
												<td class="text-right" id="tco2eq_l_11">-</td>
												<td class="text-right" id="tco2eq_l_12">-</td>
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


	<!-- END WRAPPER -->
	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<!-- DASH.JS -->
	<script src="/resources/js/useEmissionSub.js"></script>
</body>
</html>