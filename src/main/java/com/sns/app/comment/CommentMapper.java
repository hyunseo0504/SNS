package com.sns.app.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommentMapper {

	public List<CommentDTO> getCommentList(@Param("feedNo") Long feedNo) throws Exception;

	public int setCommentCreate(CommentDTO commentDTO) throws Exception;
}