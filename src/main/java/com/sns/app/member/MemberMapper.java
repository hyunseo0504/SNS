package com.sns.app.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.validation.BindingResult;

@Mapper
public interface MemberMapper {

	public int join(MemberDTO memberDTO) throws Exception;
	
	public int addProfile(ProfileDTO profileDTO) throws Exception;
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception;
	
	public int update(MemberDTO memberDTO) throws Exception;
	
	
}
