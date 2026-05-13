const detailModal = document.getElementById('detailModal');
const mImageArea = document.getElementById('mImage');
const mInfoArea = document.getElementById('mInfo');
const mOwner = document.getElementById('mOwner');
const mLocation = document.getElementById('mLocation');
const mContent = document.getElementById('mContent');
let postSlideIndex = 0;
let postSlideCount = 0;
let storySlideIndex = 0;
let storySlideCount = 0;
let storyUserOrder = [];
let currentStoryUserNo = null;

function getCommentList(feedNo) {
    const listArea = document.getElementById("comment_display_list");
    if (!listArea) return;

    fetch(`/feed/comment/list?feedNo=${feedNo}`)
        .then(r => r.text())
        .then(r => {
            listArea.innerHTML = r.trim();
        })
        .catch(e => console.error("댓글 로딩 실패:", e));
}

function bindCommentEvents(feedNo) {
    const commentBtn = document.getElementById("comment_add_btn");
    const commentInput = document.getElementById("comment_contents");

    if (!commentBtn) return;

    commentBtn.onclick = () => {
        const content = commentInput.value.trim();
        if (!content) return;

        let p = new FormData();
        p.append("commentContent", content);
        p.append("feedNo", feedNo);

        fetch("/feed/comment/create", {
            method: "POST",
            body: p
        })
        .then(r => r.text())
        .then(r => {
            if (r.trim() > 0) {
                commentInput.value = "";
                getCommentList(feedNo); // 등록 후 리스트 새로고침
            } else {
                alert("댓글 등록 실패");
            }
        });
    };
}

function getStoryUserOrder() {
    const items = Array.from(document.querySelectorAll('.story-wrapper .story-item'));
    const seen = new Set();
    const ordered = [];

    items.forEach((item) => {
        const userNo = item.dataset.userNo;
        if (!userNo || seen.has(userNo)) return;
        seen.add(userNo);
        ordered.push(userNo);
    });

    return ordered;
}

function hasAdjacentStoryUser(step) {
    if (!currentStoryUserNo || storyUserOrder.length === 0) return false;
    const currentIndex = storyUserOrder.findIndex((userNo) => String(userNo) === String(currentStoryUserNo));
    if (currentIndex < 0) return false;

    const targetIndex = currentIndex + step;
    return targetIndex >= 0 && targetIndex < storyUserOrder.length;
}

function getAdjacentStoryUser(step) {
    if (!currentStoryUserNo || storyUserOrder.length === 0) return null;
    const currentIndex = storyUserOrder.findIndex((userNo) => String(userNo) === String(currentStoryUserNo));
    if (currentIndex < 0) return null;

    const targetIndex = currentIndex + step;
    if (targetIndex < 0 || targetIndex >= storyUserOrder.length) return null;
    return storyUserOrder[targetIndex];
}

function renderStorySlide(index) {
    const track = document.getElementById('storyCarouselTrack');
    const counter = document.getElementById('storyCarouselCounter');
    if (!track) return;

    storySlideIndex = Math.max(0, Math.min(index, storySlideCount - 1));
    track.style.transform = `translateX(-${storySlideIndex * 100}%)`;

    if (counter) {
        counter.innerText = `${storySlideIndex + 1} / ${storySlideCount}`;
    }

    const prevBtn = document.getElementById('storyCarouselPrev');
    const nextBtn = document.getElementById('storyCarouselNext');
    if (prevBtn) prevBtn.disabled = storySlideIndex === 0 && !hasAdjacentStoryUser(-1);
    if (nextBtn) nextBtn.disabled = storySlideIndex >= storySlideCount - 1 && !hasAdjacentStoryUser(1);
}

