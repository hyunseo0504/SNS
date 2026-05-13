package com.sns.app.feed.post;

import com.sns.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PostFileDTO extends FileDTO{
	
	private Long feedNo;

	
}
