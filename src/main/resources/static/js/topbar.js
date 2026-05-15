function loadAlarmList() {
    const container = document.getElementById("alarm-items-container");
    const countBadge = document.getElementById("alarm-count");

    if (!container) return;

    fetch('/push/list') // 아까 만든 @GetMapping("/list") 경로
        .then(res => res.json())
        .then(data => {
            container.innerHTML = ""; // 기존 목록 초기화

            if (!data || data.length === 0) {
                container.innerHTML = '<a class="dropdown-item text-center small text-gray-500">새로운 알림이 없습니다.</a>';
                countBadge.style.display = "none";
                return;
            }

            // 1. 안 읽은 알림(IS_READ == 'N') 개수 계산 및 배지 표시
            const unreadCount = data.filter(item => item.isRead === 'N').length;
            if (unreadCount > 0) {
                countBadge.innerText = unreadCount > 5 ? '5+' : unreadCount;
                countBadge.style.display = "block";
            } else {
                countBadge.style.display = "none";
            }

            // 2. 알림 아이템 생성 (최대 5개)
            data.forEach(item => {
                const isUnread = item.isRead === 'N';
                
                // 알림 타입에 따른 아이콘/색상 설정 (현서님 PushType에 맞춰 수정)
                let iconClass = "fas fa-file-alt";
                let iconBg = "bg-primary";
                
                if(item.pushType === "LIKE") {
                    iconClass = "fas fa-heart";
                    iconBg = "bg-danger";
                } else if(item.pushType === "COMMENT") {
                    iconClass = "fas fa-comment";
                    iconBg = "bg-success";
                }

                const alarmHtml = `
                    <a class="dropdown-item d-flex align-items-center" href="/post/detail?postNo=${item.postNo || ''}" 
                       style="${isUnread ? 'background-color: #f8f9fc;' : ''}">
                        <div class="mr-3">
                            <div class="icon-circle ${iconBg}">
                                <i class="${iconClass} text-white"></i>
                            </div>
                        </div>
                        <div>
                            <div class="small text-gray-500">${item.pushDate}</div>
                            <span class="${isUnread ? 'font-weight-bold' : ''}">${item.pushMsg}</span>
                        </div>
                    </a>
                `;
                container.insertAdjacentHTML('beforeend', alarmHtml);
            });
        })
        .catch(err => console.error("알림 로드 중 오류:", err));
}