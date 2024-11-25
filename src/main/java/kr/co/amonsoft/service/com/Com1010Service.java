package kr.co.amonsoft.service.com;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Com1010Service {

	List<Map<String, Object>> selectCom1010List(Map<String, Object> param);
	
	int selectCom1010ListCnt(Map<String, Object> param);

	BigInteger insertCom1010(Map<String, Object> param);

	void deleteCom1010(Map<String, Object> param);

}
