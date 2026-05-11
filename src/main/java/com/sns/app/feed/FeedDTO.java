package com.sns.app.feed;

import java.time.LocalDateTime;
import java.util.List;

import com.sns.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class FeedDTO {
	
	private Long feedNo;
	private LocalDateTime feedDate;
	private Long userNo;
	
	private List<FileDTO> list;

}
