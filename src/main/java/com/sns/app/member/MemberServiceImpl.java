package com.sns.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.app.file.FileManager;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public int join(MemberDTO memberDTO) throws Exception {
		// TODO Auto-generated method stub
		return memberMapper.join(memberDTO);
	}
	
	@Override
	public int addProfile(MemberDTO memberDTO) throws Exception {
		// TODO Auto-generated method stub
		return memberMapper.addProfile(memberDTO);
	}
	
	@Override
	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		// TODO Auto-generated method stub
		return memberMapper.detail(memberDTO);
	}
}
