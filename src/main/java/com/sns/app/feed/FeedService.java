package com.sns.app.feed;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

public interface FeedService {
    
    // 피드 목록 조회 (페이징 및 검색 처리)
    public List<FeedDTO> getList() throws Exception;
    
    // 특정 피드 상세 조회
    public FeedDTO getDetail(FeedDTO feedDTO) throws Exception;
    
    // 피드 작성 (C) - 이미지/동영상 등 멀티미디어 첨부 포함
    public int setAdd(FeedDTO feedDTO, MultipartFile[] attach) throws Exception;
    
    // 피드 수정 (U)
    public int setUpdate(FeedDTO feedDTO, MultipartFile[] attach) throws Exception;
    
    // 피드 삭제 (D)
    public int setDelete(FeedDTO feedDTO) throws Exception;

}