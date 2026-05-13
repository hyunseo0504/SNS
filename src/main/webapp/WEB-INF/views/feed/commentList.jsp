<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<c:forEach items="${commentList}" var="c">
    <div class="d-flex mb-3 align-items-start">
        <div class="me-2">
            <!-- 유저 번호 대신 닉네임이 DTO에 있다면 그걸 쓰시는 게 좋습니다 -->
            <strong style="font-size: 0.9rem;">user_${c.userNo}</strong>
        </div>
        <div style="font-size: 0.9rem; flex: 1;">
            <span>${c.commentContent}</span>
            <div class="text-muted mt-1" style="font-size: 0.75rem;">
                <!-- 날짜 포맷팅 등 추가 가능 -->
                ${c.commentDate}
            </div>
        </div>
    </div>
</c:forEach>

<c:if test="${empty commentList}">
    <div class="text-center text-muted py-4">
        <small>아직 댓글이 없습니다. 첫 댓글을 남겨보세요!</small>
    </div>
</c:if>