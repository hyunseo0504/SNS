package com.sns.app.comment;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.sns.app.member.MemberDTO;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/feed/comment/*")
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 1. 댓글 리스트 가져오기 (JS의 getCommentList 대응)
    @GetMapping("list")
    public String getCommentList(Long feedNo, Model model) throws Exception {
        List<CommentDTO> list = commentService.getCommentList(feedNo);
        model.addAttribute("commentList", list);
        
        // 리턴값은 JSP 파일의 경로입니다. 
        // /WEB-INF/views/feed/commentList.jsp 파일이 있어야 합니다.
        return "feed/commentList"; 
    }

    // 2. 댓글 등록 (JS의 bindCommentEvents 대응)
    @PostMapping("create")
    @ResponseBody // 페이지 이동 없이 결과 숫자만 리턴
    public int setCommentCreate(CommentDTO commentDTO, HttpSession session) throws Exception {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        
        // 로그인 체크
        if (memberDTO == null) {
            return -1; // 로그인이 안 된 경우 -1 리턴
        }

        // DTO에 로그인한 유저 번호 세팅
        commentDTO.setUserNo(memberDTO.getUserNo());
        
        // 서비스 실행 (성공 시 1, 실패 시 0 예상)
        return commentService.setCommentCreate(commentDTO);
    }
}