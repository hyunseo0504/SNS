<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<c:if test="${empty commentList}">
    <div class="text-center text-muted py-4">
        <small>아직 댓글이 없습니다. 첫 댓글을 남겨보세요!</small>
    </div>
</c:if>

<c:forEach items="${commentList}" var="c">
    <c:if test="${c.commentDepth eq 0}">
        <div class="mb-3">
            <div class="d-flex align-items-start justify-content-between gap-2">
                <div class="d-flex align-items-start gap-2 flex-grow-1">
                    <div class="flex-grow-1">
                        <strong style="font-size: 0.9rem; display: block;">
                            <c:choose>
                                <c:when test="${not empty c.memberDTO and not empty c.memberDTO.userNickname}">
                                    ${c.memberDTO.userNickname}
                                </c:when>
                                <c:otherwise>
                                    user_${c.userNo}
                                </c:otherwise>
                            </c:choose>
                        </strong>
                        <span style="font-size: 0.9rem;">${c.commentContent}</span>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-1 flex-shrink-0">
                    <button type="button" class="btn btn-sm btn-link text-decoration-none p-0" onclick="likeComment(event, ${c.commentNo}, this)">
                        <i class="${c.likedByMe ? 'fas' : 'far'} fa-heart"></i>
                        <span class="like-count ms-1 small text-muted">${empty c.commentThumb ? 0 : c.commentThumb}</span>
                    </button>
                    <button type="button" class="btn btn-sm btn-link text-decoration-none p-0" onclick="toggleReplyForm(${c.commentNo}, ${c.feedNo}, ${c.commentDepth})">답글</button>
                </div>
            </div>

            <div id="reply_form_${c.commentNo}" class="mt-2 ps-4" style="display:none;">
                <div class="input-group input-group-sm">
                    <input type="text" id="reply_input_${c.commentNo}" class="form-control" placeholder="답글 달기...">
                    <button type="button" class="btn btn-outline-secondary" onclick="submitReplyComment(${c.commentNo}, ${c.feedNo}, ${c.commentDepth})">등록</button>
                </div>
            </div>

            <div class="mt-2 ps-4 border-start" style="border-color: #e9ecef !important;">
                <c:forEach items="${commentList}" var="r">
                    <c:if test="${r.commentDepth eq 1 and r.commentRef eq c.commentNo}">
                        <div class="d-flex align-items-start justify-content-between gap-2 mb-2 ms-2 ps-2 py-1 rounded-2" style="background: #fafafa;">
                            <div class="d-flex align-items-start gap-2 flex-grow-1">
                                <div class="flex-grow-1">
                                    <strong style="font-size: 0.88rem; display: block;">
                                        <span class="text-muted me-1" style="font-size: 0.75rem;">ㄴ</span>
                                        <c:choose>
                                            <c:when test="${not empty r.memberDTO and not empty r.memberDTO.userNickname}">
                                                ${r.memberDTO.userNickname}
                                            </c:when>
                                            <c:otherwise>
                                                user_${r.userNo}
                                            </c:otherwise>
                                        </c:choose>
                                    </strong>
                                    <span style="font-size: 0.88rem;">${r.commentContent}</span>
                                </div>
                            </div>

                            <div class="d-flex align-items-center gap-1 flex-shrink-0">
                                <button type="button" class="btn btn-sm btn-link text-decoration-none p-0" onclick="likeComment(event, ${r.commentNo}, this)">
                                    <i class="${r.likedByMe ? 'fas' : 'far'} fa-heart"></i>
                                    <span class="like-count ms-1 small text-muted">${empty r.commentThumb ? 0 : r.commentThumb}</span>
                                </button>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>
</c:forEach>