async function loadStoryByUser(userNo, selectedFeedNo, stepDirection = 1) {
    currentStoryUserNo = String(userNo);

    const response = await fetch(`/feed/detail/story/user/${userNo}`);
    const storyList = await response.json();
    const stories = Array.isArray(storyList) ? storyList : [];

    if (stories.length === 0) return false;

    storySlideCount = stories.length;

    if (selectedFeedNo) {
        const selectedIndex = stories.findIndex((story) => String(story.feedNo) === String(selectedFeedNo));
        storySlideIndex = selectedIndex >= 0 ? selectedIndex : 0;
    } else {
        storySlideIndex = stepDirection < 0 ? stories.length - 1 : 0;
    }

    const slides = stories.map((story) => {
        const imgPath = story.list?.[0]?.fileName
            ? `/files/story/${story.list[0].fileName}`
            : '/img/default_user.avif';
        const ownerName = story.memberDTO?.userNickname || story.memberDTO?.userNo || '';

        return `
            <div class="story-carousel-slide">
                <div class="story-frame">
                    <div class="story-user-label">${ownerName}</div>
                    <img src="${imgPath}" onerror="this.src='/img/default_user.avif'">
                </div>
            </div>
        `;
    }).join('');

    mImageArea.innerHTML = `
        <div class="story-carousel">
            <button type="button" class="story-carousel-btn prev" id="storyCarouselPrev" aria-label="Previous story">‹</button>
            <div class="story-carousel-viewport">
                <div class="story-carousel-track" id="storyCarouselTrack">${slides}</div>
            </div>
            <button type="button" class="story-carousel-btn next" id="storyCarouselNext" aria-label="Next story">›</button>
            <div class="story-carousel-counter" id="storyCarouselCounter"></div>
        </div>
    `;

    const prevBtn = document.getElementById('storyCarouselPrev');
    const nextBtn = document.getElementById('storyCarouselNext');

    if (prevBtn) {
        prevBtn.onclick = async () => {
            if (storySlideIndex > 0) {
                renderStorySlide(storySlideIndex - 1);
                return;
            }

            const prevUserNo = getAdjacentStoryUser(-1);
            if (!prevUserNo) return;
            await loadStoryByUser(prevUserNo, null, -1);
        };
    }

    if (nextBtn) {
        nextBtn.onclick = async () => {
            if (storySlideIndex < storySlideCount - 1) {
                renderStorySlide(storySlideIndex + 1);
                return;
            }

            const nextUserNo = getAdjacentStoryUser(1);
            if (!nextUserNo) return;
            await loadStoryByUser(nextUserNo, null, 1);
        };
    }

    renderStorySlide(storySlideIndex);
    return true;
}

function renderPostSlide(index) {
    const track = document.getElementById('postCarouselTrack');
    const counter = document.getElementById('postCarouselCounter');
    if (!track) return;

    postSlideIndex = Math.max(0, Math.min(index, postSlideCount - 1));
    track.style.transform = `translateX(-${postSlideIndex * 100}%)`;

    if (counter) {
        counter.innerText = `${postSlideIndex + 1} / ${postSlideCount}`;
    }

    const prevBtn = document.getElementById('postCarouselPrev');
    const nextBtn = document.getElementById('postCarouselNext');
    if (prevBtn) prevBtn.disabled = postSlideIndex === 0;
    if (nextBtn) nextBtn.disabled = postSlideIndex >= postSlideCount - 1;
}

function resetModalLayout() {
    detailModal.classList.remove('story-mode', 'post-mode');
    mImageArea.className = '';
    mImageArea.style.height = '';
    mInfoArea.style.display = 'flex';
    mImageArea.innerHTML = '';
}

