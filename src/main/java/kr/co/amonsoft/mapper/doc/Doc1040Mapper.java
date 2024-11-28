package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1040Mapper {
    
    Map<String,Object> getApprovalId();
    
    void insertApprovalRequest(Map<String, Object> param);
	
	Map<String,Object> findApprovalRequestDetailsByDocId(BigInteger docId);

	List<Map<String,Object>> selectReferenceApproval(Map<String, Object> param);
	
	List<Map<String,Object>> selectReferenceApprovalView(Map<String, Object> param);
	
	int selectReferenceApprovalCnt();

}
