<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${name eq 'story' ? '새 스토리' : '새 포스트'} 작성</title>
<!-- 공통 CSS 임포트 -->
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>

<!-- Cropper.js 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.js"></script>

<style>
    /* 업로드 레이아웃 커스텀 */
    .upload-container { max-width: 550px; margin: 40px auto; }
    .card-upload { border-radius: 12px; border: 1px solid #dbdbdb; overflow: hidden; }
    
    /* 테마별 상단 포인트 */
    .theme-post { border-top: 6px solid #4e73df !important; }
    .theme-story { border-top: 6px solid #e1306c !important; }

    /* 이미지 미리보기 박스 (1:1 고정) */
    #imagePreview {
        width: 100%;
        aspect-ratio: 1 / 1;
        background-color: #fafafa;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        border-bottom: 1px solid #efefef;
        overflow: hidden;
        position: relative;
    }
    
    /* 크로퍼 내부 이미지 설정 */
    #imagePreview img { max-width: 100%; display: block; }
    
    .upload-placeholder { text-align: center; color: #8e8e8e; position: absolute; z-index: 5; }
    .upload-placeholder i { font-size: 3.5rem; margin-bottom: 10px; }
    
    /* 버튼 커스텀 */
    .btn-user { padding: 10px; font-weight: bold; border-radius: 8px; }

    /* 크로퍼 캔버스 배경 (격자무늬 제거용) */
    .cropper-view-box, .cropper-face { border-radius: 0%; }
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
                        
                        <form id="uploadForm" action="/${name}/create" method="post" enctype="multipart/form-data">
                            <div class="card card-upload shadow-sm ${name eq 'story' ? 'theme-story' : 'theme-post'}">
                                
                                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h6 class="m-0 font-weight-bold ${name eq 'story' ? 'text-danger' : 'text-primary'}">
                                        <i class="${name eq 'story' ? 'fas fa-plus-circle' : 'fas fa-camera'}"></i> 
                                        ${name eq 'story' ? '스토리 추가' : '새 포스트 작성'}
                                    </h6>
                                    <a href="/feed/list" class="text-muted"><i class="fas fa-times"></i></a>
                                </div>

                                <!-- 이미지 미리보기 및 크로퍼 영역 -->
                                <div id="imagePreview">
                                    <div class="upload-placeholder" id="placeholder" onclick="document.getElementById('fileInput').click()">
                                        <i class="fas fa-images"></i>
                                        <p>${name eq 'story' ? '스토리 사진을 선택하세요' : '포스트 사진을 선택하세요'}</p>
                                    </div>
                                    <!-- 이미지가 삽입될 곳 -->
                                </div>
                                <input type="file" name="attach" id="fileInput" class="d-none" accept="image/*" required>

                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${name eq 'post'}">
                                            <div class="form-group mb-3">
                                                <label class="small font-weight-bold text-dark">위치 추가</label>
                                                <input type="text" name="feedLocation" class="form-control" placeholder="장소를 입력하세요">
                                            </div>
                                            <div class="form-group mb-4">
                                                <label class="small font-weight-bold text-dark">문구 입력</label>
                                                <textarea name="feedContent" class="form-control" rows="4" placeholder="내용을 입력하세요..."></textarea>
                                            </div>
                                        </c:when>
                                        <c:when test="${name eq 'story'}">
                                            <div class="text-center py-3 mb-3">
                                                <p class="text-muted small">
                                                    <i class="fas fa-info-circle"></i> 스토리는 사진만 업로드됩니다.
                                                </p>
                                            </div>
                                        </c:when>
                                    </c:choose>

                                    <div class="d-grid gap-2">
                                        <button type="submit" id="submitBtn" class="btn btn-block ${name eq 'story' ? 'btn-danger' : 'btn-primary'} btn-user">
                                            ${name eq 'story' ? '스토리 공유하기' : '포스트 게시하기'}
                                        </button>
                                        <a href="/feed/list" class="btn btn-block btn-light btn-user mt-2">취소</a>
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
    let cropper;
    const name = "${name}"; // 서버에서 전달받은 'post' 또는 'story'
    const fileInput = document.getElementById('fileInput');
    const preview = document.getElementById('imagePreview');
    const placeholder = document.getElementById('placeholder');
    const form = document.getElementById('uploadForm');

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                placeholder.style.display = 'none';
                const oldImg = preview.querySelector('img');
                if(oldImg) oldImg.remove();

                const img = document.createElement('img');
                img.id = 'cropTarget';
                img.src = event.target.result;
                preview.appendChild(img);
                
                if(cropper) cropper.destroy();
                
                // 모드에 따라 비율 설정
                const targetRatio = (name === 'story') ? 9 / 16 : 1 / 1;
                
                cropper = new Cropper(img, {
                    aspectRatio: targetRatio, // 여기서 비율이 결정됨!
                    viewMode: 1,
                    autoCropArea: 1,
                    background: false,
                    dragMode: 'move'
                });
            }
            reader.readAsDataURL(file);
        }
    });

    form.addEventListener('submit', function(e) {
        if (!cropper) return;
        e.preventDefault();

        // 스토리일 경우 세로가 더 길게 해상도 조절 (예: 720x1280)
        const canvasOptions = (name === 'story') 
            ? { width: 720, height: 1280 } 
            : { width: 600, height: 600 };

        cropper.getCroppedCanvas(canvasOptions).toBlob(function(blob) {
            const fileName = fileInput.files[0].name;
            const croppedFile = new File([blob], fileName, { type: 'image/jpeg' });
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(croppedFile);
            fileInput.files = dataTransfer.files;
            form.submit();
        }, 'image/jpeg');
    });
    </script>
</body>
</html>