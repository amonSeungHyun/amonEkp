package kr.co.amonsoft.service.com;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

public interface Com7010Service {
	
	List<Map<String, Object>> selectCom7010List(Map<String, Object> param) throws Exception;

	List<Map<String, Object>> selectCom7010Code(Map<String, Object> param) throws Exception;

	int insertCom7010(Map<String, Object> param) throws Exception;

	int insertCom7010Detail(Map<String, Object> param) throws Exception;

	void deleteCom7010(List<Map<String, String>> selectedItems) throws Exception;

	int selectCom7010Cnt(Map<String, Object> param);

}
