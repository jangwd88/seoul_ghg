<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
</head>
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
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/jsp/main/header.jsp"></jsp:include>

	<!-- LEFT SIDEBAR -->
	<jsp:include page="/WEB-INF/jsp/main/sidebar2.jsp"></jsp:include>
	<!-- END LEFT SIDEBAR -->

	<!-- MAIN -->
	<div class="main">

		<!-- MAIN CONTENT -->
		<div class="main-content">

			<div class="content-heading">
				<div class="heading-left">
					<h1 class="page-title">공지사항</h1>
					<p class="page-subtitle">
						<span>서울시 온실가스 모니터링 시스템 공지사항</span>
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
							<a href="/bbs/list.do">공지사항</a>
						</li>
					</ol>
				</nav>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="ta">
						<br>
						<div class="table-responsive" style="width: 1350px;">
							<table id="datatable-column-reorder" class="table table-hover table-bordered" summary="공지사항리스트">
								<thead class="thead-light">
									<tr>
										<th>번호</th>
										<th>말머리</th>
										<th>제목</th>
										<th>작성자</th>
										<th>게시일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${list}">
										<tr>
											<td>${item.bbs_no}</td>
											<td>
												<font color="#1482e0"> [${item.bbs_type}] </font>
											</td>
											<td>
												<a href="view.do?bbs_no=${item.bbs_no}">${item.bbs_subject}
											</td>
											<td>${item.regi_user}</td>
											<td>${item.writedateWithFormat}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<br>

						<div align="right" class="right_mar">
							<c:if test="${sessionScope.loginInfo.AUTH_INFO eq '1'}">
								<a href="/bbs/write.do">
									<button type="button" class="btn btn-primary" aria-expanded="false" value="글쓰기" id="btnwrite">작성</button>
								</a>
							</c:if>
						</div>

						<div align="center">
							<!-- 					네비게이터(navigator) -->
							<jsp:include page="/WEB-INF/jsp/main/navigator.jsp">
								<jsp:param name="pno" value="${pno}" />
								<jsp:param name="count" value="${count}" />
								<jsp:param name="navsize" value="${navsize}" />
								<jsp:param name="pagesize" value="${pagesize}" />
							</jsp:include>
						</div>

						<div align="center">
							<form method="get" action="/bbs/list.do" id="searchForm">
								<select name="type" class="inpt">
									<option value="bbs_subject">제목</option>
								</select>
								<input class="inpt" id="searchInpt" name="keyword" placeholder="검색어" value="${map.keyword}">
								<button type="submit" class="btn btn-primary" value="조회" id="search">조회</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN CONTENT -->

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<script>
	$(document).ready(function() {
		$("#btnWrite").click(function() {
			location.herf = "/bbs/write.do";
		});
	});

	$(document).ready(
			function() {
				function list(page) {
					loaction.href = "/bbs/list.do?=" + "&type-${map.type}"
							+ "&keyword=${map.keyword}";
				}
			});
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e) {
		// 화면에서 키워드가 없다면 검색을 하지 않도록 제어
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요");
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}

		// 폼 태그의 전송을 막음
		e.preventDefault();
		searchForm.submit();
	});
</script>

</body>
</html>