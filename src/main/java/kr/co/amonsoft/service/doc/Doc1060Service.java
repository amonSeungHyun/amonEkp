package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1060Service {

	BigInteger insertTransportExpense(Map<String, Object> param);

	List<Map<String, Object>> findTransportExpenseDetailsByDocId(BigInteger docId);

}
