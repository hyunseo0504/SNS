package com.sns.app.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	public int join(MemberDTO memberDTO) throws Exception;
	
	public int addProfile(MemberDTO memberDTO) throws Exception;
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception;
}
