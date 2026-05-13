const detailModal = document.getElementById('detailModal');
const mImageArea = document.getElementById('mImage');
const mInfoArea = document.getElementById('mInfo');
const mOwner = document.getElementById('mOwner');
const mLocation = document.getElementById('mLocation');
const mContent = document.getElementById('mContent');

function resetModalLayout() {
    detailModal.classList.remove('story-mode', 'post-mode');
    mImageArea.className = '';
    mImageArea.style.height = '';
    mInfoArea.style.display = 'flex';
    mImageArea.innerHTML = '';
}

function openDetail(type, feedNo) {
    resetModalLayout();
    detailModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';

    if (type === 'story') {
        renderStory(feedNo);
    } else {
        renderPost(feedNo);
    }
}
// 좋아요 기능
function likePost(feedNo) {
    // 이벤트 전파 방지 (카드를 클릭했을 때 모달이 뜨는 것과 별개로 동작하게 함)
    event.stopPropagation();

    const icon = event.currentTarget.querySelector('i');

    // 클래스 토글 (빈 하트 <-> 채워진 하트)
    if (icon.classList.contains('far')) {
        icon.classList.replace('far', 'fas');
    } else {
        icon.classList.replace('fas', 'far');
    }

    console.log(feedNo + "번 포스트 좋아요 클릭");
}

// 공유하기 기능
function sharePost(feedNo) {
    event.stopPropagation();

    // 임시: 주소창 복사 로직
    const dummy = document.createElement('input');
    const text = window.location.href;

    document.body.appendChild(dummy);
    dummy.value = text;
    dummy.select();
    document.execCommand('copy');
    document.body.removeChild(dummy);

    alert("공유 링크가 클립보드에 복사되었습니다.");
}

// 상단 스토리 클릭 시
async function renderStory(feedNo) {
    detailModal.classList.add('story-mode');
    mInfoArea.style.display = 'none'; // 댓글창 숨김

    // [중요] 부트스트랩 col 클래스를 제거하고 가득 채움
    mImageArea.className = 'h-100 w-100 d-flex justify-content-center';

    try {
        const response = await fetch(`/feed/detail/story/${feedNo}`);
        const data = await response.json();
        const imgPath = data.list?.[0]?.fileName ? `/files/story/${data.list[0].fileName}` : '/img/default_user.avif';

        mImageArea.innerHTML = `
            <div class="story-frame">
                <div class="story-user-label">User ${data.userNo}</div>
                <img src="${imgPath}" onerror="this.src='/img/default_user.avif'">
            </div>
        `;
    } catch (e) { closeModal(); }
}

// 하단 포스트 클릭 시
async function renderPost(feedNo) {
    detailModal.classList.add('post-mode');
    mImageArea.className = 'col-md-7'; // 포스트는 기존 가로 비율 유지

    try {
        const response = await fetch(`/feed/detail/post/${feedNo}`);
        const data = await response.json();
        const imgPath = data.list?.[0]?.fileName ? `/files/post/${data.list[0].fileName}` : '/img/default_user.avif';

        mImageArea.innerHTML = `<img src="${imgPath}" style="width:100%; height:100%; object-fit:contain;">`;
        mOwner.innerText = `User ${data.userNo}`;
        mLocation.innerText = data.feedLocation || '';
        mContent.innerHTML = `<strong>User ${data.userNo}</strong> ${data.feedContent || ''}`;
    } catch (e) { closeModal(); }
}

function closeModal() {
    detailModal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

window.onclick = (e) => { if (e.target == detailModal) closeModal(); };
document.onkeydown = (e) => { if (e.key === 'Escape') closeModal(); };