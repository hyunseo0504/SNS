package com.sns.app.member;

import com.sns.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProfileDTO extends FileDTO{

	private Long userNo;
}
