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
				<form id="sform" name="sform" align="center">
					<section class="ta">
						<input type="hidden" name="regi_user" value="${sessionScope.loginInfo.admin_id}">
						<input type="hidden" name="bbs_no" value="${bbsVO.bbs_no}">

						<div class="form-group" align="left">
							<label for="bbs_type">말머리</label>
							<select id="ticket-priority" name="bbs_type" class="form-control">
								<option value="전체공지" <c:if test="${bbsVO.bbs_type eq '전체공지'}">selected</c:if>>전체공지</option>
								<option value="관리자공지" <c:if test="${bbsVO.bbs_type eq '관리자공지'}">selected</c:if>>관리자공지</option>
								<option value="사용자공지" <c:if test="${bbsVO.bbs_type eq '사용자공지'}">selected</c:if>>사용자공지</option>
							</select>
						</div>

						<div class="form-group" align="left">
							<label for="bbs_subject">제목</label>
							<input class="form-control" name="bbs_subject" id="bbs_subject" placeholder="${bbsVO.bbs_subject}" value="${bbsVO.bbs_subject}">
						</div>

						<div class="form-group" align="left">
							<label for="bbs_content">공지사항 내용</label>
							<div class="naver-editor"></div>
							<input type="hidden" name="bbs_content" value="${bbsVO.bbs_content}">
						</div>

						<div class="form-group" align="center">
							<input type="hidden" name="bbs_no" value="${bbsVO.bbs_no}">
							<input type="button" value="수정" class="btn btn-primary" onClick="update_event();">

							<a href="/bbs/list.do">
								<input type="button" value="목록으로" class="btn btn-primary">
							</a>
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
				height : "300px",
	
				hooks : {
					'addImageBlobHook' : function(blob, callback) {
						//이미지 블롭을 이용해 서버 연동 후 콜백실행
						//callback('이미지URL');
						console.log("이미지 업로드");
					}
				}
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
			//에디터에서 불러온 값 변경
			var text = document.querySelector(".naver-editor + input[type=hidden]").value;
			editor.setValue(text);//값 설정
		});
	
		function update_event() {
			var f = document.sform;
			f.action = "/bbs/procUpdate.do";
			f.submit();
		}
	</script>
</body>
</html>