<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS Feed</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="/css/feed-detail.css">
</head>

<body>
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				<div class="container-fluid">
					<div class="row justify-content-center">
						<div class="col-lg-8">
							<div class="story-wrapper">
								<c:forEach items="${storyList}" var="s">
									<div class="story-item"
										data-user-no="${s.userNo}"
										data-feed-no="${s.feedNo}"
										onclick="openDetail('story', '${s.feedNo}', '${s.userNo}')">
										<div class="story-circle">
											<img
												src="${not empty s.memberDTO.profileDTO and not empty s.memberDTO.profileDTO.fileName ? '/files/member/'.concat(s.memberDTO.profileDTO.fileName) : '/img/default_user.avif'}"
												onerror="this.src='/img/default_user.avif'">
										</div>
										<small>${s.memberDTO.userNickname}</small>
									</div>
								</c:forEach>
							</div>
							<div class="d-flex justify-content-between gap-2 mb-4">
								<button type="button" class="btn btn-primary w-100 py-2 fw-bold"
									onclick="location.href='/post/create'">
									<i class="fas fa-plus-circle me-2"></i>포스트 만들기
								</button>
								<button type="button"
									class="btn btn-outline-danger w-100 py-2 fw-bold"
									onclick="location.href='/story/create'">
									<i class="fas fa-history me-2"></i>스토리 추가
								</button>
							</div>

							<div class="post-container">
								<c:forEach items="${postList}" var="p">
									<article class="post-card">
										<div class="p-3">
											<strong>${p.memberDTO.userNickname}</strong>
											<br>${p.feedLocation}
										</div>

										<div class="post-img-wrapper"
											onclick="openDetail('post', '${p.feedNo}')">
											<img
												src="${not empty p.list ? '/files/post/'.concat(p.list[0].fileName) : '/img/default_user.avif'}"
												class="post-img">
										</div>

										<div class="p-3 pb-0 d-flex gap-5">
											<div class="action-item" style="cursor: pointer;"
												onclick="likePost('${p.feedNo}')">
												<i class="far fa-heart fa-lg"></i>
											</div>
											<div class="action-item" style="cursor: pointer;"
												onclick="openDetail('post', '${p.feedNo}')">
												<i class="far fa-comment fa-lg"></i>
											</div>
											<div class="action-item" style="cursor: pointer;"
												onclick="sharePost('${p.feedNo}')">
												<i class="far fa-paper-plane fa-lg"></i>
											</div>
										</div>
										<div class="px-3 pb-3 pt-0">
											<strong>${p.memberDTO.userNickname}</strong> ${p.feedContent}
										</div>
									</article>
								</c:forEach>

							</div>
							<div>
								<nav aria-label="Page navigation example">
									<ul class="pagination">
										<li class="page-item ${pager.pre ? '' : 'disabled'}"><a
											class="page-link"
											href="./list?page=${pager.pre ? pager.start-1 : pager.start}&search=${pager.search}&kind=${pager.kind}"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a></li>

										<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
											<li class="page-item ${pager.page == i ? 'active' : ''}">
												<a class="page-link"
												href="./list?page=${i}&search=${pager.search}&kind=${pager.kind}">${i}</a>
											</li>
										</c:forEach>

										<li class="page-item ${pager.next ? '' : 'disabled'}"><a
											class="page-link"
											href="./list?page=${pager.next ? pager.end+1 : pager.end}&search=${pager.search}&kind=${pager.kind}"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a></li>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="detailModal">
		<span class="close-btn" onclick="closeModal()">&times;</span>
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="row g-0 h-100">
						<div id="mImage" class="col-md-7"></div>
						<div id="mInfo" class="col-md-5 info-side">
							<div class="modal-header-custom">
								<strong id="mOwner"></strong>
								<div id="mLocation" class="text-muted small"></div>
							</div>
							<div class="modal-body-custom">
								<div id="mContent"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	<script src="/js/feed-detail.js"></script>
</body>
</html>