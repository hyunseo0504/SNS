<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
</head>

<body id="page-top">
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		
		<div id="content-wrapper" class="d-flex flex-column">
		
			<div id="content">
			
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
					
				<!-- Begin Page Content -->
				<div class="container-fluid">

	                   <!-- Page Heading -->
	                   <h1 class="h3 mb-4 text-gray-800">Index Page</h1>
	                   
	                   <sec:authorize access="isAuthenticated()">
	                   	<h3>로그인 상태</h3>
	                   	<spring:message code="welcome.login" arguments="${member.userId}, ${member.userBirth}" argumentSeparator=","></spring:message>
	                   	</sec:authorize>
	                   
	                   <sec:authorize access="!isAuthenticated()">
	                   <h3>비 로그인 상태</h3>
	                   </sec:authorize>
	                   
	                   
	                   <spring:message code="hi" text="code가 없을 때 출력하는 기본 메세지" var="m"></spring:message>
						
	                   ${m}, ${m}
	                   
	                   <div id="map" style="width:500px;height:400px;">
	                   
	                   
	             
	                   </div>
                </div>
                <!-- End Page container-fluid -->
			</div>
			<!-- End page Content -->
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
		<!-- End content-wrapper -->
	</div>
	<!-- End wrapper -->
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	
	
</body>
</html>