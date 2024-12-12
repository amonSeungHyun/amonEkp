package kr.co.amonsoft.service.file;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface FileService {

    void uploadFiles(List<MultipartFile> files, Map<String,Object> param) throws IOException;

    List<Map<String,Object>> findFileDatas(BigInteger referenceId, String referenceType);

    Map<String, Object> findFileById(BigInteger fileId);

}
