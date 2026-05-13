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

	public List<CommentDTO> getCommentList(Long feedNo) throws Exception {
		return commentMapper.getCommentList(feedNo);
	}

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
}