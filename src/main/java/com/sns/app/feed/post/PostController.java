package com.sns.app.feed.post;

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
import com.sns.app.feed.FeedService;
import com.sns.app.file.FileDTO;
import com.sns.app.pager.Pager;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/post/*")
@CrossOrigin("*")
public class PostController {

	@Autowired
	private PostService postService;

	@Value("${app.feed.post}")
	private String name;

	@ModelAttribute("name")
	public String getName() {
		return this.name;
	}

	// 피드 상세 조회
	@GetMapping("detail")
	public String detail(PostDTO postDTO, Model model) throws Exception {
		FeedDTO feedDTO = postService.detail(postDTO);
		model.addAttribute("dto", feedDTO);
		return "feed/detail";
	}

	// 2. 등록 폼 이동
	@GetMapping("create")
	public String create() throws Exception {
		return "feed/create";
	}

	// 등록 처리
	@PostMapping("create")
	public String create(PostDTO postDTO, @RequestParam("attach") MultipartFile[] attach) throws Exception {
		int result = postService.create(postDTO, attach);
		return "redirect:/feed/list";
	}

	// 피드 수정 폼 이동
	@GetMapping("update")
	public String update(PostDTO postDTO, Model model) throws Exception {
		FeedDTO feedDTO = postService.detail(postDTO);
		model.addAttribute("dto", feedDTO);
		return "feed/update";
	}

	// 피드 수정 처리
	@PostMapping("update")
	public String update(PostDTO postDTO, @RequestParam("attach") MultipartFile[] attach) throws Exception {
		int result = postService.update(postDTO, attach);
		return "redirect:/feed/list";
	}

	// 피드 삭제 처리
	@PostMapping("delete")
	public String delete(PostDTO postDTO) throws Exception {
		int result = postService.delete(postDTO);
		return "redirect:/feed/list";
	}

	// 파일 다운로드 (이미지/첨부파일)
	@GetMapping("down")
	public String fileDown(FileDTO fileDTO, Model model) throws Exception {

		fileDTO = postService.fileDetail(fileDTO);
		model.addAttribute("fileDTO", fileDTO);
		return "fileDownView";
	}

	@GetMapping("getDetail")
	@ResponseBody
	public FeedDTO getDetail(PostDTO postDTO) throws Exception {
		return postService.detail(postDTO);
	}

}