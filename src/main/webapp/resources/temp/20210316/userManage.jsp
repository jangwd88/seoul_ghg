<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
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
</head>
<!-- openlayers -->
<link type="text/css" rel="styleSheet" href="/resources/openlayers/ol.css" />
<link type="text/css" rel="styleSheet" href="/resources/css/datatable/datatables.min.css" />
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
					<h1 class="page-title">사용자관리</h1>
					<p class="page-subtitle">서울특별시 온실가스 모니터링 사용자관리</p>
				</div>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12" id="col-after-size">
						<div class="card">
							<form name="searchFrm" id="searchFrm">
								<div class="project-heading">
									<div class="row">
										<div class="checkDiv">
											<span class="type-name">사용자명</span>
											<label class="type-label">
												<input type="text" class="" id="NAME" name="NAME" placeholder="검색어를 입력하세요" value="">
											</label>
										</div>
										<div class="checkDiv"></div>
										<div class="checkDiv"></div>
										<div class="checkDiv">
											<div class="text-right">
												<button type="button" class="btn btn-primary" aria-expanded="false" id="snb_right_result" onclick="search()">조회</button>
											</div>
										</div>
									</div>
									<hr class="hrSelect">
								</div>
							</form>
							<div class="row">
								<div class="col-lg-12" style="max-height: 700; overflow-y: auto">
									<div class="row">
										<div class="col-md-12" style="text-align: right; padding-left: 10px; padding-bottom: 10px">
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="initPassword();">비밀번호 초기화</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="openModal('userCreatePopup', 'userCreateForm')">등록</button>
											<button type="button" class="btn btn-primary" aria-expanded="false" onclick="modifyUser('userUpdatePopup', 'userUpdateForm')">수정</button>
											<button type="button" class="btn btn-danger" aria-expanded="false" onclick="deleteUser();">삭제</button>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<table id="listTable" class="table table-striped table-project-tasks">
												<tr>
													<td>선택</td>
													<td>사용자명</td>
													<td>아이디</td>
													<td>기관명</td>
													<td>이메일</td>
													<td>전화번호</td>
													<td>가입일</td>
													<td>가입상태</td>
