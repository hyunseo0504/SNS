package com.sns.app.member;

public interface MemberService {
	
	public int join(MemberDTO memberDTO) throws Exception;
	
	public int addProfile(MemberDTO memberDTO) throws Exception;
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception;

}
