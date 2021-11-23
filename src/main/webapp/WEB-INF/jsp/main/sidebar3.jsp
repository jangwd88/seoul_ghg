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
				<c:if test="${loginInfo.AUTH_INFO == '1'}">
				<li>
					<a href="/dash/dashCurrentSub.do" class="">
						<i class="fas fa-home"></i>
						<span class="title">건물별 조회</span>
					</a>
				</li>
							
				<li>
					<a href="/dash/spec/dashboard.do" class="">
						<i class="fas fa-check"></i>
						<span class="title">총량제 대상</span>
					</a>
				</li>
				
				<li>
					<a href="/dash/inven/current.do" class="">
						<i class="fas fa-chart-line"></i>
						<span class="title">인벤토리 추세</span>
					</a>
				</li>		
				</c:if>
			</ul>
<!-- 			<button type="button" class="btn-toggle-minified" title="Toggle Minified Menu"> -->
<!-- 				<i class="ti-arrows-horizontal"></i> -->
<!-- 			</button> -->
		</nav>
	</div>
<!-- END LEFT SIDEBAR -->