<!-- 													<td>삭제구분</td> -->
													<td>비고</td>
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
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal" tabindex="-1" id="userCreatePopup">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">사용자 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 400px;">
					<form id="userCreateForm" name="userCreateForm">
						<table id="listTable" class="table table-project-tasks">
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col width="35%">
							</colgroup>
							<tr>
								<th>ID</th>
								<td>
									<input type="text" class="" id="ADMIN_ID" name="ADMIN_ID">
								</td>
								<th>패스워드</th>
								<td>
									<input type="password" class="" id="PASSWORD" name="PASSWORD">
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input type="text" class="" id="NAME" name="NAME">
								</td>
								<th>기관명</th>
								<td>
									<select class="" id="INSTITUTION" name="INSTITUTION" style="width: 154px;">
										<option value="">선택</option>
										<c:forEach var="item" items="${officerList}">
											<option value="${item.OFFICER_CD}">${item.OFFICER_NM}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>E-mail</th>
								<td>
									<input type="text" class="" id="EMAIL" name="EMAIL">
								</td>
								<th>전화번호</th>
								<td>
									<input type="text" class="" id="TEL" name="TEL">
								</td>
							</tr>
							<tr>
								<th>가입상태</th>
								<td>
									<select class="" id="REG_STATUS" name="REG_STATUS" style="width: 154px;">
										<option value="">선택</option>
										<c:forEach var="item" items="${REG_STATUS}">
											<option value="${item.CODE}">${item.VALUE}</option>
										</c:forEach>
									</select>
								</td>
								<th>비고</th>
								<td>
									<input type="text" class="" id="MEMO" name="MEMO">
								</td>
							</tr>
							<%-- <tr>
								<th>권한</th>
								<td colspan="3"><select class="" id="AUTH_INFO" name="AUTH_INFO" style="width: 154px;">
										<option value="">선택</option>
										<c:forEach var="item" items="${AUTH_INFO}">
											<option value="${item.CODE}">${item.VALUE}</option>
										</c:forEach>
								</select></td>
							</tr> --%>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="javascript:createUser();">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN -->
	<div class="modal" tabindex="-1" id="userUpdatePopup">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">사용자 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow: auto; height: 400px;">
					<form id="userUpdateForm" name="userUpdateForm">
						<table id="listTable" class="table table-project-tasks">
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col width="35%">
							</colgroup>
							<tr>
								<th>ID</th>
								<td>
									<input type="text" class="" id="ADMIN_ID" name="ADMIN_ID" readonly="readonly">
								</td>
								<th>삭제구분</th>
								<td>
									<select class="" id="FG_DEL" name="FG_DEL" style="width: 154px;">
										<option value="Y">Y</option>
										<option value="N">N</option>

									</select>
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input type="text" class="" id="NAME" name="NAME">
								</td>
								<th>기관명</th>
								<td>
									<select class="" id="INSTITUTION" name="INSTITUTION" style="width: 154px;">
										<c:forEach var="item" items="${officerList}">
											<option value="${item.OFFICER_CD}">${item.OFFICER_NM}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>E-mail</th>
								<td>
									<input type="text" class="" id="EMAIL" name="EMAIL">
								</td>
								<th>전화번호</th>
								<td>
									<input type="text" class="" id="TEL" name="TEL">
								</td>
							</tr>
							<tr>
								<th>가입상태</th>
								<td>
									<select class="" id="REG_STATUS" name="REG_STATUS" style="width: 154px;">
										<c:forEach var="item" items="${REG_STATUS}">
											<option value="${item.CODE}">${item.VALUE}</option>
										</c:forEach>
									</select>
								</td>
								<th>비고</th>
								<td>
									<input type="text" class="" id="MEMO" name="MEMO">
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="updateUser();">저장</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal" tabindex="-1" id="userDeletePopup">
		<div class="modal-dialog" style="margin: 15.75rem auto;">
			<div class="modal-content" style="max-height: 150px;">
				<div class="modal-body" style="overflow: auto; height: 400px; margin: 12px 0px; text-align: center;">
					<span>선택된 사용자를 삭제 하시겠습니까?</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
					<button type="button" class="btn btn-primary" onclick="javascript:deleteUser();">Yes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal" tabindex="-1" id="userInitPopup">
		<div class="modal-dialog" style="margin: 15.75rem auto;">
			<div class="modal-content" style="max-height: 150px;">
				<div class="modal-body" style="overflow: auto; height: 400px; margin: 12px 0px; text-align: center;">
					<span>선택된 사용자의 비밀번호를 초기화 하시겠습니까?</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
					<button type="button" class="btn btn-primary">Yes</button>
				</div>
			</div>
		</div>
	</div>

	<div class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>

	<!-- Vendor -->
	<script src="/resources/js/vendor.min.js"></script>
	<!-- App -->
	<script src="/resources/js/app.min.js"></script>
	<script>
		$(document).ready(function() {
			search();
		});

		function confirmStat(id) {
			$("#" + id).modal('hide');
		}

		function openModal(id, formId) {
			if (formId != undefined && formId != null) {
				$("#" + formId)[0].reset();
			}
			$("#" + id).modal('show');
		}
	</script>
	<script src="/resources/js/datatable/datatables.js"></script>
	<script src="/resources/js/excelExport/excellentexport.js"></script>
	<script>
		function search() {
			var param = $("#searchFrm").serialize();
			callAjax(
					"${pageContext.request.contextPath}/userManage/userManage_search.do",
					true,
					'json',
					param,
					function(data) {
						console.log("data", data);
						var tr = "";
						masterArr = new Array();
						for (key in data) {
							masterArr.push(data[key]);
							tr += "<tr class='userList' id='"+data[key]["ADMIN_ID"]+"' rowidx='"+key+"'>";
							tr += "<td><input type='checkbox' name='masterCheckbox'></td>";
							tr += "<td>" + data[key]["NAME"] + "</td>";
							tr += "<td>" + data[key]["ADMIN_ID"] + "</td>";
							tr += "<td>" + data[key]["INSTITUTION_NM"]
									+ "</td>";
							tr += "<td>" + data[key]["EMAIL"] + "</td>";
							tr += "<td>" + data[key]["TEL"] + "</td>";
							tr += "<td>" + data[key]["D_REG_DATE"] + "</td>";
							tr += "<td>" + data[key]["REG_STATUS_NM"] + "</td>";
// 							tr += "<td>" + data[key]["FG_DEL"] + "</td>";
							tr += "<td>" + data[key]["MEMO"] + "</td>";
							tr += "</tr>";
						}

						if (data.length == 0) {
							tr += "<tr class='userList'>";
							tr += "<td colspan='10'>검색된 결과가 없습니다.</td>";
							tr += "</tr>";
						}

						$(".userList").remove();
						$("#listTable").append(tr);
					});
		}

		function createUser() {
			if (document.userCreateForm.ADMIN_ID.value == "") {
				alert("아이디를 입력해 주세요.");
				document.userCreateForm.ADMIN_ID.focus();
				return;
			}
			if (document.userCreateForm.PASSWORD.value == "") {
				alert("비밀번호를 입력해 주세요.");
				document.userCreateForm.PASSWORD.focus();
				return;
			}
			if (document.userCreateForm.NAME.value == "") {
				alert("사용자명을 입력해 주세요.");
				document.userCreateForm.NAME.focus();
				return;
			}
			if (document.userCreateForm.INSTITUTION.value == "") {
				alert("기관을 선택해 주세요.");
				document.userCreateForm.INSTITUTION.focus();
				return;
			}
			if (document.userCreateForm.REG_STATUS.value == "") {
				alert("가입상태를 선택해 주세요.");
				document.userCreateForm.REG_STATUS.focus();
				return;
			}

			var param = $("#userCreateForm").serialize();
			console.log("param", param);
			callAjax(
					"${pageContext.request.contextPath}/userManage/userManage_create.do",
					true, 'json', param, function(data) {
						console.log("data", data);
						$("#userCreatePopup").modal('hide');
						search();
					});
		}

		function deleteUser() {
			var len = $("input[name='masterCheckbox']:checked").length;
			if (len == 0) {
				alert('삭제할 대상을 선택해 주세요.');
				return;
			}

			var deleteIdArr = "";
			for (var i = 0; i < len; i++) {
				var rowidx = $("input[name='masterCheckbox']:checked").eq(i)
						.parent().parent().attr("rowidx");

				console.log(masterArr[rowidx]);
				deleteIdArr += masterArr[rowidx]["ADMIN_ID"] + ",";
			}
			deleteIdArr = deleteIdArr.substr(0, deleteIdArr.lastIndexOf(","));

			if (confirm('선택한 사용자를 정말 삭제하시겠습니까?')) {
				var param = {
					DELETE_LIST : deleteIdArr
				}
				callAjax(
						"${pageContext.request.contextPath}/userManage/userManage_delete.do",
						true, 'json', param, function(data) {
							$("#userDeletePopup").modal('hide');
							search();
						});
			}
		}

		function modifyUser(id, formId) {
			var len = $("input[name='masterCheckbox']:checked").length;
			if (len == 0) {
				alert('수정할 대상을 선택해 주세요.');
				return;
			}
			if (len > 1) {
				alert('수정할 대상은 1개만 선택해 주세요.');
				return;
			}

			openModal(id, formId);

			var rowidx = $("input[name='masterCheckbox']:checked").eq(0)
					.parent().parent().attr("rowidx");

			$("#" + formId + " input[name=ADMIN_ID]").val(
					masterArr[rowidx]["ADMIN_ID"]);
			$("#" + formId + " input[name=NAME]")
					.val(masterArr[rowidx]["NAME"]);
			$("#" + formId + " select[name=INSTITUTION]").val(
					masterArr[rowidx]["INSTITUTION"]);
			$("#" + formId + " input[name=EMAIL]").val(
					masterArr[rowidx]["EMAIL"]);
			$("#" + formId + " input[name=TEL]").val(masterArr[rowidx]["TEL"]);
			$("#" + formId + " select[name=REG_STATUS]").val(
					masterArr[rowidx]["REG_STATUS"]);
			$("#" + formId + " input[name=MEMO]")
					.val(masterArr[rowidx]["MEMO"]);
			$("#" + formId + " select[name=FG_DEL]").val(
					masterArr[rowidx]["FG_DEL"]);
		}

		function updateUser() {
			if (document.userUpdateForm.NAME.value == "") {
				alert("사용자명을 입력해 주세요.");
				document.userCreateForm.NAME.focus();
				return;
			}
			if (document.userUpdateForm.INSTITUTION.value == "") {
				alert("기관을 선택해 주세요.");
				document.userCreateForm.INSTITUTION.focus();
				return;
			}
			if (document.userUpdateForm.REG_STATUS.value == "") {
				alert("가입상태를 선택해 주세요.");
				document.userCreateForm.REG_STATUS.focus();
				return;
			}

			var param = $("#userUpdateForm").serialize();
			console.log("param", param);
			callAjax(
					"${pageContext.request.contextPath}/userManage/userManage_update.do",
					true, 'json', param, function(data) {
						console.log("data", data);
						$("#userUpdatePopup").modal('hide');
						search();
					});
		}

		function initPassword() {
			var len = $("input[name='masterCheckbox']:checked").length;
			if (len == 0) {
				alert('비밀번호를 초기화할 대상을 선택해 주세요.');
				return;
			}

			var updateIdArr = "";
			for (var i = 0; i < len; i++) {
				var rowidx = $("input[name='masterCheckbox']:checked").eq(i)
						.parent().parent().attr("rowidx");

				console.log(masterArr[rowidx]);
				updateIdArr += masterArr[rowidx]["ADMIN_ID"] + ",";
			}
			updateIdArr = updateIdArr.substr(0, updateIdArr.lastIndexOf(","));

			if (confirm('선택한 사용자의 비밀번호를 초기화 하시겠습니까?')) {
				var param = {
					UPDATE_LIST : updateIdArr
				}
				callAjax(
						"${pageContext.request.contextPath}/userManage/userManage_initPassword.do",
						true, 'json', param, function(data) {
							search();
						});
			}
		}
	</script>
</body>
</html>