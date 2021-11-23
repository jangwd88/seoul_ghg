<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/json; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.google.gson.*" %>

<%
    response.setContentType("application/json");
	Gson gson = new Gson();
    response.getWriter().write(gson.toJson(request.getAttribute("result")).toString());
    
%>
