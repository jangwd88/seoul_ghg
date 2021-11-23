<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
	<nav>
		<ul class="nav" id="sidebar-nav-menu">
			<li class="panel">
				<a href="#charts" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class="">
					<i class="ti-pie-chart"></i>
					<span class="title">온실가스 배출통계</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="charts" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/stat/stat001.do" class="">주제별 사용 통계</a>
						</li>
						<li>
							<a href="/stat/stat002.do" class="">지역별 사용통계</a>
						</li>
					</ul>
				</div>
			</li>

			<li class="panel">
				<a href="#maps" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="ti-map"></i>
					<span class="title">온실가스 지도</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="maps" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/space/selectDetail.do" class="">상세조회</a>
						</li>
						<li>
							<a href="/space/selectArch.do" class="">건축물</a>
						</li>
						<li>
							<a href="/space/selectDistrict.do" class="">행정구역</a>
						</li>
					</ul>
				</div>
			</li>
			
			<li class="panel">
				<a href="#subPages" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="fas fa-building"></i>
					<span class="title">건물 온실가스 총량제</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="subPages" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/spec/specArch.do"  class="">총량제 대상 건축물</a>
						</li>
<!-- 						<li> -->
<!-- 							<a href="/stat/stat003.do" class="">목표 등록 및 조회</a> -->
<!-- 						</li> -->
						<li>
							<a href="/spec/openTotalTargetMgmt.do" class="">총량제 목표 관리</a>
						</li>
					</ul>
				</div>
			</li>
			
		<c:if test="${loginInfo.AUTH_INFO == '1'}">
			<li class="panel">
				<a href="#dashs" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="ti-layout-grid2"></i>
					<span class="title">대시보드</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="dashs" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/dash/dashCurrentSub.do" class="">건물별 조회</a>
						</li>
						<li>
							<a href="/dash/spec/dashboard.do" class="">총량제 대상</a>
						</li>
						<li>
							<a href="/dash/inven/current.do" class="">인벤토리 추세</a>
						</li>
					</ul>
				</div>
			</li>
		</c:if>
		
			<li class="panel">
				<a href="#indvi" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="far fa-address-card"></i>
					<span class="title">개인화 서비스</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="indvi" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/individual/openIndividual.do" class="">즐겨찾는 건축물</a>
						</li>
					</ul>
				</div>
			</li>
			
			<c:if test="${loginInfo.AUTH_INFO == '1'}">
				<li class="menu-group">시스템 관리</li>
				<li class="panel">
					<a href="#uiElements" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class="">
						<i class="ti-panel"></i>
						<span class="title">시스템 관리</span>
						<i class="icon-submenu ti-angle-left"></i>
					</a>
					<div id="uiElements" class="collapse">
						<ul class="submenu">
							<li>
								<a href="/userManage/userManage.do" class="">사용자관리</a>
							</li>
							<li>
								<a href="/authManage/authManage.do" class="">권한관리</a>
							</li>
							<li>
								<a href="/logManage/logManage.do" class="">로그관리</a>
							</li>
							<li>
								<a href="/codeManage/codeManage.do" class="">코드관리</a>
							</li>
						</ul>
					</div>
				</li>
			</c:if>
			<li>
				<a href="/bbs/list.do" class="">
					<i class="fas fa-check"></i>
					<span class="title">공지사항</span>
				</a>
			</li>
		</ul>
		<!-- 			<button type="button" class="btn-toggle-minified" title="Toggle Minified Menu"> -->
		<!-- 				<i class="ti-arrows-horizontal"></i> -->
		<!-- 			</button> -->
	</nav>
</div>
<!-- END LEFT SIDEBAR -->