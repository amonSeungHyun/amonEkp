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

    private final DocCommonService docCommonService;

    @GetMapping("/docList")
    public String docListView(@RequestParam Map<String, Object> param
            , @AuthenticationPrincipal CustomUserDetails customUserDetails
            , Model model) {
        String userId = customUserDetails.getUserId();
        param.put("userId", userId);
        int pageNum = Integer.parseInt(String.valueOf(param.getOrDefault("pageNum", "1")));
        int totalCnt = docCommonService.findDocumentsUnderApprovalTotalCountByUserId(param);

        Map<String, Object> pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
        pagingParams.put("userId",userId);
        List<Map<String, Object>> documents = docCommonService.findDocumentsUnderApproval(pagingParams);

        model.addAttribute("documentUrls", docCommonService.findDocumentUrls());
        model.addAttribute("documents", documents);
        model.addAttribute("docStatus", "underApproval");
        model.addAttribute("pager",pagingParams);
        return "/admin/doc/docList";
    }

    @GetMapping("/docPendingList")
    public String viewWorkflow(@RequestParam Map<String, Object> param
            , @AuthenticationPrincipal CustomUserDetails customUserDetails
            , Model model) {
        String roleCode = customUserDetails.getRole();
        String userId = customUserDetails.getUserId();
        param.put("userId", userId);
        int pageNum = Integer.parseInt(String.valueOf(param.getOrDefault("pageNum", "1")));

        int totalCnt = docCommonService.findDocumentsPendingApprovalTotalCountByUserId(param);
        Map<String, Object> pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
        pagingParams.put("userId",userId);
        List<Map<String, Object>> documents = docCommonService.findPendingApprovalDocuments(pagingParams);

        model.addAttribute("documentUrls", docCommonService.findDocumentUrls());
        model.addAttribute("admin",true);
        model.addAttribute("role", roleCode);
        model.addAttribute("documents", documents);
        model.addAttribute("docStatus", "pending");
        model.addAttribute("pager",pagingParams);
        return "/admin/doc/docList";
    }

    @GetMapping("/doc/selectWrite")
    public String selectWrite(HttpServletRequest request) {
        return "/admin/doc/selectWrite";
    }

    @ResponseBody
    @GetMapping("/docList/changeList")
    public Map<String, Object> viewWorkflowChangeList(
            @RequestParam Map<String, String> param,
            @AuthenticationPrincipal CustomUserDetails customUserDetails) {

        String roleCode = customUserDetails.getRole();
        String docStatus = param.getOrDefault("docStatus", "");
        int pageNum = Integer.parseInt(param.getOrDefault("pageNum", "1"));

        String userId = customUserDetails.getUserId();
        int totalCnt = 0;

        // 공통 파라미터 설정
        Map<String, Object> pagingParams = new HashMap<>(param);
        pagingParams.put("userId", userId);

        List<Map<String, Object>> resultList;

        // 문서 타입별 처리
        switch (docStatus) {
            case "pending":
                if (Set.of("01", "02", "03").contains(roleCode)) {
                    totalCnt = docCommonService.findDocumentsPendingApprovalTotalCountByUserId(pagingParams);
                    pagingParams.putAll(PageUtil.getPagingParams(pageNum, totalCnt));
                    resultList = docCommonService.findPendingApprovalDocuments(pagingParams);
                } else {
                    throw new IllegalArgumentException("권한이 부족합니다.");
                }
                break;

            case "complete":
                totalCnt = docCommonService.findCompleteDocumentsTotalCountByUserId(pagingParams);
                pagingParams.putAll(PageUtil.getPagingParams(pageNum, totalCnt));
                resultList = docCommonService.findCompleteDocuments(pagingParams);
                break;

            default:
                totalCnt = docCommonService.findDocumentsUnderApprovalTotalCountByUserId(pagingParams);
                pagingParams.putAll(PageUtil.getPagingParams(pageNum, totalCnt));
                resultList = docCommonService.findDocumentsUnderApproval(pagingParams);
                break;
        }
        // 결과 구성
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultList", resultList);
        resultMap.put("pager", pagingParams);

        return resultMap;
    }
}
