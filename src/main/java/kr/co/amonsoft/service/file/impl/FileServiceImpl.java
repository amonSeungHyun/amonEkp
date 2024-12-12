package kr.co.amonsoft.service.file.impl;

import kr.co.amonsoft.mapper.file.FileMapper;
import kr.co.amonsoft.service.file.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@RequiredArgsConstructor
@Service
public class FileServiceImpl implements FileService {

    @Value("${file.uploadPath}")
    private String uploadDir;

    private final FileMapper fileMapper;


    @Override
    public void uploadFiles(List<MultipartFile> files, Map<String,Object> param) throws IOException {
        Date from = new Date();
        SimpleDateFormat nowDateymd = new SimpleDateFormat("yyyyMMdd");
        String nowymd = nowDateymd.format(from);
        String realPath = uploadDir + "/" + nowymd.substring(0, 4) + '/' + nowymd.substring(4, 6) + '/' + nowymd.substring(nowymd.length() - 2, nowymd.length());
        // 업로드 디렉토리가 존재하지 않으면 생성
        Path uploadPath = Paths.get(realPath);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        List<BigInteger> fileIds = new ArrayList<>();

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                // 파일 확장자와 UUID 기반 파일명 생성
                String fileExtension = getFileExtension(file.getOriginalFilename());
                String uploadFilename = UUID.randomUUID().toString() + (fileExtension.isEmpty() ? "" : "." + fileExtension);

                String filePath = uploadPath + File.separator + uploadFilename;
                Map<String,Object> fileData = new HashMap<>();
                fileData.put("originalFileName", file.getOriginalFilename());
                fileData.put("storedFileName", uploadFilename);
                fileData.put("filePath", filePath);
                fileData.put("fileSize", file.getSize());
                fileData.put("fileType", file.getContentType());
                fileData.put("userId", param.get("userId"));
                fileData.put("referenceId", param.get("referenceId"));
                fileData.put("referenceType", param.get("referenceType"));
                fileMapper.saveFile(fileData);
                BigInteger fileId = (BigInteger)fileData.get("fileId");
                // 파일을 업로드 경로에 저장
                file.transferTo(new File(filePath));
            }
        }
    }

    @Override
    public List<Map<String, Object>>findFileDatas(BigInteger referenceId, String referenceType){
        Map<String,Object> param = new HashMap<>();
        param.put("referenceId", referenceId);
        param.put("referenceType", referenceType);
        return fileMapper.findFileDatas(param);
    }

    @Override
    public Map<String, Object> findFileById(BigInteger fileId) {
        return fileMapper.findFileById(fileId);
    }

    // 파일 확장자 추출 메서드
    private static String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex + 1);
    }
}
