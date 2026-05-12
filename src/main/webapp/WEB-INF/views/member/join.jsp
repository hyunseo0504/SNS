<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	                   <h1 class="h3 mb-4 text-gray-800">회원가입페이지</h1>
	                  	<div>
	                  	
	                  	<form:form method="post" modelAttribute="memberDTO" enctype="multipart/form-data">
						  <div class="form-group">
						    <label for="userId">ID</label>
						    <form:input path="userId" cssClass="form-control" id="userId"/>
						    <form:errors path="userId"></form:errors>
						    <!-- <span id="usernameError" ></span> -->
							
						  </div>
						  
						  <div class="form-group">
						    <label for="userPw">비밀번호</label>
						    <form:password path="userPw" cssClass="form-control" id="userPw"/>
						    <form:errors path="userPw"></form:errors>
							<!-- <span id="passwordError" ></span> -->
						  </div>
						  <div class="form-group">
						  	<form:password path="userPwCheck" cssClass="form-control" id="userPwCheck"/>
						   
						    <form:errors path="userPwCheck"></form:errors>
							<!-- <span id="passwordCheckError" ></span> -->
						  </div>
	                  		
						  <div class="form-group">
						    <label for="userNickname">이름</label>
						    <form:input path="userNickname" cssClass="form-control" id="userNickname"/>
							<form:errors path="userNickname"></form:errors>
							<!-- <span id="nameError" ></span> -->
						  </div>
						  
						  <div class="form-group">
						    <label for="userEmail">이메일</label>
						    <form:input path="userEmail" cssClass="form-control" id="userEmail"/>
						    <form:errors path="userEmail"></form:errors>
						    <!-- <span id="emailError"></span> -->
						  </div>
						  
						  <div class="form-group">
						    <label for="userBirth">생일</label>
						    <input type="date" name="userBirth" class="form-control" id="userBirth">
						    <form:errors path="userBirth"></form:errors>
						    <!-- <span id="birthError"></span> -->
						  </div>
						  
						  
						  
						  <div class="form-group">
						  	<label>첨부파일</label>
						  	<input type="file" name="attach" class="form-control">

						  </div>
						  
						  <button type="submit" class="btn btn-primary" id="btn">Submit</button>
						  
	                  	</form:form>
	                   
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
	<!-- <script src="/js/member/join.js"></script> -->
</body>
</html>