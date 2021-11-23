<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<link href="/resources/css/main/intro.css" rel="stylesheet" type="text/css" />

<!-- Multiselect css -->
<link href="/resources/plugins/bootstrap-multiselect/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
<!-- App css -->
<link href="/resources/css/bootstrap-custom.min.css" rel="stylesheet" type="text/css" />

<title>서울시 온실가스 모니터링 시스템</title>
<script type="text/javascript">
	function goUrl(url) {
		document.location.href = url;
	}
</script>
</head>
<body class="introPage">
	<div style="height: 870px;">
		<div align="right" style="margin-top: 15px;">
			<div style="display: inline-block; margin-right: 15px;">
				<c:if test="${loginInfo.AUTH_INFO == '1'}">
					<button class="btn btn-primary" onclick="javascript:goUrl('/userManage/userManage.do');">시스템관리자</button>
				</c:if>
			</div>
			<div style="display: inline-block; margin-right: 10px;">
				<button class="btn btn-primary" onclick="javascript:goUrl('/main/actionLogout.do');">로그아웃</button>
			</div>
		</div>
	</div>
	<div class="wrap" align="center">
		<div>
			<div class="d1" align="center">
				<div>
					<div class="arch_logo"></div>
					<div class="link" style="border-left: 10px solid #4b7cdf;">
						<ul class="arch">
							<li>
								<a href="/stat/stat001.do">온실가스 배출 통계</a>
							</li>
							<li>
								<a href="/space/selectDetail.do">온실가스 지도</a>
							</li>
							<li>
								<a href="/spec/specArch.do">건물 온실가스 총량제</a>
							</li>
							<c:if test="${loginInfo.AUTH_INFO == '1'}">
								<li>
									<a href="/dash/dashCurrentSub.do">대시보드</a>
								</li>
								<li style="display: inline-block; margin-left: 100px;">
									<a href="/individual/openIndividual.do">개인화 서비스</a>
								</li>
							</c:if>
							<c:if test="${loginInfo.AUTH_INFO != '1'}">
								<li style="display: inline-block;">
									<a href="/individual/openIndividual.do">개인화 서비스</a>
								</li>
							</c:if>
						</ul>
						<p>
							건축물 온실가스 배출량
							<br>
							지도기반의 정보공유서비스입니다.
						</p>
					</div>
				</div>
			</div>
			<div class="d2">
				<div>
					<div class="inventory_logo"></div>
					<div class="link" style="border-left: 10px solid #00a47a;">
						<ul class="inventory">
							<li>
								<a href="/inven/inven009.do">인벤토리 추세</a>
							</li>
							<li>
								<a href="/inven/inven001.do">인벤토리 확정</a>
							</li>
							<li>
								<a href="/invenCal/invenCal001.do">인벤토리 추정</a>
							</li>
							<c:if test="${loginInfo.AUTH_INFO == '1'}">
								<li>
									<a href="/standInfo/standInfo003.do">기준정보</a>
								</li>
								<li style="display: inline-block; margin-left: 100px;">
									<a href="/dataManage/dataManage001.do">데이터관리</a>
								</li>
							</c:if>
						</ul>
						<p>
							인벤토리
							<br>
							배출량 통계의 정보공유서비스입니다.
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div align="center">
		<img src="/resources/images/iseoulu_b.png" style="width: 150px;">
	</div>
</body>
</html>
