package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1040Service {

    Map<String,Object> getApprovalId();

    BigInteger insertApprovalRequest(Map<String, Object> param);

	Map<String, Object> findApprovalRequestDetailsByDocId(BigInteger docId);
	
	List<Map<String,Object>> selectReferenceApproval(Map<String, Object> param);
	
	int selectReferenceApprovalCnt();

	List<Map<String, Object>> selectReferenceApprovalView(Map<String, Object> param);

}
