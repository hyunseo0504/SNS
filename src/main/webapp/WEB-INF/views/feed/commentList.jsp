<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<c:forEach items="${commentList}" var="c">
    <div class="d-flex mb-3 align-items-start">
        <div class="me-2">
            <strong style="font-size: 0.9rem;">
                <c:choose>
                    <c:when test="${not empty c.memberDTO and not empty c.memberDTO.userNickname}">
                        ${c.memberDTO.userNickname}
                    </c:when>
                    <c:otherwise>
                        user_${c.userNo}
                    </c:otherwise>
                </c:choose>
            </strong>
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