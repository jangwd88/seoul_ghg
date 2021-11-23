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

#searchFrm {
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

		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div id="loading">
				<img id="loading-image" src="/resources/images/loading.gif" alt="Loading..." />
			</div>
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">건물 온실가스 총량제</h1>
					<p class="page-subtitle">건물 온실가스 총량제 대상 건축물 에너지 사용량 및 배출량 평가 도출내역</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">건물 온실가스 총량제</li>
						<li class="breadcrumb-item active">
							<a href="/spec/specArch.do">총량제 대상 건축물</a>
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
										<input type="hidden" name="conditionFlag" id="conditionFlag" value="all">
										<div class="checkDiv" style="width: 360px;">
											<span class="type-name">에너지원</span>
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
										<div class="checkDiv" style="width: 300px;">
											<span class="type-name">총량제 대상</span>
											<select id="energy_target" name="energy_target" onchange="javascript:fnSelectEnergyTarget();">
												<option value="target_first" selected="selected">1단계</option>
												<option value="target_second">2단계</option>
											</select>
										</div>
										<div class="checkDiv" style="width: 360px;">
											<span class="type-name">건물명</span>
											<b id="cons_nm_str">전체</b>
											<a class="btn-example">
												<button type="button" data-toggle="modal" data-target="#cons_nm_modal" id="adrbtn_1" onclick="javascript:fnOpenSearchConsNm();">검색</button>
											</a>
										</div>
									</div>

									<hr class="hrSelect">

									<div class="row">
										<div class="checkDiv" style="width: 360px;">
											<span class="type-name">건물 용도</span>
											<b id="main_purps_nm_str">전체</b>
											<a class="btn-example">
												<button type="button" data-toggle="modal" data-target="#arch_type_modal" id="adrbtn_3">검색</button>
											</a>
										</div>
										<div class="checkDiv" style="width: 500px;">
											<span class="type-name">관리 부서</span>
											<b id="officer_nm_str">전체</b>
											<a class="btn-example">
												<button type="button" data-toggle="modal" data-target="#officer_nm_modal" id="adrbtn_2">검색</button>
											</a>
										</div>
										<button style="margin-left: 140px; right; padding-right: 5px; padding-left: 5px; width: 47px;" type="button" class="btn pull-right btn-primary" style="margin-left: 10px;" aria-expanded="false" id="snb_right_result" onclick="javascript:search();">조회</button>
									</div>
									<hr class="hrSelect">
								</div>
							</form>

							<!-- Map -->
							<div class="card-body" style="padding-top: 5px;">
								<!-- UI Design start -->
								<div class="card project-milestone">
									<div id="collapse4" class="collapse show">
										<div id="map" class="specArchMap" style="height: 450px;"></div>
									</div>
								</div>
								<div style="height: 200px; overflow: auto">
									<table id="searchedBuildTable" class="table table-striped" summary="조회 결과" style="table-layout: fixed; height: 180px;">
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
									<h3 class="card-title">건축물 온실가스 총량제 에너지원 사용량 및 배출량 그래프</h3>
								</div>
								<div class="card-body" style="height: 360px;">
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
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- END MAIN -->



		<!-- 건물 용도 모달 -->
		<div class="modal fade" id="arch_type_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-body">
						<div class="pop-conts" align="center">
							<div style="overflow: auto; height: 400px;">
								<table id="searchedTable" class="table table-striped table-project-tasks" style="width: 380px;" summary="건물명모달">
									<thead>
										<tr onclick="javascript:allArchLine();">
											<td>
												<input type="checkbox" value="all" id="arch_all">
											</td>
											<td>전체</td>
										</tr>
									</thead>
									<tbody id="searchResult">
										<tr>
											<td>
												<input type="checkbox" value="01" value_nm="단독주택" name="main_purps_nm">
											</td>
											<td>단독주택</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="02" value_nm="공동주택" name="main_purps_nm">
											</td>
											<td>공동주택</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="03" value_nm="제1종 근린생활 시설" name="main_purps_nm">
											</td>
											<td>제1종 근린생활 시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="04" value_nm="제2종 근린생활 시설" name="main_purps_nm">
											</td>
											<td>제2종 근린생활 시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="05" value_nm="문화 및 집회시설" name="main_purps_nm">
											</td>
											<td>문화 및 집회시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="06" value_nm="종교시설" name="main_purps_nm">
											</td>
											<td>종교시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="07" value_nm="판매시설" name="main_purps_nm">
											</td>
											<td>판매시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="08" value_nm="운수시설" name="main_purps_nm">
											</td>
											<td>운수시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="09" value_nm="의료시설" name="main_purps_nm">
											</td>
											<td>의료시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="10" value_nm="교육시설" name="main_purps_nm">
											</td>
											<td>교육시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="11" value_nm="노유자시설" name="main_purps_nm">
											</td>
											<td>노유자시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="12" value_nm="수련시설" name="main_purps_nm">
											</td>
											<td>수련시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="13" value_nm="운동시설" name="main_purps_nm">
											</td>
											<td>운동시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="14" value_nm="업무시설" name="main_purps_nm">
											</td>
											<td>업무시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="15" value_nm="숙박시설" name="main_purps_nm">
											</td>
											<td>숙박시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="16" value_nm="위락시설" name="main_purps_nm">
											</td>
											<td>위락시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="17" value_nm="공장" name="main_purps_nm">
											</td>
											<td>공장</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="18" value_nm="창고시설" name="main_purps_nm">
											</td>
											<td>창고시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="19" value_nm="위험물 저장 및 처리시설" name="main_purps_nm">
											</td>
											<td>위험물저장 및 처리시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="20" value_nm="자동차 관련시설" name="main_purps_nm">
											</td>
											<td>자동차 관련시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="21" value_nm="동물 및 식물 관련시설" name="main_purps_nm">
											</td>
											<td>동물 및 식물 관련시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="22" value_nm="자원순환 관련 시설" name="main_purps_nm">
											</td>
											<td>자원순환 관련 시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="23" value_nm="교정 및 군사시설" name="main_purps_nm">
											</td>
											<td>교정 및 군사시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="24" value_nm="방송통신시설" name="main_purps_nm">
											</td>
											<td>방송통신시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="25" value_nm="발전시설" name="main_purps_nm">
											</td>
											<td>발전시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="26" value_nm="묘지 관련 시설" name="main_purps_nm">
											</td>
											<td>묘지 관련 시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="27" value_nm="관광 휴게시설" name="main_purps_nm">
											</td>
											<td>관광 휴게시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="28" value_nm="장례 시설" name="main_purps_nm">
											</td>
											<td>장례 시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="29" value_nm="야영장시설" name="main_purps_nm">
											</td>
											<td>야영장시설</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" value="99" value_nm="기타(미분류)" name="main_purps_nm">
											</td>
											<td>기타(미분류)</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a href="#void" onclick="javascript:fnSelectMainPurps();" alt="확인" data-dismiss="modal">
							<button class="btn-layerSub">확인</button>
						</a>
						<button type="button" class="btn-layerSub" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 건물명 모달 -->
		<div class="modal fade" id="cons_nm_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">건물명 검색</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="pop-conts" align="center">
							<select name="searchType" name="searchType" style="height: 27px;">
								<option>건물명</option>
							</select>
							<input type="text" placeholder="건물명 검색" name="keyword_cons" class="keyword_cons" id="keyword_cons">
							<input type="button" value="검색" id="adrbtn" name="adrbtn" class="adrbtn">
							<p class="ctxt mb20" align="center">검색 결과</p>
							<div style="overflow: auto; height: 400px;">
								<table id="ConsTable" class="table table-striped table-project-tasks" style="width: 440px;" summary="건물명 모달">
									<thead>
										<tr onclick="javascript:checkConsLine();">
											<td>
												<input type="checkbox" value="all" id="cons_all">
											</td>
											<td colspan="2">전체</td>
										</tr>
									</thead>
									<tbody id="searchResult" style="word-break: keep-all;">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a href="#void" onclick="javascript:fnSelectCons();" alt="확인" data-dismiss="modal">
							<button class="btn-layerSub">확인</button>
						</a>
						<button type="button" class="btn-layerSub" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>



		<!-- 관리 부서 모달 -->
		<div class="modal fade" id="officer_nm_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">관리 부서 검색</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="pop-conts" align="center">
							<select name="searchType" name="searchType" style="height: 27px;">
								<option>관리 부서</option>
							</select>
							<input type="text" placeholder="부서명 검색" name="keyword" id="keyword" class="keyword">
							<input type="button" value="검색" id="adrBtn1" name="adrBtn1" class="adrBtn1">
							<p class="ctxt mb20" align="center">검색 결과</p>
							<div style="overflow: auto; height: 400px;">
								<table id="searchedTable" class="table table-striped table-project-tasks" style="width: 380px;" summary="관리 부서 모달">
									<thead>
										<tr onclick="javascript:checkLine();">
											<td>
												<input type="checkbox" value="all" id="officer_all">
											</td>
											<td>전체</td>
										</tr>
									</thead>
									<tbody id="searchResult">
										<c:forEach items="${listOfficer}" var="item">
											<tr>
												<td>
													<input type="checkbox" value="${item.officer_nm}" name="officer_nm">
												</td>
												<td>${item.officer_nm}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a href="#void" onclick="javascript:fnSelectOfficer();" alt="확인" data-dismiss="modal">
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
						<div id="div_like_a" style="display:none;  padding-top: 6px;">
							<a href="#">
								<i class="far fa-heart"  id="btnLike" onclick="javascript:fnSetUserLikeBuild();">
									관심 건축물
								</i>
							</a>
						</div>
						
						<div id="div_like_b" style="display:none;  padding-top: 6px;">
							<a href="#">
								<i class="fas fa-heart"  id="btnDislike" onclick="javascript:fnSetUserLikeBuild();">
									이미 등록된 관심 건축물입니다.
								</i>
							</a>
						</div>
						<!-- 개인화서비스 추가 -->
						
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="overflow: auto;">
						<input type="hidden" id="arch_totarea">
						<table style="float: left; width: 1250px;" class="table table-striped table-project-tasks" summary="조회 항목 모달창">
							<tr>
								<td style="width:25%">건축물 관리번호</td>
								<td style="width:25%" id="selected_bd_mgm_bld_pk"></td>
								<td style="width:25%" >기준년도원단위</td>
								<td style="width:25%" id="selected_bd_total_amt_target">-</td>
							</tr>
							<tr>
								<td>주소</td>
								<td id="selected_bd_juso"></td>
								<td>허용원단위/원단위(tCO2/㎡)</td>
								<td id="selected_bd_allow_unit">-</td>
							</tr>
							<tr>
								<td>
									건축물 기준 연면적(m<sup>2</sup>)
								</td>
								<td id="selected_bd_totarea">-</td>
								<td>총배출량</td>
								<td id="selected_bd_total_co2eq">-</td>
							</tr>
							<tr>
								<td>건물용도</td>
								<td id="selected_bd_main_purps_nm">-</td>
								<td>총 배출허용량(tCO2/연)</td>
								<td id="selected_bd_allow_total_co2eq">-</td>
							</tr>
							<tr>
							
							
								<td>노후도(년)</td>
								<td id="selected_bd_useapr_day">-</td>
								<td>감축률</td>
								<td id="selected_bd_reduction_rate">-</td>
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
								<td id="tco2eq_t_all">-</td>
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

	<script>
		$(".modal-dialog").draggable({
			handle : ".modal-header"
		})<!-- make modal draggable -->
	</script>

	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<!-- SheetJS -->
	<script src="/resources/js/sheetJS/xlsx.full.min.js"></script>

	<!-- FileSaver -->
	<script src="/resources/js/filesaver/FileSaver.min.js"></script>

	<!-- Spec.JS -->
	<script src="/resources/js/specArch.js"></script>
	<script src="/resources/js/individual.js"></script>

	<!-- buildExcelDownload -->
	<script src="/resources/js/buildExcelDownload.js"></script>
</body>
</html>