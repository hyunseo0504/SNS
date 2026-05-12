package com.sns.app.feed.post;

import com.sns.app.feed.FeedDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PostDTO extends FeedDTO {

	private String postLocation;
	private String postContent;
	private Long postThumb;
	private Long postRef;
	private Long postStep;
	private Long postDepth;

}
