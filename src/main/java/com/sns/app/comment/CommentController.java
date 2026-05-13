package com.sns.app.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sns.app.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment/*")
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 댓글 리스트
    @GetMapping("list")
    public void list(CommentDTO commentDTO, Model model) throws Exception {

        List<CommentDTO> ar = commentService.getCommentList(commentDTO);

        model.addAttribute("commentList", ar);
    }

    // 댓글 생성
    @PostMapping("create")
    @ResponseBody
    public int create(CommentDTO commentDTO, Model model) throws Exception {

    	Authentication auth =
                SecurityContextHolder.getContext().getAuthentication();

        MemberDTO memberDTO = (MemberDTO) auth.getPrincipal();

        commentDTO.setUserNo(memberDTO.getUserNo());

        int result = commentService.setCommentCreate(commentDTO);

        model.addAttribute("result", result);

        return result;
    }

    // 댓글 삭제
    @PostMapping("delete")
    @ResponseBody
    public int delete(CommentDTO commentDTO, Model model) throws Exception {

        int result = commentService.deleteComment(commentDTO);

        model.addAttribute("result", result);

        return result;
    }

    // 댓글 수정
    @PostMapping("update")
    @ResponseBody
    public int update(CommentDTO commentDTO, Model model) throws Exception {

        int result = commentService.updateComment(commentDTO);

        model.addAttribute("result", result);

        return result;
    }
}