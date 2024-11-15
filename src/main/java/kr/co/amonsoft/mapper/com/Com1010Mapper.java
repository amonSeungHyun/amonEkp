package kr.co.amonsoft.mapper.com;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface Com1010Mapper {
	List<Map<String, Object>> selectCom1010List(Map<String, Object> param);
	
	int selectCom1010ListCnt(Map<String, Object> param);

	void insertCom1010(Map<String, Object> param);

	void deleteCom1010(Map<String, Object> param);
}
