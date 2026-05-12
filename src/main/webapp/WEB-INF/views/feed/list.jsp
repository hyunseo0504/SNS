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
.story-wrapper {
	display: flex;
	overflow-x: auto;
	padding: 20px 10px;
	gap: 20px;
	background-color: #fafafa;
	border: 1px solid #dbdbdb;
	border-radius: 8px;
	margin-bottom: 30px;
	scrollbar-width: none;
}

.story-item {
	text-align: center;
}

.story-circle {
	width: 75px;
	height: 75px;
	border-radius: 50%;
	padding: 3px;
	background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%
		, #bc1888 100%);
	cursor: pointer;
}

.story-circle img {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
	background: white;
	border: 2px solid white;
}

.post-container {
	max-width: 600px;
	margin: 0 auto;
}

.post-card {
	background: #fff;
	border: 1px solid #dbdbdb;
	border-radius: 14px;
	margin-bottom: 25px;
	overflow: hidden;
	box-shadow: 0 10px 28px rgba(0, 0, 0, 0.06);
}

.post-img-wrapper {
	width: 100%;
	aspect-ratio: 1 / 1; /* 1:1 정사각형 틀 고정 */
	overflow: hidden;
	background-color: #111;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.post-img {
	width: 100%;
	height: 100%;
	/* 이미 Create에서 1:1로 잘랐기 때문에 cover를 쓰면 
	   미세한 여백 없이 꽉 찬 완벽한 정사각형 피드가 됩니다. */
	object-fit: cover; 
	display: block;
}

.post-content {
	padding: 16px;
}

#mImage img {
	width: 100%;
	max-height: 600px;
	object-fit: contain;
	background: #000;
}

#detailModal.story-mode {
    display: flex !important; /* block 대신 flex 사용 */
    align-items: center;      /* 세로 중앙 */
    justify-content: center;   /* 가로 중앙 */
    padding: 12px;
}

#detailModal.story-mode .modal-dialog {
    /* 기존의 position: fixed, top, left, transform 등 복잡한 설정 제거 */
    width: 100%;
    max-width: 420px; 
    margin: 0 auto; /* 가로 중앙 정렬 보조 */
    display: flex;
    align-items: center;
    justify-content: center;
}

#detailModal.story-mode .modal-content {
    background: transparent;
    box-shadow: none;
    border: none;
    width: 100%; /* 너비 확보 */
}
#detailModal.story-mode .modal-body,
#detailModal.story-mode .row,
#detailModal.story-mode .col-12 {
	height: auto;
}

#detailModal.story-mode #mImage {
	width: 100%;
	padding: 0;
	background: transparent;
	display: flex;
	align-items: center;
	justify-content: center;
}

#detailModal.story-mode .story-frame {
	position: relative;
	width: 100%;
	max-width: 100%;
	aspect-ratio: 9 / 16;
	background: #000;
	overflow: hidden;
	border-radius: 16px;
}

#detailModal.story-mode .story-frame img {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center center;
	display: block;
}

#detailModal.story-mode .story-user-label {
	position: absolute;
	top: 14px;
	left: 14px;
	z-index: 2;
	padding: 8px 12px;
	border-radius: 999px;
	background: rgba(0, 0, 0, 0.45);
	color: #fff;
	backdrop-filter: blur(6px);
	font-size: 14px;
	line-height: 1;
}

@media (max-width: 767.98px) {
	#detailModal.story-mode .modal-dialog {
		width: calc(100vw - 16px);
	}

	#detailModal.story-mode {
		padding: 8px;
	}

	#detailModal.story-mode .story-frame {
		border-radius: 14px;
	}
}

#detailModal .modal-dialog {
	width: min(980px, calc(100vw - 32px));
	max-width: 980px;
	height: min(84vh, 760px);
	margin: 0 auto;
}

#detailModal.post-mode .modal-dialog {
	width: min(1040px, calc(100vw - 24px));
	max-width: 1040px;
	height: min(84vh, 760px);
}

#detailModal.post-mode .modal-content {
	border-radius: 14px;
	overflow: hidden;
	background: #fff;
}

#detailModal.post-mode #mImage {
	background: #000;
	display: flex;
	align-items: center;
	justify-content: center;
}

#detailModal.post-mode #mImage img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center center;
}

#detailModal.post-mode .col-md-5 {
	border-left: 1px solid #efefef;
	background: #fff;
}

#detailModal.post-mode #mLocation {
	min-height: 20px;
	font-size: 12px;
	color: #8e8e8e;
	margin-bottom: 14px;
	padding-bottom: 10px;
	border-bottom: 1px solid #f0f0f0;
}

#detailModal.post-mode #mContent {
	flex: 1;
	overflow-y: auto;
	line-height: 1.55;
	font-size: 14px;
	color: #222;
}

#detailModal.post-mode .post-detail-owner {
	font-size: 15px;
	margin-bottom: 8px;
}

