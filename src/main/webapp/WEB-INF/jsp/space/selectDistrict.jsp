<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>

</head>

<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<script src="/resources/openlayers/ol.js"></script>

<style>
table th {
	font-size : 12.5px;
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

.type-nameDi {
	margin-right: 3px;
	padding: 5px 0;
	background: #5e6773;
	color: #fff;
	width: 70px;
	display: inline-block;
	text-align: center;
	border-radius: 3px;
	font-size: 14px;
	font-weight: bold;
	vertical-align: middle;
}

#loading { width: 100%; height: 100%; top: 0px; left: 0px; position: fixed; display: block; opacity: 0.7; background-color: #fff; z-index: 99; text-align: center; } 
#loading-image { position: absolute; top: 50%; left: 50%; z-index: 100; }

#searchFrm{
    margin-bottom: 0px;
}
</style>
<body>

	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<div class="main">
		<div id="loading"><img id="loading-image" src="/resources/images/loading.gif" alt="Loading..." /></div>
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">온실가스 지도</h1>
					<p class="page-subtitle">서울특별시 행정구역별 에너지 사용량 및 배출량 평가 도출내역 (구 단위 전체 조회시 데이터 건수가 많아 시간이 지연될 수 있습니다.)</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">온실가스 지도</li>
						<li class="breadcrumb-item active">
							<a href="/space/selectDistrict.do">행정구역</a>
						</li>
					</ol>
				</nav>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-8" id="col-after-size">
						<div class="card" id="card_size">
							<form name="searchFrm" id="searchFrm">
								<div class="project-heading">
									<div class="row">
										<div class="checkDiv" style="width: 330px;">
											<input type="hidden" readonly id="arr_main_purps_nm" />
											<input type="hidden" name="sigungu_nm" id="sigungu_nm">
											<input type="hidden" name="bjdong_nm" id="bjdong_nm" value="전체">
											<span class="type-nameDi">에너지원</span>
											<label class="type-label">
												<input type="checkbox" checked="checked" class="type-result" value="전체" id="energyCheckAll" onClick="javascript:checkAllEnergy();">
												전체
											</label>
											<label class="type-label">
												<input type="checkbox" checked="checked" class="type-result" value="전기" name="energySelect_E" id="energySelect_E">
												전기
											</label>
											<label class="type-label">
												<input type="checkbox" checked="checked" class="type-result" value="가스" name="energySelect_G" id="energySelect_G">
												가스
											</label>
											<label class="type-label">
												<input type="checkbox" checked="checked" class="type-result" value="지역난방" name="energySelect_L" id="energySelect_L">
												지역난방
											</label>
										</div>
										<div class="checkDiv" style="width: 360px;">
											<span class="type-nameDi">주소</span>
											<label class="type-label">
												<select class="si" name="si" id="si">
													<option selected>서울특별시</option>
												</select>
												<select class="sigungu_nm" id="admin_cd_sgg" name="admin_cd_sgg" onchange="javascript:fnSelectSgg();">
													<option>선택</option>
													<option value="11680">강남구</option>
													<option value="11740">강동구</option>
													<option value="11305">강북구</option>
													<option value="11500">강서구</option>
													<option value="11620">관악구</option>
													<option value="11215">광진구</option>
													<option value="11530">구로구</option>
													<option value="11545">금천구</option>
													<option value="11350">노원구</option>
													<option value="11320">도봉구</option>
													<option value="11230">동대문구</option>
													<option value="11590">동작구</option>
													<option value="11440">마포구</option>
													<option value="11410">서대문구</option>
													<option value="11650">서초구</option>
													<option value="11200">성동구</option>
													<option value="11290">성북구</option>
													<option value="11710">송파구</option>
													<option value="11470">양천구</option>
													<option value="11560">영등포구</option>
													<option value="11170">용산구</option>
													<option value="11380">은평구</option>
													<option value="11110">종로구</option>
													<option value="11140">중구</option>
													<option value="11260">중랑구</option>
												</select>
												<select class="bjdong_nm" id="admin_cd_emd" name="admin_cd_emd" onchange="javascript:fnSelectEmd();">
													<option value="all">전체</option>
												</select>
											</label>
										</div>
										<div class="checkDiv" style="width: 355px;">
											<span class="type-nameDi">조회 기간</span>
											<select class="start_year" id="start_year" name="start_year">
												<option>2014</option>
												<option>2015</option>
												<option>2016</option>
												<option>2017</option>
												<option>2018</option>
												<option>2019</option>
												<option>2020</option>
											</select>
											<select class="start_month" id="start_month" name="start_month">
												<option>01</option>
												<option>02</option>
												<option>03</option>
												<option>04</option>
												<option>05</option>
												<option>06</option>
												<option>07</option>
												<option>08</option>
												<option>09</option>
												<option>10</option>
												<option>11</option>
												<option>12</option>
											</select>
											<span>~</span>
											<select class="end_year" id="end_year" name="end_year">
												<option>2014</option>
												<option>2015</option>
												<option>2016</option>
												<option>2017</option>
												<option>2018</option>
												<option>2019</option>
												<option>2020</option>
											</select>
											<select class="end_month" id="end_month" name="end_month">
												<option>01</option>
												<option>02</option>
												<option>03</option>
												<option>04</option>
												<option>05</option>
												<option>06</option>
												<option>07</option>
												<option>08</option>
												<option>09</option>
												<option>10</option>
												<option>11</option>
												<option>12</option>
											</select>
											<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" style="padding-right: 5px; padding-left: 5px; width: 47px; height: 31px;" onclick="javascript:search();">조회</button>
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
										<div id="map" class="specArchMap" style="height: 480px"></div>
									</div>
								</div>
								<div style="height: 200px; overflow: auto">
									<table id="searchedBuildTable" class="table table-striped" summary="조회 결과" style="table-layout: fixed; height : 180px; ">
										<colgroup>
											<col width="5%"/>
											<col width="15%"/>
											<col width="25%"/>
											<col width="30%"/>
											<col width="10%"/>
											<col width="15%"/>
										</colgroup>
										<thead>
											<tr>
												<th style="text-align: center">순번</th>
												<th style="text-align: center">건축물 관리번호</th>
												<th style="text-align: center">건물명</th>
												<th style="text-align: center">주소</th>
												<th style="text-align: center">준공연도</th>
												<th style="text-align: center">필지 기준 연면적(m<sup>2</sup>)</th>
											</tr>
										</thead>
										<tbody id="searchedBuildResult">
											<tr style="text-align: center; font-size: 14px;">
												<td colspan="6">데이터를 조회해주세요.</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- UI Design end -->
						</div>
					</div>

					<div class="col-md-4" id="snb_right">
						<div id="listResult">
							<div class="card" style="margin-bottom: 15px;">
								<div class="card-header">
									<h3 class="card-title">행정구역 에너지원 사용량 및 배출량 그래프</h3>
								</div>
								<div class="card-body" style="height: 360px;">
									<%-- 									<canvas id="speedChart" style="height: 300px; width: 481px; display: block; padding-bottom: 10px;"></canvas> --%>
									<table class="table table-hover table-project-tasks" summary="조회 항목 차트">
										<tbody>
											<tr style="text-align: center">
												<td colspan="3">데이터를 조회해주세요.</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<div class="card" id="right_list_size">
								<h3 class="card-header">에너지원 사용량 및 배출량</h3>
								<div class="card-body" style="height: 360px; padding-top: 10px; padding-bottom: 10px;">
									<table class="table table-hover table-project-tasks" summary="조회 항목 차트">
										<thead>
											<tr>
												<th style="text-align: center">에너지원</th>
												<th style="text-align: center">단위</th>
												<th style="text-align: center">사용량 및 배출량</th>
											</tr>
										</thead>
										<tbody>
											<tr style="text-align: center">
												<td colspan="3">데이터를 조회해주세요.</td>
											</tr>
										</tbody>
									</table>
									<!-- 		</ul> -->
								</div>
							</div>
						</div>
					</div>

					<div class="modal" tabindex="-1" id="modalPop_002">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">건축물 정보</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<script>
									$("#modalPop_002").draggable({
										handle : ".modal-header"
									})
								<!-- make modal draggable -->
								</script>
								<div class="modal-body" style="overflow: auto;">
									<table class="table table-striped table-project-tasks" summary="조회 항목 모달창">
										<tr>
											<td>건축물 대장 관리번호</td>
											<td id="selected_bd_mgm_bld_pk" colspan="2">-</td>
										</tr>
										<tr>
											<td>주소</td>
											<td id="selected_bd_juso" colspan="2">-</td>
										</tr>
										<tr>
											<td>건축물 기준 연면적(m<sup>2</sup>)</td>
											<td id="selected_bd_totarea" colspan="2">-</td>
										</tr>
										<tr>
											<td>노후도(년)</td>
											<td id="selected_bd_useapr_day" colspan="2">-</td>
										</tr>
									</table>
									<table class="table table-project-tasks" summary="조회 항목  에너지 정보">
										<tr>
											<td rowspan="2">전기</td>
											<td>
												tCO<sub>2</sub>
											</td>
											<td id="selected_bd_tco2eq_e">-</td>
										</tr>
										<tr>
											<td>kWh</td>
											<td id="selected_bd_energy_use_e">-</td>
										</tr>
										<tr>
											<td rowspan="2">가스</td>
											<td>
												tCO<sub>2</sub>
											</td>
											<td id="selected_bd_tco2eq_g">-</td>
										</tr>
										<tr>
											<td>
												1,000m<sup>3</sup>
											</td>
											<td id="selected_bd_energy_use_g">-</td>
										</tr>
										<tr>
											<td rowspan="2">지역난방</td>
											<td>
												tCO<sub>2</sub>
											</td>
											<td id="selected_bd_tco2eq_l">-</td>
										</tr>
										<tr>
											<td>Gcal</td>
											<td id="selected_bd_energy_use_l">-</td>
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

		<!-- Vendor -->
		<script src="/resources/js/vendor.min.js"></script>

		<!-- App -->
		<script src="/resources/js/app.min.js"></script>

		<!-- SheetJS -->
		<script src="/resources/js/sheetJS/xlsx.full.min.js"></script>
		
		<!-- FileSaver -->
		<script src="/resources/js/filesaver/FileSaver.min.js"></script>

		<!-- SPACE.JS -->
		<script src="/resources/js/selectDistrict.js"></script>
		
		<!-- buildExcelDownload -->
	<script src="/resources/js/buildExcelDownload.js"></script>
</body>
</html>