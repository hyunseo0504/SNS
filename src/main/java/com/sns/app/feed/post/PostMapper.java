package com.sns.app.feed.post;

import java.util.List;

import com.sns.app.feed.FeedMapper;
import com.sns.app.file.FileDTO;

public interface PostMapper extends FeedMapper {

	public int fileDelete(FileDTO fileDTO) throws Exception;

	public int fileDeleteFor(List<FileDTO> list) throws Exception;

}