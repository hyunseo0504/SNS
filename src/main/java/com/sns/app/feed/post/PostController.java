package com.sns.app.feed.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.feed.FeedService;
import com.sns.app.file.FileDTO;

@Controller
@RequestMapping("/post/*")
public class PostController {
	
	@Autowired
	private FeedService feedService;
	
	@Value("${app.feed.post}") // application.properties 등에 설정된 값
	private String name;
	
	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}
	
	// 피드 목록 조회 (Pager 제외)
	@GetMapping("list")
	public String getList(Model model) throws Exception {
		List<FeedDTO> ar = feedService.getList();
		model.addAttribute("list", ar);
		return "feed/list";
	}
	
	// 피드 상세 조회
	@GetMapping("detail")
	public String getDetail(FeedDTO feedDTO, Model model) throws Exception {
		feedDTO = feedService.getDetail(feedDTO);
		model.addAttribute("dto", feedDTO);
		return "feed/detail";
	}
	
	// 피드 작성 폼 이동
	@GetMapping("add")
	public String setAdd() throws Exception {
		return "feed/add";
	}

	// 피드 작성 처리
	@PostMapping("add")
	public String setAdd(FeedDTO feedDTO, @RequestParam("attach") MultipartFile[] attach) throws Exception {
		int result = feedService.setAdd(feedDTO, attach);
		return "redirect:./list";
	}
	
	// 피드 수정 폼 이동
	@GetMapping("update")
	public String setUpdate(FeedDTO feedDTO, Model model) throws Exception {
		feedDTO = feedService.getDetail(feedDTO);
		model.addAttribute("dto", feedDTO);
		return "feed/update";
	}
	
	// 피드 수정 처리
	@PostMapping("update")
	public String setUpdate(FeedDTO feedDTO, @RequestParam("attach") MultipartFile[] attach) throws Exception {
		int result = feedService.setUpdate(feedDTO, attach);
		return "redirect:./list";
	}
	
	// 피드 삭제 처리
	@PostMapping("delete")
	public String setDelete(FeedDTO feedDTO) throws Exception {
		int result = feedService.setDelete(feedDTO);
		return "redirect:./list";
	}
	
	// 파일 다운로드 (이미지/첨부파일)
	@GetMapping("down")
	public String fileDown(FileDTO fileDTO, Model model) throws Exception {
		// FeedService에서 fileDetail 기능을 구현했다고 가정
		// fileDTO = feedService.fileDetail(fileDTO); 
		model.addAttribute("fileDTO", fileDTO);
		return "fileDownView";
	}

}