package kr.co.amonsoft.mapper.com;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface Com1020Mapper {
	
	Map<String, Object> selectCom1020(Map<String, Object> param);
	
	void updateCom1020(Map<String, Object> param);
	
}
