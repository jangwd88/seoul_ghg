<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/51db22a717.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Alata&display=swap" rel="stylesheet">
<!-- login CSS -->
<link href="/resources/css/login.css" rel="stylesheet" type="text/css" />
</head>
<!-- App css -->
<link href="/resources/css/bootstrap-custom.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/app.min.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="/resources/js/common/common.js"></script>
<!-- Vendor -->
<script src="/resources/js/vendor.min.js"></script>
<!-- App -->
<script src="/resources/js/app.min.js"></script>

<style>
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

.table th {
	background-color: #dee2e6;
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

.modal-dialog {
	max-width: 600px !important;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		var message = "${message}";
		console.log("message", message);
		if (message != null && message != "") {
			alert(message);
			return;
		}
		
		$("#loginFrm").find("#ADMIN_ID").keydown(function(event) {
			if (event.keyCode == 13) {
				actionLogin();
			}
		});
		$("#loginFrm").find("#PASSWORD").keydown(function(event) {
			if (event.keyCode == 13) {
				actionLogin();
			}
		});
	});

	function actionLogin() {
		if (document.loginFrm.ADMIN_ID.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.ADMIN_ID.focus();
			return;
		}
		if (document.loginFrm.PASSWORD.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.PASSWORD.focus();
			return;
		}

		if (document.loginFrm.ADMIN_ID.value == document.loginFrm.PASSWORD.value) {
			if (confirm("초기 비밀번호로 로그인 하셨습니다.\n비밀번호가 유출될 수 있습니다. 비밀번호를 변경해 주세요.\n지금 변경하시겠습니까?(예/YES/확인), 나중에 변경하시겠습니까?(아니오/NO/취소)")) {
				document.changePasswordForm.ADMIN_ID.value = document.loginFrm.ADMIN_ID.value;
				openModal("changePassword");
				return;
			} else {
				document.loginFrm.action = "/main/actionLogin.do";
				document.loginFrm.submit();
			}
		} else {
			document.loginFrm.action = "/main/actionLogin.do";
			document.loginFrm.submit();
		}
	}

	function confirmStat(id) {
		$("#" + id).modal('hide');
	}

	function openModal(id) {
		$("#" + id).modal('show');
	}

	function changePassword() {
		if (document.changePasswordForm.PASSWORD.value != document.changePasswordForm.RE_PASSWORD.value) {
			alert("입력한 비밀번호가 틀립니다. 확인해 주세요.");
			document.changePasswordForm.PASSWORD.focus();
			return;
		}

		var param = $("#changePasswordForm").serialize();
		callAjax("${pageContext.request.contextPath}/main/changePassword.do",
				true, 'json', param, function(data) {
					console.log("data", data);
					document.loginFrm.reset();
					document.changePasswordForm.reset();
					alert(data + "\n변경된 비밀번호로 로그인해 주세요.");
					confirmStat("changePassword");

				});
	}
</script>
</head>
<body>
	<div class="page-container">
		<div class="login-form-container shadow">
			<div class="login-form-right-side">
				<div class="top-logo-wrap"></div>
				<h1 style="width: 300px;">서울시 온실가스</h1>
				<h1 style="width: 300px;">모니터링 시스템</h1>
				<p>서울시 온실가스 배출량 추정 및 인벤토리 전산화와 공간정보 기반 에너지 사용량 정보 구축</p>
			</div>
			<div class="login-form-left-side">
				<form id="loginFrm" name="loginFrm" method="post">
					<div class="login-input-container">
						<div class="login-input-wrap input-id">
							<i class="far fa-user"></i>
							<input placeholder="ID" type="text" id="ADMIN_ID" name="ADMIN_ID">
						</div>
						<div class="login-input-wrap input-password">
							<i class="fas fa-key"></i>
							<input placeholder="Password" type="password" id="PASSWORD" name="PASSWORD">
						</div>
					</div>
				</form>
				<div class="login-btn-wrap">
					<button class="login-btn" onclick="javascript:actionLogin()">로그인</button>
					<!-- <a href="#" >비밀번호 찾기</a> -->
					<div>
						<img src="/resources/images/iseoulu_w.png" style="width: 150px; padding-top: 100px;">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal" tabindex="-1" id="changePassword">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 100px;">
					<form id="changePasswordForm" name="changePasswordForm" method="post">
						<input type="hidden" class="" id="ADMIN_ID" name="ADMIN_ID">
						<table id="listTable" class="table table-project-tasks">
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col width="35%">
							</colgroup>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="password" class="" id="PASSWORD" name="PASSWORD">
								</td>
								<th>비밀번호 확인</th>
								<td>
									<input type="password" class="" id="RE_PASSWORD" name="RE_PASSWORD">
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="javascript:changePassword();">저장</button>
				</div>
			</div>
		</div>
	</div>
	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>