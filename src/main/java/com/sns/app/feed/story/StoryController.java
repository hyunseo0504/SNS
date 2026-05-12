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
import org.springframework.web.multipart.MultipartFile;

import com.sns.app.feed.FeedDTO;
import com.sns.app.file.FileDTO;
import com.sns.app.pager.Pager;

import jakarta.servlet.http.HttpSession;
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

	// JSP 등 뷰에서 공통으로 사용할 이름 설정
	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}

	// 리스트 조회
	@GetMapping("list")
	public String list(Pager pager, Model model)throws Exception{
		
		List<FeedDTO> ar = storyService.list(pager);
		
		model.addAttribute("list", ar);
		
		return "board/list";
	}

	// 등록 폼 이동
	@GetMapping("create")
	public String create() throws Exception {
		return "feed/create";
	}

	// 등록 처리
	@PostMapping("create")
	public String create(StoryDTO storyDTO, @RequestParam(value="attach", required = false) MultipartFile [] attach, Model model)throws Exception{
		int result = storyService.create(storyDTO, attach);
		if(result>0) {
			model.addAttribute("result", "글 등록 성공");
			model.addAttribute("url", "./list");
		}
		
		
		return "commons/result";
	}

//	// 삭제 처리
//	@PostMapping("delete")
//	public String delete(StoryDTO storyDTO, HttpSession session, Model model) throws Exception {
//		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
//		FeedDTO feedDTO = storyService.detail(storyDTO);
//		if (feedDTO.getUserNo().equals(memberDTO.getUserNo())) {
//			int result = storyService.delete(storyDTO);
//			return "redirect:./list";
//
//		} else {
//			model.addAttribute("result", "작성자가 아님");
//			model.addAttribute("url", "./list");
//			return "commons/result";
//		}
//
//	}
	@GetMapping("down")
	public String fileDown(StoryFileDTO noticeFileDTO, Model model)throws Exception{
		
		FileDTO fileDTO = storyService.fileDetail(noticeFileDTO);
		
		model.addAttribute("fileDTO", fileDTO);
		
		return "fileDownView";
	}
	
}