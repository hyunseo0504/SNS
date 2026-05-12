package com.sns.app.feed.story;

import com.sns.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class StoryFileDTO extends FileDTO {
	
	private Long feedNo;

}
