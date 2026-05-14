package com.sns.app.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {

    // 댓글 리스트
    public List<CommentDTO> getCommentList(CommentDTO commentDTO) throws Exception;

    // 댓글 생성
    public int setCommentCreate(CommentDTO commentDTO) throws Exception;

    // 댓글 삭제
    public int deleteComment(CommentDTO commentDTO) throws Exception;

    // 댓글 수정
    public int updateComment(CommentDTO commentDTO) throws Exception;

    public Long countThumbByUser(CommentDTO commentDTO) throws Exception;

    public int insertThumb(CommentDTO commentDTO) throws Exception;

    public int deleteThumb(CommentDTO commentDTO) throws Exception;

    public int syncThumbCount(CommentDTO commentDTO) throws Exception;

    public CommentDTO getCommentDetail(CommentDTO commentDTO) throws Exception;
}