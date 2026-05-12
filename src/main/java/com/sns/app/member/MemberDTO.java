package com.sns.app.member;

import java.time.LocalDate;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {

	private Long userNo;
	private String userId;
	private String userName;
	private String userPw;
	private String userPwCheck;
	private String userEmail;
	private LocalDate userBirth;
	private Boolean userAgr;
	private boolean accountNonExpired;
	
	private boolean accountNonLocked;
	
	private boolean credentialsNonExpired;
	
	private boolean enabled;
	
	private ProfileDTO profileDTO;
	private List<RoleDTO> roles;
	
	
}
