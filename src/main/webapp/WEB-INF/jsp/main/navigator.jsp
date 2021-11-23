<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 네비게이터(navigator) -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.page-navigator li {
	display: inline-block;
}
</style>

<c:set var="type" value="${param.type}"></c:set>
<c:set var="keyword" value="${param.keyword}"></c:set>
<c:set var="isSearch" value="${not empty type and not empty keyword}"></c:set>
<c:set var="pno" value="${param.pno}"></c:set>
<c:set var="count" value="${param.count}"></c:set>
<c:set var="navsize" value="${param.navsize}"></c:set>
<c:set var="pagesize" value="${param.pagesize}"></c:set>

<!-- EL은 parseInt가 없기 때문에 fmt의 formatNumber 태그를 통해 처리 -->
<fmt:parseNumber var="startBlock" integerOnly="true"
	value="${(pno - 1) / navsize}"></fmt:parseNumber>
<c:set var="startBlock" value="${startBlock * navsize + 1}"></c:set>
<c:set var="finishBlock" value="${startBlock + (navsize - 1)}"></c:set>
<fmt:parseNumber var="pageCount"
	value="${(count + pagesize) / pagesize}"></fmt:parseNumber>

<c:if test="${finishBlock > pageCount}">
	<c:set var="finishBlock" value="${pageCount}"></c:set>
</c:if>

<!-- 포워딩 구조에서는 주소 확인 명령이 달라짐 -->
<c:set var="uri"
	value="${requestScope['javax.servlet.forward.request_uri']}"></c:set>

<ul class="page-navigator">

	<!-- 이전 버튼 -->
	<c:if test="${startBlock > 1}">
		<c:choose>
			<c:when test="${isSearch}">
				<li><a
					href="${uri}?type=${type}&keyword=${keyword}&pno=${startBlock-1}">&lt;</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${uri}?pno=${startBlock-1}">&lt;</a></li>
			</c:otherwise>
		</c:choose>
	</c:if>

	<c:forEach var="i" begin="${startBlock}" end="${finishBlock}">
		<c:choose>
			<c:when test="${i == pno}">
				<li class="active"><a href="#">${i}</a></li>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${isSearch}">
						<li><a href="${uri}?type=${type}&keyword=${keyword}&pno=${i}">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${uri}?pno=${i}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:if test="${finishBlock < pageCount}">
		<c:choose>
			<c:when test="${isSearch}">
				<li><a
					href="${uri}?type=${type}&keyword=${keyword}&pno=${finishBlock+1}">&gt;</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${uri}?pno=${finishBlock+1}">&gt;</a></li>
			</c:otherwise>
		</c:choose>
	</c:if>

</ul>
