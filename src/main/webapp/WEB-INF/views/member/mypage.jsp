<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
	                   <sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="member" />
	                   <h1 class="h3 mb-4 text-gray-800">${member.userNickname} My Page</h1>
	                   <div>
						<img class="img-profile rounded-circle" src="/files/member/${member.profileDTO.fileName}"> <h6>게시물</h6> <h6>팔로워</h6> <h6>팔로잉</h6>
						</div>
	                   
	                   <div class="d-flex justify-content-between gap-2 mb-4">
								<button type="button" class="btn btn-primary w-48 py-2 fw-bold"
									onclick="location.href='/member/profile'">
									프로필 편집
								</button>
						</div>
						
	                  	<div class="d-flex justify-content-between gap-2 mb-4">
								<button type="button" class="btn btn-primary w-100 py-2 fw-bold"
									onclick="location.href='/post/create'">
									<i class="fas fa-plus-circle me-2"></i>포스트 만들기
								</button>
						</div>
						<div>
						<label>올린 게시물</label>
						<button onclick="location.href='/member/myposts'">모두보기</button>
							<div class="post-summary-list">
								<c:choose>
									<c:when test="${not empty mypost}">
										<ul>
											<c:forEach var="post" items="${myposts}">
												<li><a href="/member/myposts?feedNo=${post.feedNo}">
														${post.feedNo}
												</a></li>
											</c:forEach>
										</ul>
									</c:when>
									<c:otherwise>
										<p>작성한 게시물이 없습니다.</p>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						</sec:authorize>
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











</html>