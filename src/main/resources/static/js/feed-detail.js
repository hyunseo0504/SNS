/**
 * SNS Feed 상세 보기 및 스토리 보기 스크립트
 */

// 모달 요소 가져오기
const detailModal = document.getElementById('detailModal');
const modalImageWrap = document.getElementById('mImage').parentElement;
const modalContentWrap = document.querySelector('#detailModal .col-md-5');
const modalImage = document.getElementById('mImage');
const modalLocation = document.getElementById('mLocation');
const modalContent = document.getElementById('mContent');

function resetModalLayout() {
    detailModal.classList.remove('story-mode');
    detailModal.classList.remove('post-mode');
    modalImageWrap.className = 'col-md-7 p-0';
    modalContentWrap.className = 'col-md-5 p-4 bg-white';
    modalContentWrap.style.display = 'block';
    modalLocation.innerHTML = '';
    modalContent.innerHTML = '';
    modalImage.innerHTML = '';
}

async function loadFeedDetail(type, feedNo) {
    const response = await fetch(`/feed/detail/${type}/${feedNo}`);

    if (!response.ok) {
        throw new Error(`상세 정보를 불러오지 못했습니다. (${response.status})`);
    }

    return response.json();
}

// 1. 상세 페이지 로드 함수 (AJAX 활용 예시)
function openDetail(type, feedNo) {
    resetModalLayout();

    // 모달 표시 (Bootstrap 모달 기준 또는 커스텀 CSS)
    detailModal.style.display = 'block';
    document.body.style.overflow = 'hidden'; // 스크롤 방지

    if (type === 'story') {
        renderStoryMode(feedNo).catch(handleModalError);
    } else {
        renderPostMode(feedNo).catch(handleModalError);
    }
}

// 2. 스토리 모드 렌더링 (세로형 전체 화면 강조)
async function renderStoryMode(feedNo) {
    detailModal.classList.add('story-mode');
    modalContentWrap.style.display = 'none';
    modalImageWrap.className = 'col-12 p-0';

    const data = await loadFeedDetail('story', feedNo);
    const fileName = data.list && data.list.length > 0 ? data.list[0].fileName : null;
    const imageSrc = fileName ? `/files/story/${fileName}` : '/img/default_user.avif';

    modalImage.innerHTML = `
        <div class="story-frame">
            <div class="story-user-label"><strong>user${data.userNo}</strong></div>
            <img src="${imageSrc}" alt="story" onerror="this.src='/img/default_user.avif'">
        </div>
    `;
}

// 3. 포스트 모드 렌더링 (인스타 스타일: 왼쪽 사진, 오른쪽 댓글/설명)
async function renderPostMode(feedNo) {
    detailModal.classList.add('post-mode');
    modalContentWrap.style.display = 'block';
    modalImageWrap.className = 'col-md-7 p-0';

    const data = await loadFeedDetail('post', feedNo);
    const fileName = data.list && data.list.length > 0 ? data.list[0].fileName : null;
    const imageSrc = fileName ? `/files/post/${fileName}` : '/img/default_user.avif';

    modalImage.innerHTML = `<img src="${imageSrc}" class="img-fluid">`;

    modalLocation.innerHTML = data.feedLocation
        ? `<i class="fas fa-map-marker-alt"></i> ${data.feedLocation}`
        : '';

    modalContent.innerHTML = `
        <div class="post-detail-owner"><strong>User ${data.userNo}</strong></div>
        <div class="post-detail-text">${(data.feedContent || '').replace(/\n/g, '<br>')}</div>
    `;
}

function handleModalError(error) {
    console.error(error);
    closeModal();
}

// 4. 모달 닫기 이벤트 (바깥 영역 클릭 시)
window.onclick = function(event) {
    if (event.target == detailModal) {
        closeModal();
    }
};

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && detailModal.style.display === 'block') {
        closeModal();
    }
});

function closeModal() {
    detailModal.style.display = 'none';
    document.body.style.overflow = 'auto'; // 스크롤 복구
    
    // 초기화 (다음 번 오픈을 위해)
    resetModalLayout();
}