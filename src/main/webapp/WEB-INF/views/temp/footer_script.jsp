<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<a class="scroll-to-top rounded" href="#page-top"> 
    <i class="fas fa-angle-up"></i>
</a>

<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="/member/logout">Logout</a>
            </div>
        </div>
    </div>
</div>

<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<script src="/js/sb-admin-2.min.js"></script>

<script src="https://js.pusher.com/8.2.0/pusher.min.js"></script>

<sec:authorize access="isAuthenticated()">
    <script>
        (function() {
            // 1. Spring Security Principal에서 안전하게 번호 추출
            var rawUserNo = "<sec:authentication property='principal.userNo' />";

            console.log("==============================");
            console.log("실시간 알림 시스템 가동 (UserNo: " + rawUserNo + ")");

            if (rawUserNo && rawUserNo !== "" && rawUserNo !== "anonymousUser") {
                try {
                    const pusher = new Pusher('ee4b5ef3d42390bab887', {
                        cluster: 'ap3'
                    });

                    // 2. '내 번호'가 붙은 전용 채널 구독
                    const myChannelName = 'sns-alarm-' + rawUserNo;
                    const channel = pusher.subscribe(myChannelName);

                    console.log("구독 채널:", myChannelName);

                    channel.bind('new-post', function(data) {
                        if (data.message) {
                            alert('🔔 실시간 알림: ' + data.message);
                            
                            // 만약 push.js의 목록 갱신 함수가 있다면 호출
                            if (typeof loadAlarmList === "function") {
                                loadAlarmList();
                            }
                        }
                    });

                    pusher.connection.bind('connected', function() {
                        console.log('Pusher 연결 성공!');
                    });
                    
                } catch (err) {
                    console.error("Pusher 초기화 중 오류 발생:", err);
                }
            }
            console.log("==============================");
        })();
    </script>
</sec:authorize>

<sec:authorize access="isAnonymous()">
    <script>
        console.log("로그인하지 않은 상태이므로 알림 구독을 생략합니다.");
    </script>
</sec:authorize>