#detailModal.post-mode .post-detail-text {
	white-space: normal;
	word-break: break-word;
}

#detailModal .modal-content {
	height: 100%;
	border: 0;
	border-radius: 18px;
	overflow: hidden;
	background: #fff;
}

#detailModal .modal-body {
	height: 100%;
}

#detailModal .row {
	height: 100%;
}

#detailModal #mImage {
	height: 100%;
	background: #000;
}

#detailModal #mImage img {
	width: 100%;
	height: 100%;
	max-height: none;
	object-fit: cover;
	display: block;
}

#detailModal .col-md-5 {
	display: flex;
	flex-direction: column;
	overflow: hidden;
}

#detailModal #mContent {
	overflow-y: auto;
	padding-right: 4px;
}

@media (max-width: 767.98px) {
	#detailModal .modal-dialog {
		width: calc(100vw - 20px);
		height: auto;
		max-width: none;
	}

	#detailModal .modal-content,
	#detailModal .modal-body,
	#detailModal .row {
		height: auto;
	}

	#detailModal .row {
		flex-direction: column;
	}

	#detailModal #mImage {
		height: 58vh;
	}

	#detailModal #mImage img {
		height: 100%;
		object-fit: cover;
	}

	#detailModal .col-md-5 {
		max-height: 42vh;
	}

	#detailModal.post-mode .modal-dialog {
		width: calc(100vw - 16px);
		height: auto;
	}

	#detailModal.post-mode #mImage {
		height: 56vh;
	}

	#detailModal.post-mode .col-md-5 {
		max-height: 36vh;
	}
}
</style>
</head>

<body id="page-top">

	<div id="wrapper">

		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>

		<div id="content-wrapper" class="d-flex flex-column">

			<div id="content">

				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="container-fluid">

					<div class="row justify-content-center">

						<div class="col-lg-8 col-md-10">

							<!-- STORY -->
							<div class="story-wrapper">

								<c:forEach items="${storyList}" var="s">

									<div class="story-item">

										<div class="story-circle"
											onclick="openDetail('story', '${s.feedNo}')">

											<c:choose>

												<c:when
													test="${not empty s.list and not empty s.list[0].fileName}">

													<img src="/files/story/${s.list[0].fileName}"
														onerror="this.src='/img/default_user.avif'">

												</c:when>

												<c:otherwise>

													<img src="/img/default_user.avif">

												</c:otherwise>

											</c:choose>

										</div>

										<small class="text-truncate d-block" style="width: 75px;">
											User ${s.userNo} </small>

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

							<!-- POST -->
							<div class="post-container">

								<c:forEach items="${postList}" var="p">

									<article class="post-card">

										<div class="post-header p-3">
											<strong>User ${p.userNo}</strong>

										</div>

										<div class="post-img-wrapper"
											onclick="openDetail('post', '${p.feedNo}')">
											<c:choose>
												<c:when test="${not empty p.list and not empty p.list[0].fileName}">
													<img src="/files/post/${p.list[0].fileName}" class="post-img">
												</c:when>
												<c:otherwise>
													<img src="/img/default_user.avif" class="post-img">
												</c:otherwise>
											</c:choose>

										</div>

										<div class="post-content">

											<c:if test="${not empty p.feedLocation}">
												<div class="location">
													<i class="fas fa-map-marker-alt"></i> ${p.feedLocation}
												</div>
											</c:if>

											<div class="text">
												<strong>User ${p.userNo}</strong> <br>${p.feedContent}
											</div>

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

	<!-- MODAL -->
<div id="detailModal" class="modal" tabindex="-1"
    style="display: none; background: rgba(0, 0, 0, 0.9); position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 9999;">

    <div class="modal-dialog modal-dialog-centered"> <!-- 클래스 단순화 -->
        <div class="modal-content">
            <div class="modal-body p-0">
                <!-- 닫기 버튼 -->
                <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" 
                        style="z-index: 10;" onclick="closeModal()"></button>

                <div class="row g-0 h-100"> <!-- g-0으로 간격 제거, h-100으로 높이 꽉 채움 -->
                    <!-- 왼쪽: 이미지 영역 -->
                    <div class="col-md-7 d-flex align-items-center justify-content-center bg-black" id="mImage">
                        <!-- JS에서 img 태그가 삽입됨 -->
                    </div>

                    <!-- 오른쪽: 정보 영역 -->
                    <div class="col-md-5 d-flex flex-column bg-white">
                        <!-- 유저 정보 & 위치 (상단 고정) -->
                        <div class="p-3 border-bottom">
                            <div id="mOwner" class="fw-bold mb-1"></div> <!-- 유저 아이디 전용 -->
                            <div id="mLocation" class="text-muted small"></div>
                        </div>
                        
                        <!-- 본문 내용 (중간 영역, 길어지면 스크롤) -->
                        <div id="mContent" class="p-3 flex-grow-1 overflow-auto">
                            <!-- JS에서 본문 내용이 삽입됨 -->
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