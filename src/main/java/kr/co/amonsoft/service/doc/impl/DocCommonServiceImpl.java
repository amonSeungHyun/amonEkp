package kr.co.amonsoft.service.doc.impl;

import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import kr.co.amonsoft.service.doc.DocCommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class DocCommonServiceImpl implements DocCommonService {

    private final DocCommonMapper docCommonMapper;

    @Override
    public int findDocumentsUnderApprovalTotalCountByUserId(Map<String,Object> param) {
        return docCommonMapper.findDocumentsUnderApprovalTotalCountByUserId(param);
    }

    @Override
    public List<Map<String, Object>> findDocumentsUnderApproval(Map<String, Object> param) {
             return docCommonMapper.findDocumentsUnderApproval(param);
    }

    @Override
    public List<Map<String, Object>> findPendingApprovalDocuments(Map<String, Object> param) {
        return docCommonMapper.findPendingApprovalDocuments(param);
    }

    @Override
    public List<Map<String, Object>> findCompleteDocuments(Map<String,Object> param) {
        return docCommonMapper.findCompleteDocuments(param);
    }

    @Override
    public Map<String, Object> findTeamLeadersByUserOrganization(String userId) {
        return docCommonMapper.findTeamLeadersByUserOrganization(userId);
    }

    @Override
    public int findDocumentsPendingApprovalTotalCountByUserId(Map<String,Object> param) {
        return docCommonMapper.findDocumentsPendingApprovalTotalCountByUserId(param);
    }

    @Override
    public int findCompleteDocumentsTotalCountByUserId(Map<String,Object> param) {
        return docCommonMapper.findCompleteDocumentsTotalCountByUserId(param);
    }

    @Override
    public List<Map<String, Object>> findDocumentUrls() {
        return docCommonMapper.findDocumentUrls();
    }
}
