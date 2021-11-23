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
			<li>
				<a href="/inven/inven009.do" aria-expanded="" class="">
					<i class="fas fa-chart-bar"></i>
					<span class="title">인벤토리 추세</span>
				</a>
			</li>
			<li class="panel">
				<a href="#inven" data-toggle="collapse" data-parent="#sidebar-nav-menu" aria-expanded="" class="">
					<i class="fas fa-check-circle"></i>
					<span class="title">인벤토리 확정</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="inven" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/inven/inven001.do" class="">부문별 조회</a>
						</li>
						<li>
							<a href="/inven/inven002.do" class="">직.간접 조회</a>
						</li>
						<li>
							<a href="/inven/inven003.do" class="">세부카테고리 조회</a>
						</li>
					</ul>
				</div>
			</li>

			<li class="panel">
				<a href="#invenCal" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="fas fa-chart-line"></i>
					<span class="title">인벤토리 추정</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="invenCal" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/invenCal/invenCal001.do" class="">부문별 추정배출량</a>
						</li>
						<li>
							<a href="/invenCal/invenCal003.do" class="">부문별 통계</a>
						</li>
					</ul>
				</div>
			</li>
			<c:if test="${loginInfo.AUTH_INFO == '1'}">
			<li class="panel">
				<a href="#standInfo" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="fas fa-sliders-h"></i>
					<span class="title">기준정보</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="standInfo" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/standInfo/standInfo003.do"  class="">배출시설 관리</a>
						</li>
						<li>
							<a href="/standInfo/standInfo004.do" class="">배출계수 관리</a>
						</li>
					</ul>
				</div>
			</li>

			<li class="panel">
				<a href="#dataManage" data-toggle="collapse" data-parent="#sidebar-nav-menu" class="">
					<i class="fas fa-server"></i>
					<span class="title">데이터관리</span>
					<i class="icon-submenu ti-angle-left"></i>
				</a>
				<div id="dataManage" class="collapse">
					<ul class="submenu">
						<li>
							<a href="/dataManage/dataManage001.do" class="">활동자료 등록(직접배출)</a>
						</li>
						<li>
							<a href="/dataManage/dataManage003.do" class="">활동자료 등록(간접배출)</a>
						</li>
						<li>
							<a href="/dataManage/dataManage002.do" class="">마감관리</a>
						</li>
					</ul>
				</div>
			</li>
			</c:if>

		</ul>
		<!-- 			<button type="button" class="btn-toggle-minified" title="Toggle Minified Menu"> -->
		<!-- 				<i class="ti-arrows-horizontal"></i> -->
		<!-- 			</button> -->
	</nav>
</div>
<!-- END LEFT SIDEBAR -->