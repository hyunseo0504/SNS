package com.sns.app.feed;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.sns.app.file.FileDTO;
import com.sns.app.pager.Pager;

public interface FeedService {

    public List<FeedDTO> list(Pager pager) throws Exception;

    public FeedDTO detail(FeedDTO feedDTO) throws Exception;

    public int create(FeedDTO feedDTO, MultipartFile[] attach) throws Exception;

    public int update(FeedDTO feedDTO, MultipartFile[] attach) throws Exception;

    public int delete(FeedDTO feedDTO) throws Exception;
    
    public FileDTO fileDetail(FileDTO fileDTO) throws Exception;

    
}