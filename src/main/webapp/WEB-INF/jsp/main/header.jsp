<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML >
<html lang="ko">
<head>
<title>서울시 온실가스 모니터링 시스템</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta property="og:url" content="https://www.ghg.seoul.go.kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

<!-- Multiselect css -->
<link href="/resources/plugins/bootstrap-multiselect/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />

<!-- App css -->
<link rel="stylesheet" type="text/css" href="/resources/css/bootstrap-custom.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/app.min.css" />

<!-- Fonts -->
<link href="/resources/fonts/fontawesome-free-5.15/css/all.min.css" rel="stylesheet">

<!-- Favicon -->
<link rel="shortcut icon" href="/resources/images/favicon.png">

<!-- JQuery -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/jquery-ui.min.js"></script>

<!-- Chart.js -->
<script src="/resources/js/chartJs/Chart.min.js"></script>
<script src="/resources/js/chartJs/utils.js"></script>
<script src="/resources/js/common/common.js"></script>
<!-- html2canvas -->
<script src="/resources/js/html2canvas/html2canvas.min.js"></script>

<!-- sidebar js custom made by hhh -->
<script src="/resources/js/sidebar.js"></script>

<!-- WRAPPER -->
<div id="wrapper">

	<!-- NAVBAR -->
	<nav class="navbar navbar-expand fixed-top">
		<div class="navbar-brand d-none d-lg-block">
			<a href="/main/intro.do">
				<img src="/resources/images/seoul_logo_ghg.png" class="img-fluid logo" style="width: 280px;" alt="logo">
			</a>
		</div>
		<div class="container-fluid p-0">
			<button id="tour-fullwidth" type="button" class="btn btn-default btn-toggle-fullwidth">
<!-- 				<i class="ti-menu"></i> -->
			</button>

			<div id="navbar-menu">
				<ul class="nav navbar-nav align-items-center">
					<li class="nav-item">
						<a href="/main/actionLogout.do" class="dropdown-toggle btn-toggle-rightsidebar">
							<i class="ti-layout-sidebar-right"></i>
							<span>로그아웃</span>
						</a>
					</li>
<!-- 					<li class="dropdown"> -->
<!-- 						<a href="#void" class="dropdown-toggle" data-toggle="dropdown"> -->
<!-- 							<i class="far fa-user"></i> -->
<%-- 							<span>${loginInfo.NAME}</span> --%>
<!-- 						</a> -->
<!-- 						<ul class="dropdown-menu dropdown-menu-right logged-user-menu"> -->
<!-- 							<li> -->
<!-- 								<a href="page-lockscreen.html"> -->
<!-- 									<i class="ti-user"></i> -->
<!-- 									<span>회원정보</span> -->
<!-- 								</a> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<a href="page-lockscreen.html"> -->
<!-- 									<i class="ti-power-off"></i> -->
<!-- 									<span>로그아웃</span> -->
<!-- 								</a> -->
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</li> -->
				</ul>
			</div>
		</div>
	</nav>
	<!-- END NAVBAR -->