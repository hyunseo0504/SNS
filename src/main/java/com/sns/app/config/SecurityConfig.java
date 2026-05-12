package com.sns.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    // 1. 정적 리소스(이미지, CSS, JS)들은 보안 필터를 아예 거치지 않도록 설정
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring()
            .requestMatchers("/css/**", "/js/**", "/images/**", "/img/**", "/vendor/**", "/files/**");
    }

    // 2. HTTP 보안 설정 (403 에러 해결의 핵심)
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            // POST 요청 시 403 Forbidden을 일으키는 CSRF 보호 기능을 끕니다.
            .csrf(csrf -> csrf.disable())
            
            // CORS 설정도 일단 비활성화 (필요 시 나중에 설정)
            .cors(cors -> cors.disable())

            // 모든 페이지 및 API 요청에 대해 인증 없이 접근 가능하도록 허용
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()
            )

            // 기본 로그인 폼 사용 안 함 (필요하면 나중에 추가)
            .formLogin(login -> login.disable())
            
            // HTTP 기본 인증 사용 안 함
            .httpBasic(basic -> basic.disable());

        return http.build();
    }
}