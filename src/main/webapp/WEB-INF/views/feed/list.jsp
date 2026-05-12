<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS Feed</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
    /* 1. 스토리 영역: 가로 스크롤 레이아웃 */
    .story-wrapper {
        display: flex;
        overflow-x: auto; /* 가로 스크롤 */
        padding: 20px 10px;
        gap: 20px;
        background-color: #fafafa;
        border: 1px solid #dbdbdb;
        border-radius: 8px;
        margin-bottom: 30px;
        scrollbar-width: none; /* 파이어폭스 스크롤바 숨김 */
    }
    .story-wrapper::-webkit-scrollbar { display: none; } /* 크롬 스크롤바 숨김 */

    .story-item { flex: 0 0 auto; text-align: center; width: 80px; }
    
    .story-circle {
        width: 75px;
        height: 75px;
        border-radius: 50%;
        padding: 3px;
        background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
        cursor: pointer;
        margin-bottom: 5px;
    }
    
    .story-circle img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover;
        background: white;
        border: 2px solid white;
    }

    /* 2. 포스트 영역: 인스타그램 카드 스타일 */
    .post-container { max-width: 600px; margin: 0 auto; }
    
    .post-card {
        background: #fff;
        border: 1px solid #dbdbdb;
        border-radius: 8px;
        margin-bottom: 25px;
    }
    
    .post-header { padding: 14px; display: flex; align-items: center; border-bottom: 1px solid #efefef; }
    .post-header strong { font-size: 14px; }

    .post-img-wrapper { width: 100%; background-color: #fafafa; cursor: pointer; }
    .post-img { width: 100%; height: auto; display: block; }
    
    .post-content { padding: 16px; }
    .post-content .location { font-size: 12px; color: #8e8e8e; margin-bottom: 8px; }
    .post-content .text { font-size: 14px; line-height: 1.5; }

    /* 3. 모달 레이아웃 최적화 */
    .modal-content { border-radius: 12px; overflow: hidden; border: none; }
    .modal-header { border-bottom: 1px solid #efefef; }
    #mImage img { max-height: 500px; object-fit: contain; background: #000; }
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

                            <!-- [SECTION 1] 스토리 리스트 (상단) -->
                            <div class="story-wrapper">
                                <c:forEach items="${storyList}" var="s">
                                    <div class="story-item">
                                        <div class="story-circle" onclick="openDetail('story', '${s.feedNo}')">
                                            <img src="${not empty s.feedThumb ? s.feedThumb : '/resources/img/default_user.png'}" alt="story">
                                        </div>
                                        <small class="text-truncate d-block" style="width: 75px;">User${s.feedNo}</small>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- [SECTION 2] 포스트 리스트 (메인) -->
                            <div class="post-container">
                                <c:forEach items="${postList}" var="p">
                                    <article class="post-card">
                                        <div class="post-header">
                                            <strong>User ${p.feedNo}</strong>
                                        </div>
                                        
                                        <div class="post-img-wrapper" onclick="openDetail('post', '${p.feedNo}')">
                                            <img src="${p.feedThumb}" class="post-img" onerror="this.src='https://via.placeholder.com/600x600?text=No+Image'">
                                        </div>
                                        
                                        <div class="post-content">
                                            <div class="location"><i class="fas fa-map-marker-alt"></i> ${p.feedLocation}</div>
                                            <div class="text">
                                                <strong>User ${p.feedNo}</strong> ${p.feedContent}
                                            </div>
                                        </div>
                                    </article>
                                </c:forEach>

                                <!-- 페이징 (Post 기준) -->
                                <nav class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${pager.pre?'':'disabled'}">
                                            <a class="page-link" href="/feed/list?page=${pager.start-1}">이전</a>
                                        </li>
                                        <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
                                            <li class="page-item ${pager.page==i?'active':''}">
                                                <a class="page-link" href="/feed/list?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${pager.next?'':'disabled'}">
                                            <a class="page-link" href="/feed/list?page=${pager.end+1}">다음</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- 하단 플로팅 버튼 (글쓰기 선택) -->
                            <div class="text-center my-5">
                                <a href="/post/create" class="btn btn-outline-primary mr-2">포스트 올리기</a>
                                <a href="/story/create" class="btn btn-outline-danger">스토리 올리기</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>

    <!-- [MODAL] 상세 보기 팝업 -->
    <div id="detailModal" class="modal" tabindex="-1" style="display:none; background: rgba(0,0,0,0.85); position:fixed; top:0; left:0; width:100%; height:100%; z-index:9999;">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="mTitle"></h5>
                    <button type="button" class="close" onclick="closeModal()" style="font-size: 2rem;">&times;</button>
                </div>
                <div class="modal-body p-0">
                    <div class="row no-gutters">
                        <div class="col-md-7" id="mImage" style="background: #000; display: flex; align-items: center; justify-content: center; min-height: 400px;">
                            <!-- 이미지가 여기에 들어감 -->
                        </div>
                        <div class="col-md-5 p-4 bg-white">
                            <div id="mLocation" class="text-muted small mb-2"></div>
                            <div id="mContent" style="font-size: 15px; color: #262626;"></div>
                            <hr>
                            <div class="mt-4" id="modalActions">
                                <!-- 수정/삭제 버튼 등이 들어갈 자리 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>

    <script>
        function openDetail(type, num) {
            // 주소 판별: /story/getDetail 또는 /post/getDetail
            const url = '/' + type + '/getDetail';
            
            $.ajax({
                type: "GET",
                url: url,
                data: { feedNo: num },
                success: function(res) {
                    // 데이터 바인딩
                    $('#mTitle').html('<strong>' + type.toUpperCase() + ' 상세 정보</strong>');
                    $('#mLocation').html('<i class="fas fa-map-marker-alt"></i> ' + (res.feedLocation || '위치 정보 없음'));
                    $('#mContent').html('<strong>User' + res.feedNo + '</strong> ' + res.feedContent);
                    $('#mImage').html('<img src="' + res.feedThumb + '" class="img-fluid">');
                    
                    // 모달 노출
                    $('#detailModal').fadeIn(200);
                    $('body').css('overflow', 'hidden'); // 뒷배경 스크롤 방지
                },
                error: function() {
                    alert("정보를 가져오는데 실패했습니다.");
                }
            });
        }

        function closeModal() {
            $('#detailModal').fadeOut(200);
            $('body').css('overflow', 'auto');
        }

        // 모달 바깥쪽 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target == document.getElementById('detailModal')) {
                closeModal();
            }
        }
    </script>
</body>
</html>