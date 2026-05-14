package com.sns.app.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    // 댓글 리스트
    public List<CommentDTO> getCommentList(CommentDTO commentDTO) throws Exception {
        return commentMapper.getCommentList(commentDTO);
    }

    public CommentDTO toggleThumb(CommentDTO commentDTO) throws Exception {
        Long thumbCount = commentMapper.countThumbByUser(commentDTO);
        if (thumbCount != null && thumbCount > 0) {
            commentMapper.deleteThumb(commentDTO);
        } else {
            commentMapper.insertThumb(commentDTO);
        }

        commentMapper.syncThumbCount(commentDTO);
        return commentMapper.getCommentDetail(commentDTO);
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