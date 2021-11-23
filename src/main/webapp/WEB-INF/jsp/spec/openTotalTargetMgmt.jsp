<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
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
			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">총량제 목표 관리</h1>
					<p class="page-subtitle">총량제 목표 관리</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"> </i>
							Home
						</li>
						<li class="breadcrumb-item">
							건물 온실가스 총량제
						</li>
						<li class="breadcrumb-item active">
							<a href="/spec/openTotalTargetMgmt.do">총량제 목표 관리</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div align="right" style="margin-left: 900px;">
					<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" style="padding-right: 5px; margin-bottom : 10px; padding-left: 5px; width: 50px;"onclick="javascript:fn_save();">save</button>
				</div>
				
				<table class="table table-project-tasks">
					<tr class="text-center hilight">
						<th>구분</th>
						<th>건물용도</th>						
						<th>기준년도 원단위</th>
						<th>2025년(20%)</th>
						<th>2030년(40%)</th>
						<th>2040년(91%)</th>					
						<th>2050년(98%)</th>
					</tr>
					<tr class="">
						<td rowspan="3">가</td>
						<td>제1종 근린생활시설</td>
						<td><input type ="number" id="input_03"/></td>
						<td id="03_2025"></td>
						<td id="03_2030"></td>
						<td id="03_2040"></td>
						<td id="03_2050"></td>
					</tr>
					<tr class="">
						<td>제2종 근린생활시설</td>
						<td><input type ="number" id="input_04"/></td>
						<td id="04_2025"></td>
						<td id="04_2030"></td>
						<td id="04_2040"></td>
						<td id="04_2050"></td>
					</tr>
					<tr class="">
						<td>판매시설</td>
						<td><input type ="number" id="input_07"/></td>
						<td id="07_2025"></td>
						<td id="07_2030"></td>
						<td id="07_2040"></td>
						<td id="07_2050"></td>
					</tr>
					<tr class="">
						<td>나</td>
						<td>업무시설</td>
						<td><input type ="number" id="input_14"/></td>
						<td id="14_2025"></td>
						<td id="14_2030"></td>
						<td id="14_2040"></td>
						<td id="14_2050"></td>
					</tr>
					<tr class="">
						<td>다</td>
						<td>교육연구시설</td>
						<td><input type ="number" id="input_10"/></td>
						<td id="10_2025"></td>
						<td id="10_2030"></td>
						<td id="10_2040"></td>
						<td id="10_2050"></td>
					</tr>
					<tr class="">
						<td>다</td>
						<td>노유자시설</td>
						<td><input type ="number" id="input_11"/></td>
						<td id="11_2025"></td>
						<td id="11_2030"></td>
						<td id="11_2040"></td>
						<td id="11_2050"></td>
					</tr>
					<tr class="">
						<td>라</td>
						<td>문화집회시설</td>
						<td><input type ="number" id="input_05"/></td>
						<td id="05_2025"></td>
						<td id="05_2030"></td>
						<td id="05_2040"></td>
						<td id="05_2050"></td>
					</tr>
					<tr class="">
						<td rowspan="2">마</td>
						<td>자동차 관련시설</td>
						<td><input type ="number" id="input_20"/></td>
						<td id="20_2025"></td>
						<td id="20_2030"></td>
						<td id="20_2040"></td>
						<td id="20_2050"></td>
					</tr>
					<tr class="">
						<td>창고시설</td>
						<td><input type ="number" id="input_18"/></td>
						<td id="18_2025"></td>
						<td id="18_2030"></td>
						<td id="18_2040"></td>
						<td id="18_2050"></td>
					</tr>
					<tr class="">
						<td>바</td>
						<td>숙박시설</td>
						<td><input type ="number" id="input_15"/></td>
						<td id="15_2025"></td>
						<td id="15_2030"></td>
						<td id="15_2040"></td>
						<td id="15_2050"></td>
					</tr>
					<tr class="">
						<td>사</td>
						<td>공장</td>
						<td><input type ="number" id="input_17"/></td>
						<td id="17_2025"></td>
						<td id="17_2030"></td>
						<td id="17_2040"></td>
						<td id="17_2050"></td>
					</tr>
					<tr class="">
						<td>아</td>
						<td>위험물저장 및 처리시설</td>
						<td><input type ="number" id="input_19"/></td>
						<td id="19_2025"></td>
						<td id="19_2030"></td>
						<td id="19_2040"></td>
						<td id="19_2050"></td>
					</tr>
					<tr class="">
						<td>자</td>
						<td>의료시설</td>
						<td><input type ="number" id="input_09"/></td>
						<td id="09_2025"></td>
						<td id="09_2030"></td>
						<td id="09_2040"></td>
						<td id="09_2050"></td>
					</tr>
					<tr class="">
						<td rowspan="2">차</td>
						<td>관광 휴게시설</td>
						<td><input type ="number" id="input_27"/></td>
						<td id="27_2025"></td>
						<td id="27_2030"></td>
						<td id="27_2040"></td>
						<td id="27_2050"></td>
					</tr>
					<tr class="">
						<td>위락시설</td>
						<td><input type ="number" id="input_16"/></td>
						<td id="16_2025"></td>
						<td id="16_2030"></td>
						<td id="16_2040"></td>
						<td id="16_2050"></td>
					</tr>
					<tr class="">
						<td>카</td>
						<td>종교시설</td>
						<td><input type ="number" id="input_06"/></td>
						<td id="06_2025"></td>
						<td id="06_2030"></td>
						<td id="06_2040"></td>
						<td id="06_2050"></td>
					</tr>
					<tr>
						<td>타</td>
						<td>그 외 비거주용 시설</td>
						<td><input type ="number" id="input_99"/></td>
						<td id="99_2025"></td>
						<td id="99_2030"></td>
						<td id="99_2040"></td>
						<td id="99_2050"></td>
					</tr>
				</table>
			</div>
		</div>

		<!-- END MAIN -->

	</div>


	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<!-- Spec.JS -->
	<script src="/resources/js/openTotalTargetMgmt.js"></script>

</body>
</html>