package com.sns.app.feed;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sns.app.feed.post.PostService;
import com.sns.app.feed.story.StoryService;
import com.sns.app.pager.Pager;

@Controller
@RequestMapping("/feed/*")
public class FeedController {

	@Autowired
	private StoryService storyService;

	@Autowired
	private PostService postService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {

		List<FeedDTO> storyList = storyService.list(new Pager());
		List<FeedDTO> postList = postService.list(pager);

		model.addAttribute("storyList", storyList);
		model.addAttribute("postList", postList);

		return "feed/list";

	}
	

	@GetMapping("/detail/{type}/{feedNo}")
	@ResponseBody
	public FeedDTO getFeedDetail(@PathVariable("type") String type, @PathVariable("feedNo") Long feedNo) throws Exception {
		FeedDTO feedDTO = new FeedDTO();
		feedDTO.setFeedNo(feedNo);

		if ("story".equalsIgnoreCase(type)) {
			return storyService.detail(feedDTO);
		}

		if ("post".equalsIgnoreCase(type)) {
			return postService.detail(feedDTO);
		}

		throw new IllegalArgumentException("Unsupported feed type: " + type);
	}

	@GetMapping("/detail/story/user/{userNo}")
	@ResponseBody
	public List<FeedDTO> getStoryListByUser(@PathVariable("userNo") Long userNo) throws Exception {
		return storyService.listByUser(userNo);
	}
}
