package kr.co.amonsoft.controller.file;

import kr.co.amonsoft.service.file.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@RequiredArgsConstructor
@RestController
public class FileController {

    private final FileService fileService;

    /**
     * 파일 다운로드
     */
    @PostMapping("/file/download")
    public ResponseEntity<Resource> downloadFile(@RequestParam BigInteger fileId) {
        try {
            // 파일 정보 조회
            Map<String, Object> fileDatas = fileService.findFileById(fileId);

            // 파일 리소스 생성
            Path filePath = Paths.get((String) fileDatas.get("filePath")).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }

            // Content-Disposition 헤더 설정
            String contentDisposition = "attachment; filename=\"" + URLEncoder.encode((String) fileDatas.get("originalFileName"), "UTF-8") + "\"";

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition)
                    .body(resource);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
