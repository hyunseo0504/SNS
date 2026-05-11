package com.sns.app.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class FileDownView extends AbstractView {

    @Value("${app.upload.base}")
    private String base;
    
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        
        // Controller에서 넘겨준 파일 정보와 폴더명(name)을 꺼냄
        FileDTO fileDTO = (FileDTO)model.get("fileDTO");
        String name = (String)model.get("name"); // 예: post, profile 등
        
        // 실제 파일이 저장된 경로 설정
        File file = new File(base, name);
        file = new File(file, fileDTO.getFileName());
        
        // 응답 설정 (한글 인코딩 및 파일 크기)
        response.setCharacterEncoding("UTF-8");
        response.setContentLengthLong(file.length());
        
        // 다운로드 시 파일명 한글 깨짐 방지 처리
        String oriName = fileDTO.getOriName();
        oriName = URLEncoder.encode(oriName, "UTF-8");
        
        // HTTP Header 설정 (다운로드 형식 지정)
        response.setHeader("Content-Disposition", "attachment;filename=\"" + oriName + "\"");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        // 파일 읽기 및 전송 (Stream)
        try (FileInputStream fi = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            FileCopyUtils.copy(fi, os);
            os.flush();
        } catch (Exception e) {
            // 파일 전송 중 오류 발생 처리 로직 필요 시 추가
            throw e;
        }
    }
}