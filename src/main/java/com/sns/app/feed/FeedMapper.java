package com.sns.app.feed;

import java.util.List;
import com.sns.app.file.FileDTO; // 프로젝트 구조에 맞춰 패키지명 확인 필요

public interface FeedMapper {

    // 1. 리스트 조회 (Pager 제외)
    public List<FeedDTO> getList() throws Exception;

    // 2. 피드 상세 조회
    public FeedDTO getDetail(FeedDTO feedDTO) throws Exception;

    // 3. 피드 작성 (C)
    public int setAdd(FeedDTO feedDTO) throws Exception;

    // 4. 피드 첨부파일 등록
    public int setAddFile(FileDTO fileDTO) throws Exception;

    // 5. 피드 수정 (U)
    public int setUpdate(FeedDTO feedDTO) throws Exception;

    // 6. 피드 삭제 (D)
    public int setDelete(FeedDTO feedDTO) throws Exception;

    // 7. 특정 파일 정보 상세 조회
    public FileDTO getFileDetail(FileDTO fileDTO) throws Exception;

}