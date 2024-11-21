package kr.co.amonsoft.controller.doc;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.util.PageUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RequiredArgsConstructor
@Controller
public class DocCommonController {

    private static final Set<String> ALLOWED_ROLES = Set.of("01", "02", "03");
    private final DocCommonService docCommonService;

    @GetMapping("/docList")
    public String viewWorkflow(@RequestParam(defaultValue = "1", required = false) int pageNum, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        String roleCode = customUserDetails.getRole();
        int totalCnt = 0;
        String userId = customUserDetails.getUserId();
        List<Map<String, Object>> documents;
        Map<String, Object> pagingParams;

        //권한있는사람
        if(ALLOWED_ROLES.contains(roleCode)){
            totalCnt = docCommonService.findDocumentsPendingApprovalTotalCountByUserId(userId);
            pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
            pagingParams.put("userId",userId);
            documents = docCommonService.findPendingApprovalDocuments(pagingParams);
            model.addAttribute("role", roleCode);
        }else{
            totalCnt = docCommonService.findDocumentsUnderApprovalTotalCountByUserId(userId);
            pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
            pagingParams.put("userId",userId);
            documents = docCommonService.findDocumentsUnderApproval(pagingParams);
        }
        model.addAttribute("documents", documents);
        model.addAttribute("pager",pagingParams);
        return "/admin/doc/docList";
    }

    @GetMapping("/doc/selectWrite")
    public String selectWrite(HttpServletRequest request) {
        return "/admin/doc/selectWrite";
    }

    @ResponseBody
    @GetMapping("/docList/changeList")
    public Map<String,Object> viewWorkflowChangeList(@RequestParam(defaultValue = "1") int pageNum, @RequestParam String type, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        String roleCode = customUserDetails.getRole();
        int totalCnt = 0;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<Map<String, Object>> resultList;
        Map<String, Object> pagingParams = new HashMap<String, Object>();
        String userId = customUserDetails.getUserId();
        pagingParams.put("userId",userId);

        if ("pending".equals(type) && Set.of("01", "02", "03").contains(roleCode)) {
            // 결재 승인 대기 문서 반환
            totalCnt = docCommonService.findDocumentsPendingApprovalTotalCountByUserId(customUserDetails.getUserId());
            pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
            pagingParams.put("userId",userId);
            resultList = docCommonService.findPendingApprovalDocuments(pagingParams);
        } else if ("complete".equals(type)) {
            //결재 완료는 나중에 추후
            resultList =  docCommonService.findCompleteDocuments(customUserDetails.getUserId());
        } else {
            // 결재 진행 중 문서 반환
            totalCnt = docCommonService.findDocumentsUnderApprovalTotalCountByUserId(customUserDetails.getUserId());
            pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
            pagingParams.put("userId",userId);
            resultList = docCommonService.findDocumentsUnderApproval(pagingParams);
        }

        resultMap.put("resultList", resultList);
        resultMap.put("pager", pagingParams);
        return resultMap;
    }
}
