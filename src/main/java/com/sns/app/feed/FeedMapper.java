package com.sns.app.feed;

import java.util.List;
import com.sns.app.file.FileDTO;
import com.sns.app.pager.Pager;

public interface FeedMapper {

	public Long getCount(Pager pager)throws Exception;
    
    public List<FeedDTO> list(Pager pager) throws Exception;

    // R - Detail
    public FeedDTO detail(FeedDTO feedDTO) throws Exception;

    // C - Create
    public int create(FeedDTO feedDTO) throws Exception;

    // C - Create File
    public int createFile(FileDTO fileDTO) throws Exception;

    // U - Update
    public int update(FeedDTO feedDTO) throws Exception;

    // D - Delete
    public int delete(FeedDTO feedDTO) throws Exception;

    // File Detail
    public FileDTO fileDetail(FileDTO fileDTO) throws Exception;

}