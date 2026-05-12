package com.sns.app.security;

import java.io.IOException;
import java.net.URLEncoder;



import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginFailHandler implements AuthenticationFailureHandler{
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String message = "로그인 실패";
		if(exception instanceof AuthenticationException) {
			message = "계정 만료";
		}
		
		if(exception instanceof LockedException) {
			message = "비밀번호 유효기간 만료";
			
		}
		
		if(exception instanceof DisabledException) {
			message = "휴면 계정";
		}
		
		if(exception instanceof InternalAuthenticationServiceException) {
			//ID가 틀림
			message="ID 틀림";
		}
		
		message=URLEncoder.encode(message,"UTF-8");
		response.sendRedirect("./login?message="+message);
		
	}

}
