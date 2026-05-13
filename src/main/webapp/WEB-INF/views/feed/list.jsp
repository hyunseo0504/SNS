<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS Feed</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>

<style>
/* --- 기본 레이아웃 (유지) --- */
body {
	background-color: #fafafa;
	margin: 0;
}

.story-wrapper {
	display: flex;
	overflow-x: auto;
	padding: 20px 10px;
	gap: 20px;
	background-color: #fff;
	border: 1px solid #dbdbdb;
	border-radius: 8px;
	margin-bottom: 30px;
	scrollbar-width: none;
}

.story-circle {
	width: 66px;
	height: 66px;
	border-radius: 50%;
	padding: 3px;
	background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
}

.story-circle img {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
	background: white;
	border: 2px solid white;
}
/* 아이콘 버튼 스타일 */
.action-item i {
	color: #262626;
	transition: transform 0.1s ease;
}

.action-item:hover i {
	color: #8e8e8e;
}

/* 좋아요 활성화 상태(빨간 하트) */
.action-item i.fas.fa-heart {
	color: #ed4956;
}

/* 아이콘 클릭 시 살짝 커지는 효과 */
.action-item:active {
	transform: scale(1.1);
}
/* 아이콘들 사이의 간격을 더 넓게 설정 */
.post-card .d-flex.gap-5 {
    gap: 1.5rem !important; /* 부트스트랩 기본값보다 더 넓게 */
}

/* 또는 개별 아이콘에 여백 추가 */
.action-item {
    padding-right: 5px; /* 아이콘 오른쪽 간격 추가 */
}

.action-item i {
    font-size: 1.5rem; /* 아이콘 크기가 작아 보인다면 살짝 키우는 것도 방법입니다 */
}

.post-container {
	max-width: 470px;
	margin: 0 auto;
}

.post-card {
	background: #fff;
	border: 1px solid #dbdbdb;
	border-radius: 8px;
	margin-bottom: 25px;
	overflow: hidden;
}

.post-img-wrapper {
	width: 100%;
	aspect-ratio: 1/1;
	cursor: pointer;
	background: #111;
}

.post-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* --- 모달 공통 설정 --- */
#detailModal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.9);
	z-index: 9999;
	align-items: center;
	justify-content: center;
}

.close-btn {
	position: absolute;
	top: 20px;
	right: 25px;
	color: #fff;
	font-size: 35px;
	cursor: pointer;
	z-index: 10001;
}

/* --- [핵심] 스토리 모드: 창 높이 80% 기준 슬림 세로형 --- */
#detailModal.story-mode .modal-dialog {
	/* Bootstrap의 가로 너비 강제 해제 */
	width: auto !important;
	max-width: none !important;
	min-width: 0 !important;
	/* [포인트] 현재 창 높이의 80% 고정 */
	height: 80vh !important;
	margin: 0 auto !important;
	display: flex;
	align-items: center;
	justify-content: center;
}

#detailModal.story-mode .modal-content {
	background: transparent !important;
	border: none !important;
	height: 100% !important;
	width: auto !important;
}

#detailModal.story-mode .modal-body {
	padding: 0 !important;
	height: 100% !important;
	width: auto !important;
}

#detailModal.story-mode .story-frame {
	position: relative;
	height: 100%;
	/* 높이에 맞춰 9:16 비율 자동 계산 */
	aspect-ratio: 9/16 !important;
	background: #000;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
}

#detailModal.story-mode .story-frame img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 프레임에 꽉 차게 */
}

#detailModal.story-mode .story-user-label {
	position: absolute;
	top: 15px;
	left: 15px;
	z-index: 10;
	color: #fff;
	font-weight: bold;
	text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
}

/* --- [기존 유지] 포스트 모드 --- */
#detailModal.post-mode .modal-dialog {
	width: 90% !important;
	max-width: 1100px !important;
	height: 80vh !important;
	margin: 0 auto !important;
}

#detailModal.post-mode .modal-content {
	height: 100%;
	background: #fff;
	border-radius: 4px;
	overflow: hidden;
}

#detailModal.post-mode #mImage {
	height: 100%;
	background: #000;
	padding: 0;
	display: flex;
	align-items: center;
}

#detailModal.post-mode #mImage img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

#detailModal.post-mode .info-side {
	display: flex;
	flex-direction: column;
	border-left: 1px solid #efefef;
	height: 100%;
	background: #fff;
}

.modal-header-custom {
	padding: 15px;
	border-bottom: 1px solid #efefef;
}

.modal-body-custom {
	padding: 15px;
	flex-grow: 1;
	overflow-y: auto;
	font-size: 14px;
}
</style>
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
										onclick="openDetail('story', '${s.feedNo}')">
										<div class="story-circle">
											<img
												src="${not empty s.list ? '/files/story/'.concat(s.list[0].fileName) : '/img/default_user.avif'}"
												onerror="this.src='/img/default_user.avif'">
										</div>
										<small>User ${s.userNo}</small>
									</div>
								</c:forEach>
							</div>
							
							<div class="post-container">
								<c:forEach items="${postList}" var="p">
									<article class="post-card">
										<div class="p-3">
											<strong>User ${p.userNo}</strong>
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
											<strong>User ${p.userNo}</strong> ${p.feedContent}
										</div>
									</article>
								</c:forEach>

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