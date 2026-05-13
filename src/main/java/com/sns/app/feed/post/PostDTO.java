package com.sns.app.feed.post;

import com.sns.app.feed.FeedDTO;
import com.sns.app.member.MemberDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PostDTO extends FeedDTO {
	
	private String feedLocation;
	private String feedContent;
	private Long feedRef;
	private Long feedStep;
	private Long feedDepth;
	
	private MemberDTO memberDTO;
	private Long userNo;
	
}
