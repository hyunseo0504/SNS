package com.sns.app.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    // 댓글 리스트
    public List<CommentDTO> getCommentList(CommentDTO commentDTO) throws Exception {
        return commentMapper.getCommentList(commentDTO);
    }

    // 댓글 생성
    public int setCommentCreate(CommentDTO commentDTO) throws Exception {

        if (commentDTO.getCommentThumb() == null) {
            commentDTO.setCommentThumb(0L);
        }
        if (commentDTO.getCommentRef() == null) {
            commentDTO.setCommentRef(0L);
        }
        if (commentDTO.getCommentStep() == null) {
            commentDTO.setCommentStep(0L);
        }
        if (commentDTO.getCommentDepth() == null) {
            commentDTO.setCommentDepth(0L);
        }

        return commentMapper.setCommentCreate(commentDTO);
    }

    // 댓글 삭제
    public int deleteComment(CommentDTO commentDTO) throws Exception {
        return commentMapper.deleteComment(commentDTO);
    }

    // 댓글 수정
    public int updateComment(CommentDTO commentDTO) throws Exception {
        return commentMapper.updateComment(commentDTO);
    }
}