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
	                   <h1 class="h3 mb-4 text-gray-800">로그인페이지</h1>
	                   <div>
	                   	<h3>${param.message}</h3>
	                   </div>
	                   <div>
	                   
	                   <form action="./login" method="post" enctype="multipart/form-data">
						  <div class="form-group">
						  	<label for="username">ID</label>
						    <input type="text" name="username" value="${cookie.rememberId.value}" class="form-control" id="username" />
						    
						    
						  </div>
						  
						  <div class="form-group">
						    <label for="password">비밀번호</label>
						    <input type="password" name="password" class="form-control" id="password"/>
						   	
						  </div>
						  
						  <div class="form-group form-check">
    							<input type="checkbox" name="rememberId" value="1" class="form-check-input" id="exampleCheck1">
    							<label class="form-check-label" for="exampleCheck1">ID 저장</label>
  							</div>
						  
						  <div class="form-group form-check">
    							<input type="checkbox" name="rememberMe" class="form-check-input" id="exampleCheck1">
    							<label class="form-check-label" for="exampleCheck1">자동 로그인</label>
  							</div>
						  <button type="submit" class="btn btn-primary">Login</button>
	                   </form>
	                   
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