function openDetail(type, feedNo, userNo) {
    resetModalLayout();
    detailModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';

    if (type === 'story') {
        renderStory(feedNo, userNo);
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
async function renderStory(feedNo, userNo) {
    detailModal.classList.add('story-mode');
    mInfoArea.style.display = 'none'; // 댓글창 숨김

    // [중요] 부트스트랩 col 클래스를 제거하고 가득 채움
    mImageArea.className = 'h-100 w-100 d-flex justify-content-center';

    try {
        if (userNo) {
            storyUserOrder = getStoryUserOrder();
            const loaded = await loadStoryByUser(userNo, feedNo, 1);
            if (!loaded) {
                closeModal();
            }
            return;
        }

        const response = await fetch(`/feed/detail/story/${feedNo}`);
        const data = await response.json();
        const imgPath = data.list?.[0]?.fileName ? `/files/story/${data.list[0].fileName}` : '/img/default_user.avif';
        const ownerName = data.memberDTO?.userNickname || data.memberDTO?.userNo || '';

        mImageArea.innerHTML = `
            <div class="story-frame">
                <div class="story-user-label">${ownerName}</div>
                <img src="${imgPath}" onerror="this.src='/img/default_user.avif'">
            </div>
        `;
    } catch (e) { closeModal(); }
}

// 하단 포스트 클릭 시
async function renderPost(feedNo) {
    detailModal.classList.add('post-mode');
    mImageArea.className = 'col-md-7';

    try {
        const response = await fetch(`/feed/detail/post/${feedNo}`);
        const data = await response.json();
        const ownerName = data.memberDTO?.userNickname || data.memberDTO?.userNo || '';

        // 이미지 슬라이더 생성 부분
        const images = data.list && data.list.length > 0
            ? data.list.map((fileDTO) => `
                <div class="post-carousel-slide">
                    <img src="/files/post/${fileDTO.fileName}" class="post-detail-img" onerror="this.src='/img/default_user.avif'">
                </div>
            `).join('')
            : `<div class="post-carousel-slide"><img src="/img/default_user.avif" class="post-detail-img"></div>`;

        postSlideCount = data.list && data.list.length > 0 ? data.list.length : 1;
        postSlideIndex = 0;

        mImageArea.innerHTML = `
            <div class="post-gallery">
                <button type="button" class="post-carousel-btn prev" id="postCarouselPrev">‹</button>
                <div class="post-carousel-viewport">
                    <div class="post-carousel-track" id="postCarouselTrack">${images}</div>
                </div>
                <button type="button" class="post-carousel-btn next" id="postCarouselNext">›</button>
                <div class="post-carousel-counter" id="postCarouselCounter"></div>
            </div>`;

        // 정보창(mInfoArea) 구조 재구성: 상단 유저정보 + 중간 댓글리스트 + 하단 입력창
        mInfoArea.innerHTML = `
            <div class="p-3 border-bottom w-100">
                <strong id="mOwner">${ownerName}</strong> 
                <small id="mLocation" class="text-muted d-block">${data.feedLocation || ''}</small>
            </div>
            <div id="comment_scroll_area" style="flex-grow: 1; overflow-y: auto; width: 100%; padding: 15px;">
                <div id="mContent" class="mb-3"><strong>${ownerName}</strong> ${data.feedContent || ''}</div>
                <hr>
                <div id="comment_display_list"></div> <!-- 댓글이 출력될 장소 -->
            </div>
            <div class="px-3 py-2 border-top d-flex align-items-center" style="gap: 20px;">
                <div class="action-item" style="cursor: pointer;" onclick="likePost('${feedNo}')">
                    <i class="far fa-heart fa-lg"></i>
                </div>
                <div class="action-item" style="cursor: pointer;" onclick="sharePost('${feedNo}')">
                    <i class="far fa-paper-plane fa-lg"></i>
                </div>
            </div>
            <div class="p-3 border-top w-100">
                <div class="input-group">
                    <input type="text" id="comment_contents" class="form-control border-0" placeholder="댓글 달기...">
                    <button class="btn btn-link text-decoration-none" type="button" id="comment_add_btn">게시</button>
                </div>
            </div>
        `;

        // 슬라이더 이벤트 연결
        const prevBtn = document.getElementById('postCarouselPrev');
        const nextBtn = document.getElementById('postCarouselNext');
        if (prevBtn) prevBtn.onclick = () => renderPostSlide(postSlideIndex - 1);
        if (nextBtn) nextBtn.onclick = () => renderPostSlide(postSlideIndex + 1);
        renderPostSlide(0);

        // 댓글 관련 로직 실행
        getCommentList(feedNo);
        bindCommentEvents(feedNo);

    } catch (e) { 
        console.error(e);
        closeModal(); 
    }
}

function closeModal() {
    detailModal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

window.onclick = (e) => { if (e.target == detailModal) closeModal(); };
document.onkeydown = (e) => { if (e.key === 'Escape') closeModal(); };