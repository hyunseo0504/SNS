package com.sns.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import com.sns.app.member.MemberServiceImpl;
import com.sns.app.security.LoginFailHandler;
import com.sns.app.security.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private LoginSuccessHandler successHandler;
	
	@Autowired
	private LoginFailHandler failHandler;
	
	@Autowired
	private MemberServiceImpl memberServiceImpl;
}
