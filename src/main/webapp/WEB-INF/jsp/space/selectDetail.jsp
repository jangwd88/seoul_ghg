<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>

</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<script src="/resources/openlayers/ol.js"></script>

<style>
table th {
	font-size: 12.5px;
}

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

input[type="radio"] {
	-webkit-appearance: checkbox !important; /* Chrome, Safari, Opera */
	-moz-appearance: checkbox !important; /* Firefox */
	-ms-appearance: checkbox !important; /* not currently supported */
}

.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
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

#loading {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: fixed;
	display: block;
	opacity: 0.7;
	background-color: #fff;
	z-index: 99;
	text-align: center;
}

#loading-image {
	position: absolute;
	top: 50%;
	left: 50%;
	z-index: 100;
}
</style>
<body>

	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<div class="main">

		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div id="loading">
				<img id="loading-image" src="/resources/images/loading.gif" alt="Loading..." />
			</div>
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">온실가스 지도</h1>
					<p class="page-subtitle">서울특별시 건축물별 에너지 사용량 및 배출량 상세 조회</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">온실가스 지도</li>
						<li class="breadcrumb-item active">
							<a href="/space/selectDetail.do">상세조회</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card" id="card_size">
							<form name="searchFrm" id="searchFrm" style="margin-bottom: 0px;">
								<div class="project-heading">
									<div class="row">
										<div class="checkDiv" style="width: 600px;">
											<input type="hidden" id="search_juso" name="search_juso" />
											<span class="type-name">주소</span>
											<b id="juso_str" name="juso_str">검색해주세요</b>
											<a class="btn-example">
												<button type="button" data-toggle="modal" data-target="#juso_nm_modal" id="adrbtn">검색</button>
											</a>
										</div>
										<div align="right" style="margin-left: 900px;">
											<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" style="padding-right: 5px; padding-left: 5px; width: 47px;" onclick="javascript:search();">조회</button>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>

							<!-- Map -->
							<div class="card-body" style="padding-top: 5px;">
								<!-- UI Design start -->
								<div class="card project-milestone">
									<div id="collapse4" class="collapse show">
										<div id="map" class="specArchMap" style="height: 490px;"></div>
									</div>
								</div>
								<div style="height: 200px; overflow: auto">
									<table id="searchedBuildTable" class="table table-striped" summary="조회 결과" style="table-layout: fixed; height: 50px; width: 1580px;">
										<colgroup>
											<col width="5%" />
											<col width="15%" />
											<col width="25%" />
											<col width="30%" />
											<col width="10%" />
											<col width="15%" />
										</colgroup>
										<thead>
											<tr>
												<th style="text-align: center">순번</th>
												<th style="text-align: center">건축물 관리번호</th>
												<th style="text-align: center">건물명</th>
												<th style="text-align: center">주소</th>
												<th style="text-align: center">준공연도</th>
												<th style="text-align: center">
													필지 기준 연면적(m<sup>2</sup>)
												</th>
											</tr>
										</thead>
										<tbody id="searchedBuildResult">
											<tr style="text-align: center; font-size: 13px;">
												<td colspan="6">데이터를 조회해주세요.</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- UI Design end -->

		<div class="modal fade" id="juso_nm_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">주소 검색</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<script>
						$("#juso_nm_modal").draggable({
							handle : ".modal-header"
						})
					</script>
					<div class="modal-body">
						<div class="pop-conts" align="center">
							<select name="searchType" name="searchType" style="height: 27px;">
								<option>주소</option>
							</select>
							<input type="text" placeholder="주소 검색" name="keyword_juso" id="keyword_juso" class="keyword_juso">
							<input type="button" value="검색" id="adrbtn" class="adrbtn">
							<p class="ctxt mb20" align="center">검색 결과</p>
							<div style="overflow: auto; height: 400px;">
								<table id="JusoTable" class="table table-striped table-project-tasks" style="width: 380px;" summary="주소모달">
									<tbody>
										<tr>
											<td>주소를 검색해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a href="#void" onclick="javascript:fnSelectJuso();" alt="확인" data-dismiss="modal">
							<button class="btn-layerSub">확인</button>
						</a>
						<button type="button" class="btn-layerSub" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>


		<div class="modal" tabindex="-1" id="modalPop_002">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content" style="width: 1300px;">
					<div class="modal-header">
						<h5 class="modal-title">건축물 정보</h5>
						<div class="checkDiv" style="width: 160px; margin-left: 20px;">
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

						<!-- 개인화서비스 추가 -->
						<input type="hidden" id="admin_id" name="admin_id" value="${loginInfo.ADMIN_ID}">
						<input type="hidden" id="userLikeBuildStatus" name="userLikeBuildStatus">
						<div id="div_like_a" style="display: none; padding-top: 6px;">
							<a href="#">
								<i class="far fa-heart" id="btnLike" onclick="javascript:fnSetUserLikeBuild();"> 관심 건축물 </i>
							</a>
						</div>

						<div id="div_like_b" style="display: none; padding-top: 6px;">
							<a href="#">
								<i class="fas fa-heart" id="btnDislike" onclick="javascript:fnSetUserLikeBuild();"> 이미 등록된 관심 건축물입니다. </i>
							</a>
						</div>
						<!-- 개인화서비스 추가 -->

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<script>
						$("#modalPop_002").draggable({
							handle : ".modal-header"
						})<!-- make modal draggable -->
					</script>
					<div class="modal-body" style="overflow: auto;">
						<input type="hidden" id="arch_totarea">
						<table style="float: left;" class="table table-striped table-project-tasks" summary="조회 항목 모달창">
							<tr>
								<td>건축물 관리번호</td>
								<td id="selected_bd_mgm_bld_pk"></td>
							</tr>
							<tr>
								<td>주소</td>
								<td id="selected_bd_juso"></td>
							</tr>
							<tr>
								<td>
									건축물 기준 연면적(m<sup>2</sup>)
								</td>
								<td id="selected_bd_totarea" colspan="2">-</td>
							</tr>
							<tr>
								<td>건물용도</td>
								<td id="selected_bd_main_purps_nm" colspan="2">-</td>
							</tr>
							<tr>
								<td>노후도(년)</td>
								<td id="selected_bd_useapr_day" colspan="2">-</td>
							</tr>
						</table>
						<table class="table table-project-tasks" summary="조회 항목 모달창" style="width: 1250px;">
							<tr>
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
								<td>총 온실가스</td>
								<td>
									tCO<sub>2</sub>
								</td>
								<td id="tco2eq_t">-</td>
								<td id="tco2eq_t_1">-</td>
								<td id="tco2eq_t_2">-</td>
								<td id="tco2eq_t_3">-</td>
								<td id="tco2eq_t_4">-</td>
								<td id="tco2eq_t_5">-</td>
								<td id="tco2eq_t_6">-</td>
								<td id="tco2eq_t_7">-</td>
								<td id="tco2eq_t_8">-</td>
								<td id="tco2eq_t_9">-</td>
								<td id="tco2eq_t_10">-</td>
								<td id="tco2eq_t_11">-</td>
								<td id="tco2eq_t_12">-</td>
							</tr>
							<tr>
								<td>
									<p>단위면적당</p>
									온실가스
								</td>
								<td>
									tCO<sub>2</sub>/m<sup>2</sup>
								</td>
								<td id="tco2eq_t_area_t">-</td>
								<td id="tco2eq_t_area_1">-</td>
								<td id="tco2eq_t_area_2">-</td>
								<td id="tco2eq_t_area_3">-</td>
								<td id="tco2eq_t_area_4">-</td>
								<td id="tco2eq_t_area_5">-</td>
								<td id="tco2eq_t_area_6">-</td>
								<td id="tco2eq_t_area_7">-</td>
								<td id="tco2eq_t_area_8">-</td>
								<td id="tco2eq_t_area_9">-</td>
								<td id="tco2eq_t_area_10">-</td>
								<td id="tco2eq_t_area_11">-</td>
								<td id="tco2eq_t_area_12">-</td>
							</tr>
							<tr>
								<td rowspan="2">전기</td>
								<td>MWh</td>
								<td id="energy_use_e_t">-</td>
								<td id="energy_use_e_1">-</td>
								<td id="energy_use_e_2">-</td>
								<td id="energy_use_e_3">-</td>
								<td id="energy_use_e_4">-</td>
								<td id="energy_use_e_5">-</td>
								<td id="energy_use_e_6">-</td>
								<td id="energy_use_e_7">-</td>
								<td id="energy_use_e_8">-</td>
								<td id="energy_use_e_9">-</td>
								<td id="energy_use_e_10">-</td>
								<td id="energy_use_e_11">-</td>
								<td id="energy_use_e_12">-</td>
							</tr>
							<tr>
								<td>
									tCO<sub>2</sub>
								</td>
								<td id="tco2eq_e_t">-</td>
								<td id="tco2eq_e_1">-</td>
								<td id="tco2eq_e_2">-</td>
								<td id="tco2eq_e_3">-</td>
								<td id="tco2eq_e_4">-</td>
								<td id="tco2eq_e_5">-</td>
								<td id="tco2eq_e_6">-</td>
								<td id="tco2eq_e_7">-</td>
								<td id="tco2eq_e_8">-</td>
								<td id="tco2eq_e_9">-</td>
								<td id="tco2eq_e_10">-</td>
								<td id="tco2eq_e_11">-</td>
								<td id="tco2eq_e_12">-</td>
							</tr>
							<tr>
								<td rowspan="2">가스</td>
								<td>
									1,000m<sup>3</sup>
								</td>
								<td id="energy_use_g_t">-</td>
								<td id="energy_use_g_1">-</td>
								<td id="energy_use_g_2">-</td>
								<td id="energy_use_g_3">-</td>
								<td id="energy_use_g_4">-</td>
								<td id="energy_use_g_5">-</td>
								<td id="energy_use_g_6">-</td>
								<td id="energy_use_g_7">-</td>
								<td id="energy_use_g_8">-</td>
								<td id="energy_use_g_9">-</td>
								<td id="energy_use_g_10">-</td>
								<td id="energy_use_g_11">-</td>
								<td id="energy_use_g_12">-</td>
							</tr>
							<tr>
								<td>
									tCO<sub>2</sub>
								</td>
								<td id="tco2eq_g_t">-</td>
								<td id="tco2eq_g_1">-</td>
								<td id="tco2eq_g_2">-</td>
								<td id="tco2eq_g_3">-</td>
								<td id="tco2eq_g_4">-</td>
								<td id="tco2eq_g_5">-</td>
								<td id="tco2eq_g_6">-</td>
								<td id="tco2eq_g_7">-</td>
								<td id="tco2eq_g_8">-</td>
								<td id="tco2eq_g_9">-</td>
								<td id="tco2eq_g_10">-</td>
								<td id="tco2eq_g_11">-</td>
								<td id="tco2eq_g_12">-</td>
							</tr>
							<tr>
								<td rowspan="2">지역난방</td>
								<td>Gcal</td>
								<td id="energy_use_l_t">-</td>
								<td id="energy_use_l_1">-</td>
								<td id="energy_use_l_2">-</td>
								<td id="energy_use_l_3">-</td>
								<td id="energy_use_l_4">-</td>
								<td id="energy_use_l_5">-</td>
								<td id="energy_use_l_6">-</td>
								<td id="energy_use_l_7">-</td>
								<td id="energy_use_l_8">-</td>
								<td id="energy_use_l_9">-</td>
								<td id="energy_use_l_10">-</td>
								<td id="energy_use_l_11">-</td>
								<td id="energy_use_l_12">-</td>
							</tr>
							<tr>
								<td>
									tCO<sub>2</sub>
								</td>
								<td id="tco2eq_l_t">-</td>
								<td id="tco2eq_l_1">-</td>
								<td id="tco2eq_l_2">-</td>
								<td id="tco2eq_l_3">-</td>
								<td id="tco2eq_l_4">-</td>
								<td id="tco2eq_l_5">-</td>
								<td id="tco2eq_l_6">-</td>
								<td id="tco2eq_l_7">-</td>
								<td id="tco2eq_l_8">-</td>
								<td id="tco2eq_l_9">-</td>
								<td id="tco2eq_l_10">-</td>
								<td id="tco2eq_l_11">-</td>
								<td id="tco2eq_l_12">-</td>
							</tr>
						</table>
						<p style="color: orange; margin-bottom: 0px;">※노후도 : 건물 준공년도 부재시 1800년을 기준으로 산정함</p>
						<p style="color: orange; margin-bottom: 0px;">※동일 필지의 다중 건축물일 경우 대표 에너지 값으로 일괄 적용</p>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- END MAIN -->

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<!-- SPACE.JS -->
	<script src="/resources/js/selectDetail.js"></script>
	<script src="/resources/js/individual.js"></script>
</body>
</html>