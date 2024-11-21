package kr.co.amonsoft.mapper.file;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface FileMapper {
    void saveFile(Map<String,Object> param);

    List<Map<String,Object>> findFileDatas(Map<String,Object> param);

    Map<String, Object> findFileById(BigInteger fileId);
}
