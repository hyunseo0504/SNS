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
	                   <h1 class="h3 mb-4 text-gray-800">마이페이지</h1>
	                  	<div>
	                  	
	                  	<form:form method="post" modelAttribute="memberDTO" enctype="multipart/form-data">
						  
	                  		
						  <div class="form-group">
						    <label for="name">이름</label>
						    <form:input path="name" cssClass="form-control" id="name"/>
							<form:errors path="name"></form:errors>
							<!-- <span id="nameError" ></span> -->
						  </div>
						  						 
						<div class="form-group">
						    <label for="phone">전화번호</label>
						   	<form:input path="phone" cssClass="form-control" id="phone"/>
						   	<form:errors path="phone"></form:errors>
							<!-- <span id="phoneError"></span> -->
						  </div>
						  
						  <div class="form-group">
						    <label for="email">이메일</label>
						    <form:input path="email" cssClass="form-control" id="email"/>
						    <form:errors path="email"></form:errors>
						    <!-- <span id="emailError"></span> -->
						  </div>
						  
						  <div class="form-group">
						    <label for="birth">생일</label>
						    <input type="date" value="${memberDTO.birth}" name="birth" class="form-control" id="birth">
						    <form:errors path="birth"></form:errors>
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