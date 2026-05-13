package com.sns.app.comment;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class CommentDTO {
	
	private Long commentNo;
	private Long feedNo;
	private Long userNo;
	private String commentContent;
	private Long commentThumb;
	private LocalDateTime commentDate;
	private Long commentRef;
	private Long commentStep;
	private Long commentDepth;
	
}
