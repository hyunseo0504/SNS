package com.sns.app.feed.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.feed.FeedMapper;
import com.sns.app.feed.FeedService;
import com.sns.app.file.FileDTO;
import com.sns.app.file.FileManager;

@Service
public class PostService implements FeedService {

    @Autowired
    private PostMapper PostMapper;

    @Autowired
    private FileManager fileManager;

    @Value("${app.feed.post}")
    private String name;

    @Override
    public List<FeedDTO> getList() throws Exception {
        // Pager 로직 제외하고 전체 리스트 반환
        return PostMapper.getList();
    }

    @Override
    public FeedDTO getDetail(FeedDTO feedDTO) throws Exception {
        return PostMapper.getDetail(feedDTO);
    }

    @Override
    public int setAdd(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
        // 1. 피드 글 등록
        int result = PostMapper.setAdd(feedDTO);

        if (attach == null) {
            return result;
        }

        // 2. 파일 저장 루프
        for (MultipartFile f : attach) {
            if (f.isEmpty()) {
                continue;
            }

            // HDD에 저장
            String fileName = fileManager.fileSave(name, f);

            // 3. 파일 정보를 DB(FileDTO 관련 테이블)에 저장
            PostFileDTO fileDTO = new PostFileDTO();
            fileDTO.setFeedNo(feedDTO.getFeedNo()); 
            fileDTO.setOriName(f.getOriginalFilename());
            fileDTO.setFileName(fileName);

            result = PostMapper.setAddFile(fileDTO);
        }

        return result;
    }

    @Override
    public int setUpdate(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
        // 게시글 내용 수정 (파일 수정 로직은 요구사항에 따라 추가 가능)
        return PostMapper.setUpdate(feedDTO);
    }

    @Override
    public int setDelete(FeedDTO feedDTO) throws Exception {
        // 1. 상세 정보를 가져와 첨부파일 목록 확인
        feedDTO = PostMapper.getDetail(feedDTO);

        if (feedDTO.getList() != null) {
            // 2. HDD에서 파일 삭제
            for (FileDTO fileDTO : feedDTO.getList()) {
                fileManager.fileDelete(name, fileDTO);
            }
            // 3. DB에서 파일 정보들 일괄 삭제 (Mapper에 해당 메서드 필요)
            // feedMapper.setFileDeleteAll(feedDTO); 
        }

        // 4. DB에서 피드 삭제
        return PostMapper.setDelete(feedDTO);
    }
}