package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1050Service {

	BigInteger insertDoc1050(Map<String, Object> param);

	List<Map<String, Object>> selectDoc1050(BigInteger docId);
	
}
