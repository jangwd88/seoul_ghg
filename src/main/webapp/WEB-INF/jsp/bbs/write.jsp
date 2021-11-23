<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.net.URLEncoder"%>

<c:set var="context" value="${pageContext.request.contextPath}"></c:set>

</head>

<!-- naver toast ui editor를 쓰기 위해 필요한 준비물 -->
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/codemirror.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/github.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/css/tui-color-picker.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/dist/tui-editor.min.css">
<link rel="stylesheet" type="text/css" href="${context}/resources/toast/dist/tui-editor-contents.min.css">

<!-- 네이버 토스트에디터 종료 -->
<style>
.ta {
	padding-top: 70px;
	display: inline-block;
	margin: 0 auto;
	width: 80%;
	align-content: center;
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
				<form id="sform" name="sform" action="/bbs/insert.do" align="center" enctype="multipart/form-data">
					<section class="ta">
						<input type="hidden" name="regi_user" value="${sessionScope.loginInfo.ADMIN_ID}">
						<div class="form-group" align="left">
							<label for="bbs_type">말머리</label>
							<select id="ticket-priority" name="bbs_type" class="form-control">
								<option value="전체공지">전체공지</option>
								<option value="관리자공지">관리자공지</option>
								<option value="사용자공지">사용자공지</option>
							</select>
						</div>


						<div class="form-group" align="left">
							<label for="bbs_subject">제목</label>
							<input class="form-control" name="bbs_subject" id="bbs_subject" placeholder="글 제목 입력">
						</div>

						<div class="form-group" align="left">
							<label for="bbs_content">공지 내용</label>
							<div class="naver-editor"></div>
							<input type="hidden" name="bbs_content" value="">
						</div>


						<div class="form-group" align="center">
							<input type="submit" value="확인" class="btn btn-primary" id="btnSave" onClick="save_event();">
							<input type="reset" value="초기화" class="btn btn-primary">
						</div>
					</section>
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
			//생성은 항상 옵션 먼저 + 나중에 생성
			var options = {
				//대상
				el : document.querySelector(".naver-editor"),
				//미리보기 스타일(vertical / horizontal)
				previewStyle : "horizontal",
				//입력 스타일
				initialEditType : "wysiwyg",
				//높이
				height : "300px"
			};
	
			var editor = tui.Editor.factory(options);
	
			//에디터의 값이 변하면 뒤에 있는 input[type=hidden]의 값이 변경되도록 처리
			editor
					.on(
							"change",
							function() {
								var text = editor.getValue();//에디터에 입력된 값을 불러온다
								document
										.querySelector(".naver-editor + input[type=hidden]").value = text;
							});
		});
	
		function save_event() {
			var form = document.getElementById("sform");
			// 		param="+paramMap"+encodeURI(encodeURIComponent(param));
			form.action = "/bbs/insertBbs.do";
			form.submit();
	
			if (form.bbs_subject.value == "") {
				alert("제목을 입력해주세요.");
				form.bbs_subject.focus();
				return false;
			}
		}
	</script>
</body>
</html>