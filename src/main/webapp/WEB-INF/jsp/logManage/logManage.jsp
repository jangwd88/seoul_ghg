<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<style>
* {
	box-sizing: border-box;
}

.page-navigator li {
	display: inline-block;
}

table {
	width: 70%;
	border-color: #848484;
}

td:nth-child(1) {
	width: 150px;
}

td:nth-child(2) {
	width: 300px;
}

td:nth-child(3) {
	width: 600px;
}

.ta {
	display: inline-block;
	margin: 0 auto;
}

a {
	text-decoration: none;
	color: black;
}

.page-navigator li {
	display: inline-block;
}

.page-navigator li.active>a {
	color: #1482e0;
}

.btn {
	display: white;
	width: 80px;
	height: 10x;
	line-height: 20px;
	border: 1px #3399dd solid;
	background-color: white;
	text-align: center;
	font-size: 12px;
	cursor: pointer;
	color: #1482e0;
	transition: all 0.9s, color 0.3;
}

.btn:hover {
	color: white;
}

.hover3:hover {
	background-color: #1482e0;
}

.inpt {
	width: 150px;
	height: 40px;
	font-size: 14px;
	vertical-align: middle;
	border-color: #BDBDBD;
	border-style: solid;
	border-width: 1px;
	border-radius: 4px;
}

select {
	width: 80px;
	height: 40px;
	font-size: 14px;
	vertical-align: middle;
	border-color: #848484;
	border-style: solid;
	border-width: 1px;
	border-radius: 4px;
}
</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>
	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar2.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->
	
	<div class="main">

		<!-- MAIN CONTENT -->
		<div class="main-content">

			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">로그관리</h1>
					<p class="page-subtitle">
						<span>사용자별 페이지 방문 로그 관리</span>
						&nbsp;&nbsp;&nbsp;
					</p>
				</div>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<i class="fa fa-home"></i>
							Home
						</li>
						<li class="breadcrumb-item">
							<a href="/logManage/logManage.do">로그관리</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="ta" style="width: 100%;">
						<br>
						<div class="table-responsive" style="width: 100%;">
							<table id="datatable-column-reorder" class="table table-hover table-bordered" summary="공지사항리스트">
								<colgroup>
									<col width="6%">
									<col width="8%">
									<col width="10%">
									<col width="24%">
									<col width="">
									<col width="10%">
									<col width="12%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>방문 페이지</th>
										<th>프로그램명</th>
										<th>접속IP</th>
										<th>방문일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${ fn:length(accLogList) > 0 }">
											<c:forEach items="${accLogList}" var="item">
												<tr>
													<td style="word-break: normal;">${item.rowNo}</td>
													<td style="word-break: normal;">${item.userNo}</td>
													<td style="word-break: normal;">${item.userNm}</td>
													<td style="word-break: normal; text-align: left;">${item.progUrl}</td>
													<td style="word-break: normal; text-align: left;">${item.progNm}</td>
													<td style="word-break: normal; text-align: left;">${item.ipAddr}</td>
													<td style="word-break: normal;">${item.cntnDt}</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="word-break: normal;" colspan="7">조회된 내용이 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>

						<div align="center">
							<!-- 네비게이터(navigator) -->
							<jsp:include page="/WEB-INF/jsp/main/navigator.jsp">
								<jsp:param name="pno" value="${pno}" />
								<jsp:param name="count" value="${count}" />
								<jsp:param name="navsize" value="${navsize}" />
								<jsp:param name="pagesize" value="${pagesize}" />
							</jsp:include>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
	
	<!-- END MAIN -->

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
</body>
</html>