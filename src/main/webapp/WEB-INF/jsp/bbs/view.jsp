
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>

</head>

<!-- 에디터와 동일한 의존성 라이브러리 설정을 한다 -->
<!-- naver toast ui editor를 쓰기 위해 필요한 준비물 -->
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/codemirror.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/github.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/tui-color-picker.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/dist/tui-editor.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/dist/tui-editor-contents.min.css">
<style>
* {
	box-sizing: border-box;
}

.notice_table {
	width: 70%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
	border-color: #BDBDBD;
	margin-left: auto;
	margin-right: auto;
	margin-top: 20px;
}

.no-tr {
	border-bottom: none;
	padding: 10px;
	text-align: left;
	border-color: #BDBDBD;
}

.tr1 {
	border-bottom: 1px solid #444444;
	padding-top: 20px;
	padding-bottom: 20px;
	text-align: left;
	border-color: #BDBDBD;
}

td {
	padding-top: 20px;
	padding-bottom: 20px;
}

.td2 {
	text-align: right;
	border-bottom: 1px solid #444444;
	padding: 10px;
	border-color: #BDBDBD;
}

.td3 {
	text-align: left;
	border-bottom: 1px solid #444444;
	padding: 10px;
	border-color: #BDBDBD;
}

.no-td {
	border: none;
}

.mar-td {
	margin-top: 10px;
}

a {
	text-decoration: none;
	color: black;
	margin-left: auto;
	margin-right: auto;
}

hr {
	width: 80%;
}

.no_inputline {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	width: 100px;
	text-align: left;
}

.ta {
	display: inline-block;
	margin: 0 auto;
	width: 80%;
}

.btn {
	display: white;
	width: 120px;
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

.section-content {
	padding-top: 115px;
}

.title {
	width: 1100px;
	text-align: left;
}

.bbs_type {
	font-size: 50px;
	wdith: 180px;
	text-align: left;
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
				<form id="sform" name="sform">
					<div class="row">
						<div class="ta">
							<div class="table-responsive">
								<table class="notice_table">

									<tr class="tr1">
										<td>
											<font color="#1482e0" size="20px;">${bbsVO.bbs_subject}</font>
										</td>
									</tr>

									<tr class="tr1">
										<td>작성자 : ${bbsVO.regi_user}</td>
									</tr>

									<tr class="tr1">
										<td>작성일 : ${bbsVO.writedateWithFormat}</td>
									</tr>

									<tr class="content_tr">
										<td>
											<div class="con">
												<div class="naver-viewer"></div>
												<input type="hidden" name="bbs_content" value="${bbsVO.bbs_content}">
											</div>
										</td>
									</tr>

									<tr>

										<td class="td2">
											<c:if test="${sessionScope.loginInfo.ADMIN_ID eq bbsVO.regi_user}">
												<input type="hidden" name="bbs_no" value="${bbsVO.bbs_no}">

												<a href="/bbs/update.do?bbs_no=${bbsVO.bbs_no}">
													<input type="hidden" name="bbs_no" value="${bbsVO.bbs_no}">
													<button type="button" id="btnupdate" class="btn btn-primary" aria-expanded="false">게시글 수정</button>
												</a>

												<a href="/bbs/delete.do?bbs_no=${bbsVO.bbs_no}">
													<input type="hidden" name="bbs_no" value="${bbsVO.bbs_no}">
													<button type="button" class="btn btn-primary" id="btndelete" onClick="button_event();">게시글 삭제</button>
												</a>
											</c:if>
											<a href="/bbs/list.do">
												<button type="button" class="btn btn-primary">목록</button>
											</a>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- END MAIN CONTENT -->

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>

	<!-- App -->
	<script src="/resources/js/app.min.js"></script>

	<script src="https://code.jquery.com/jquery-latest.js"></script>
	<script src="${context}/resources/toast/dist/tui-editor-Editor-full.min.js"></script>
	<script>
		$(function() {
			var options = {
				//el(element) : 에디터가 될 영역
				el : document.querySelector(".naver-viewer"),
	
				viewer : true,
	
				//height : 생성될 에디터의 높이
				height : 'auto',
			};
	
			var viewer = tui.Editor.factory(options);
	
			//생성된 뷰어에 초기값 표시
			console.log(document
					.querySelector(".naver-viewer + input[type=hidden]"));
			var text = document.querySelector(".naver-viewer + input[type=hidden]").value;
			viewer.setValue(text);//값 설정
		});
	
		function button_event() {
			if (confirm("삭제하시겠습니까?")) {
				var f = document.sform;
				f.action = "/delete.do";
				f.submit();
			} else {
				return false;
			}
		}
	</script>

</body>
</html>