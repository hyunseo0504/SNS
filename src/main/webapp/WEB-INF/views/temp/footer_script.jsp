<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="/member/logout">Logout</a>
			</div>
		</div>
	</div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<script src="/js/sb-admin-2.min.js"></script>

<script src="https://js.pusher.com/8.2.0/pusher.min.js"></script>

<script>
    // 2. Pusher 초기화 (본인 키 값)
    const pusher = new Pusher('ee4b5ef3d42390bab887', {
        cluster: 'ap3'
    });

    // 3. 알림 채널 구독 (전체 알림용 채널명: sns-alarm)
    const channel = pusher.subscribe('sns-alarm');

    // 4. 이벤트 수신 시 동작
    channel.bind('new-post', function(data) {
        // 알림 메시지 표시 (나중에 alert 대신 토스트 UI로 바꾸면 좋습니다)
        if (data.message) {
            alert('🔔 실시간 알림: ' + data.message);
        }
    });
    
    // 연결 확인용 로그 (개발자 도구 F12 콘솔에서 확인 가능)
    pusher.connection.bind('connected', function() {
        console.log('Pusher 연결 성공! 이제 실시간 알림을 받을 수 있습니다.');
    });
</script>