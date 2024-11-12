package kr.co.amonsoft.mapper.com;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface Com7010Mapper {
	List<Map<String, Object>> selectCom7010List(Map<String, Object> param);
	
	List<Map<String, Object>> selectCom7010Code(Map<String, Object> param);

	int  insertCom7010(Map<String, Object> param);

	int  insertCom7010Detail(Map<String, Object> param);

	int deleteCom7010(@Param("codeNumber") String codeNumber);
	
    int deleteCom7010Detail(@Param("codeNumber") String codeNumber, @Param("codeDetailNumber") String codeDetailNumber);

	int selectCom7010Cnt(Map<String, Object> param);
	
}
