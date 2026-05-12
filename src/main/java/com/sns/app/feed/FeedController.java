package com.sns.app.feed;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.app.feed.post.PostDTO;
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
		
        List<FeedDTO> storyList = storyService.list(pager); 
        List<FeedDTO> postList = postService.list(pager);
        
        model.addAttribute("storyList", storyList);
        model.addAttribute("postList", postList);
        System.out.println(postList);
        System.out.println(storyList);
        
        return "feed/list";
		
	}
}
