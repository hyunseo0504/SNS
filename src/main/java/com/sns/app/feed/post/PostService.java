package com.sns.app.feed.post;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.feed.FeedService;
import com.sns.app.file.FileDTO;
import com.sns.app.file.FileManager;
import com.sns.app.pager.Pager;

@Service
@Transactional(rollbackFor = Exception.class)
public class PostService implements FeedService {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private FileManager fileManager;

    @Value("${app.feed.post}")
    private String name;

    @Override
    public List<FeedDTO> list(Pager pager) throws Exception {

        pager.makePageNum(postMapper.getCount(pager));
        
        pager.makeStartNum();
        
        return postMapper.list(pager);
    }
    
    public List<FeedDTO> myList(Pager pager) throws Exception {
    	
        pager.makePageNum(postMapper.getMyCount(pager));
        
        pager.makeStartNum();
        
        return postMapper.myList(pager);
    }
    
    public List<FeedDTO> searchList(Pager pager) throws Exception {
		pager.makePageNum(postMapper.getCount(pager));
		pager.makeStartNum();
		return postMapper.searchList(pager);
	}

    @Override
    public FeedDTO detail(FeedDTO feedDTO) throws Exception {
        return postMapper.detail(feedDTO);
    }

    @Transactional
    public FeedDTO toggleThumb(FeedDTO feedDTO) throws Exception {
        Long thumbCount = postMapper.countThumbByUser(feedDTO);
        if (thumbCount != null && thumbCount > 0) {
            postMapper.deleteThumb(feedDTO);
        } else {
            postMapper.insertThumb(feedDTO);
        }

        postMapper.syncThumbCount(feedDTO);
        return postMapper.detail(feedDTO);
    }

    @Override
    public int create(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
        int result = postMapper.create(feedDTO);

        if (attach == null) {
            return result;
        }

        for (MultipartFile f : attach) {
            if (f.isEmpty()) {
            	continue;
            }

            String fileName = fileManager.fileSave(name, f);

            PostFileDTO fileDTO = new PostFileDTO();
            fileDTO.setFeedNo(feedDTO.getFeedNo()); 
            fileDTO.setOriName(f.getOriginalFilename());
            fileDTO.setFileName(fileName);

            result = postMapper.createFile(fileDTO);
        }

        return result;
    }

    @Override
    public int update(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
        return postMapper.update(feedDTO);
    }

    @Override
    public int delete(FeedDTO feedDTO) throws Exception {
        // HDD 파일 삭제를 위해 상세 정보 조회
        feedDTO = postMapper.detail(feedDTO);

        if (feedDTO.getList() != null) {
            for (FileDTO fileDTO : feedDTO.getList()) {
                fileManager.fileDelete(name, fileDTO);
            }
        }

        return postMapper.delete(feedDTO);
    }

    @Override
    public FileDTO fileDetail(FileDTO fileDTO) throws Exception {
        return postMapper.fileDetail(fileDTO);
    }


}