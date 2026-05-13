package com.sns.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl memberServiceImpl;
	
	@GetMapping("mypage")
	public void mypage(HttpSession session, Model model) throws Exception{}
	
	@GetMapping("update")
	public void update(HttpSession session, Model model) throws Exception{
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		model.addAttribute("memberDTO", memberDTO);
	}
	
	@PostMapping("update")
	public String update(@Validated(GroupUpdate.class) MemberDTO memberDTO, BindingResult bindingResult, HttpSession session, Model model) throws Exception{
		
		if(bindingResult.hasErrors()) {
			return "member/update";
		}
		
		MemberDTO s = (MemberDTO)session.getAttribute("member");
		memberDTO.setUserId(s.getUserId());
		
		int result = memberServiceImpl.update(memberDTO);
		if(result>0) {
			s = memberServiceImpl.detail(s);
			session.setAttribute("member", s);
		}
		return "rediect:/";
	}
	
	@GetMapping("join")
	public void join(@ModelAttribute MemberDTO memberDTO) throws Exception{}
	
	@PostMapping("join")
	public String join(@Validated(GroupAdd.class) MemberDTO memberDTO, BindingResult bindingResult, @RequestParam("attach") MultipartFile attach) throws Exception{
		if(memberServiceImpl.doubleCheck(memberDTO, bindingResult)) {
			return "member/join";
		}
		int result = memberServiceImpl.join(memberDTO, attach);
		
		return "redirect:/feed/list";
	}
	
	@GetMapping("idCheck")
	public String idCheck(MemberDTO memberDTO, Model model) throws Exception{
		memberDTO = memberServiceImpl.idCheck(memberDTO);
		int result = 0;
		if(memberDTO == null) {
			result=1;
		}
		model.addAttribute("result",result);
		
		return "commons/ajaxResult";
	}
	
	@GetMapping("login")
	public void login() throws Exception{}
	
	
	
	

}
