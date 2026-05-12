<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${name eq 'story' ? '새 스토리' : '새 포스트'} 작성</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
    .upload-container { max-width: 550px; margin: 40px auto; }
    .card-upload { border-radius: 12px; border: 1px solid #dbdbdb; overflow: hidden; }
    .theme-post { border-top: 6px solid #4e73df !important; }
    .theme-story { border-top: 6px solid #e1306c !important; }

    #imagePreview {
        width: 100%;
        min-height: 450px; /* 스토리는 사진이 중요하므로 높이를 조금 더 확보 */
        background-color: #fafafa;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }
    #imagePreview img { width: 100%; height: auto; display: block; }
    .upload-placeholder { text-align: center; color: #8e8e8e; }
    .upload-placeholder i { font-size: 3.5rem; margin-bottom: 10px; }
</style>
</head>

<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

                <div class="container-fluid">
                    <div class="upload-container">
                        
                        <form action="/${name}/create" method="post" enctype="multipart/form-data">
                            <div class="card card-upload shadow-sm ${name eq 'story' ? 'theme-story' : 'theme-post'}">
                                
                                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h6 class="m-0 font-weight-bold ${name eq 'story' ? 'text-danger' : 'text-primary'}">
                                        <i class="${name eq 'story' ? 'fas fa-plus-circle' : 'fas fa-camera'}"></i> 
                                        ${name eq 'story' ? '스토리 추가' : '새 포스트 작성'}
                                    </h6>
                                    <a href="/feed/list" class="text-muted"><i class="fas fa-times"></i></a>
                                </div>

                                <!-- 이미지 미리보기 영역 -->
                                <div id="imagePreview" onclick="document.getElementById('fileInput').click()">
                                    <div class="upload-placeholder" id="placeholder">
                                        <i class="fas fa-images"></i>
                                        <p>${name eq 'story' ? '스토리에 올릴 사진 선택' : '포스트 사진 선택'}</p>
                                    </div>
                                </div>
                                <input type="file" name="files" id="fileInput" class="d-none" accept="image/*" required>

                                <div class="card-body">
                                    <%-- 포스트일 때만 위치와 설명칸 노출 --%>
                                    <c:if test="${name eq 'post'}">
                                        <div class="form-group mb-3">
                                            <label class="small font-weight-bold text-dark">위치</label>
                                            <input type="text" name="feedLocation" class="form-control" placeholder="위치 정보 입력">
                                        </div>

                                        <div class="form-group mb-4">
                                            <label class="small font-weight-bold text-dark">설명</label>
                                            <textarea name="feedContent" class="form-control" rows="4" placeholder="포스트 내용을 입력하세요..."></textarea>
                                        </div>
                                    </c:if>

                                    <%-- 스토리일 때는 간단한 안내 메시지만 노출 (선택사항) --%>
                                    <c:if test="${name eq 'story'}">
                                        <div class="text-center mb-4">
                                            <p class="small text-muted mb-0">선택한 사진이 바로 스토리에 공유됩니다.</p>
                                            <!-- DB 구조상 Content가 필수라면 hidden으로 빈값 전송 -->
                                            <input type="hidden" name="feedContent" value="Story Post">
                                        </div>
                                    </c:if>

                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-block ${name eq 'story' ? 'btn-danger' : 'btn-primary'} py-2">
                                            <strong>${name eq 'story' ? '지금 공유하기' : '포스트 게시'}</strong>
                                        </button>
                                        <a href="/feed/list" class="btn btn-block btn-light mt-2">취소</a>
                                    </div>
                                </div>

                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>

    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>

    <script>
        document.getElementById('fileInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('imagePreview');
                    const placeholder = document.getElementById('placeholder');
                    placeholder.style.display = 'none';
                    
                    let imgTag = preview.querySelector('img');
                    if(!imgTag) {
                        imgTag = document.createElement('img');
                        preview.appendChild(imgTag);
                    }
                    imgTag.src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>