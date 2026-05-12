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
	border-radius: 8px;
	margin-bottom: 25px;
}

.post-img-wrapper {
	width: 100%;
	background-color: #f8f9fa;
	cursor: pointer;
	aspect-ratio: 1/1;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
}

.post-img {
	width: 100%;
	height: 100%;
	display: block;
	object-fit: cover;
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

							<!-- POST -->
							<div class="post-container">

								<c:forEach items="${postList}" var="p">

									<article class="post-card">

										<div class="post-header p-3">
											<strong>User ${p.userNo}</strong>

										</div>

										<div class="post-img-wrapper"
											onclick="openDetail('post', '${p.feedNo}')">
											<img src="/files/post/${p.list[0].fileName}">


											<c:choose>

												<c:when
													test="${not empty p.list and not empty p.list[0].fileName}">



												</c:when>

												<%-- <c:otherwise>

												<img src="/img/default_post.png" class="post-img">

											</c:otherwise> --%>

											</c:choose>

										</div>

										<div class="post-content">

											<div class="location">
												<i class="fas fa-map-marker-alt"></i> ${p.feedLocation}
											</div>

											<div class="text">
												<strong>User ${p.userNo}</strong> ${p.feedContent}
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
		style="display: none; background: rgba(0, 0, 0, 0.85); position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 9999;">

		<div class="modal-dialog modal-dialog-centered modal-lg">

			<div class="modal-content">

				<div class="modal-body p-0">

					<div class="row no-gutters">

						<div class="col-md-7" id="mImage"></div>

						<div class="col-md-5 p-4 bg-white">

							<div id="mLocation" class="text-muted small mb-2"></div>

							<div id="mContent"></div>

						</div>

					</div>

				</div>

			</div>

		</div>

	</div>

	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>

	<script>
		function openDetail(type, num) {

			$
					.ajax({

						type : "GET",
						url : '/' + type + '/getDetail',
						data : {
							feedNo : num
						},

						success : function(res) {

							$('#mLocation').text(res.feedLocation || '');

							$('#mContent').html(
									'<strong>User ' + res.userNo + '</strong> '
											+ (res.feedContent || ''));

							let fileName = (res.list && res.list.length > 0) ? res.list[0].fileName
									: '';

							let folder = post;

							if (fileName) {

								// Resource handler maps /files/** -> filesystem root (app.upload.path)
								// Use /files/<folder>/<fileName> so the path resolves to
								// {app.upload.path}/{folder}/{fileName}
								$('#mImage')
										.html(
												'<img src="/files/' + folder + '/' + fileName + '" class="img-fluid">');

							} /* else {

																						$('#mImage').html(
																							'<img src="/img/default_post.png" class="img-fluid">'
																						);

																					} */

							$('#detailModal').fadeIn(200);
							$('body').css('overflow', 'hidden');

						}

					});

		}

		$('#detailModal').click(function(e) {

			if (e.target.id === 'detailModal') {
				$('#detailModal').fadeOut(200);
				$('body').css('overflow', 'auto');
			}

		});
	</script>

</body>
</html>