package com.sns.app.feed;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.app.feed.post.PostService;
import com.sns.app.feed.story.StoryService;
import com.sns.app.pager.Pager;


@Controller
@RequestMapping("/feed/*")
public class FeedController {

    @Autowired
    private PostService postService;
    @Autowired
    private StoryService storyService;

    @GetMapping("list")
    public String combinedList(Pager pager, Model model) throws Exception {
        // 1. 스토리 데이터 가져오기 (보통 스토리는 페이징 없이 전체 노출)
        List<FeedDTO> storyList = storyService.list(pager); 
        
        // 2. 포스트 데이터 가져오기 (포스트는 페이징 적용)
        List<FeedDTO> postList = postService.list(pager);

        // 3. 모델에 각각 다른 이름으로 담기
        model.addAttribute("storyList", storyList);
        model.addAttribute("postList", postList);
        
        return "feed/list";
    }
}