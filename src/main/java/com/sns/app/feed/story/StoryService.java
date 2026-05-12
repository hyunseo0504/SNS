package com.sns.app.feed.story;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.feed.FeedService; // FeedService 인터페이스가 있다고 가정
import com.sns.app.feed.post.PostFileDTO;
import com.sns.app.file.FileDTO;
import com.sns.app.file.FileManager;
import com.sns.app.pager.Pager;

@Service
@Transactional(rollbackFor = Exception.class)
public class StoryService implements FeedService {

	@Autowired
	private StoryMapper storyMapper;

	@Autowired
	private FileManager fileManager;

	@Value("${app.feed.story}")
	private String name;

	@Override
	public List<FeedDTO> list(Pager pager) throws Exception {

		pager.makePageNum(storyMapper.getCount(pager));
		pager.makeStartNum();

		return storyMapper.list(pager);
	}

	@Override
	public int create(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
		// 1. 피드(스토리) 테이블에 글 추가
		int result = storyMapper.create(feedDTO);

		if (attach == null) {
			return result;
		}

		// 2. 파일을 HDD에 저장
		for (MultipartFile f : attach) {
			if (f.isEmpty()) {
				continue;
			}

			String fileName = fileManager.fileSave(name, f);

			// 3. 파일의 정보들을 DB에 저장
			StoryFileDTO fileDTO = new StoryFileDTO();
            fileDTO.setFeedNo(feedDTO.getFeedNo()); 
            fileDTO.setOriName(f.getOriginalFilename());
            fileDTO.setFileName(fileName);

			result = storyMapper.createFile(fileDTO);
		}

		return result;
	}

	@Override
	public int delete(FeedDTO feedDTO) throws Exception {
		// 1. 파일명 및 정보 조회를 위해 상세 정보 가져오기
		feedDTO = storyMapper.detail(feedDTO);

		// 2. HDD에서 관련 파일 삭제
		if (feedDTO.getList() != null) {
			for (FileDTO fileDTO : feedDTO.getList()) {
				fileManager.fileDelete(name, fileDTO);
			}
		}

		// 3. DB에서 데이터 삭제 (Cascade 설정이 없다면 파일 DB 데이터도 함께 삭제 로직 필요)
		int result = storyMapper.delete(feedDTO);
		return result;
	}

	@Override
	public FileDTO fileDetail(FileDTO fileDTO) throws Exception {
		return storyMapper.fileDetail(fileDTO);
	}

	@Override
	public FeedDTO detail(FeedDTO feedDTO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(FeedDTO feedDTO, MultipartFile[] attach) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



}