package com.sns.app.feed.story;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.file.FileDTO;
import com.sns.app.pager.Pager;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/story/*")
@CrossOrigin("*")
public class StoryController {

	@Autowired
	private StoryService storyService;

	@Value("${app.feed.story}")
	private String name;

	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}
	
	

	// 2. 등록 폼 이동
	@GetMapping("create")
	public String create() throws Exception {
		return "feed/create";
	}

	// 3. 등록 처리 
	@PostMapping("create")
	public String create(StoryDTO storyDTO, @RequestParam(value="attach", required = false) MultipartFile[] attach) throws Exception {
		int result = storyService.create(storyDTO, attach);

		return "redirect:/feed/list";
	}

	// 4. 상세 조회 
	@GetMapping("detail")
	public String detail(StoryDTO storyDTO, Model model) throws Exception {
		FeedDTO feedDTO = storyService.detail(storyDTO);
		model.addAttribute("dto", feedDTO);
		return "feed/detail";
	}

	// 5. 삭제 처리
	@PostMapping("delete")
	public String delete(StoryDTO storyDTO) throws Exception {
		int result = storyService.delete(storyDTO);
		return "redirect:/feed/list";
	}

	// 6. 파일 다운로드
	@GetMapping("down")
	public String fileDown(StoryFileDTO noticeFileDTO, Model model) throws Exception {
		FileDTO fileDTO = storyService.fileDetail(noticeFileDTO);
		model.addAttribute("fileDTO", fileDTO);
		return "fileDownView";
	}

	// Ajax 전용 상세 데이터 조회 (JSON 리턴)
	@GetMapping("getDetail")
	@ResponseBody // 페이지 이동이 아닌 데이터를 직접 응답바디에 담음
	public FeedDTO getDetail(StoryDTO storyDTO) throws Exception {
	    // 기존 detail 로직 재활용
	    return storyService.detail(storyDTO); 
	}
}