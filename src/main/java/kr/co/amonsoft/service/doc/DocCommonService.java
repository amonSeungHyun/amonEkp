package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface DocCommonService {

    List<Map<String,Object>> findDocumentsUnderApproval(String userId);

    List<Map<String,Object>> findPendingApprovalDocuments(String userId);

    List<Map<String, Object>> findCompleteDocuments(String userId);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);


}
