package kr.co.amonsoft.controller.doc;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.DocCommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RequiredArgsConstructor
@Controller
public class DocCommonController {

    private static final Set<String> ALLOWED_ROLES = Set.of("01", "02", "03");
    private final DocCommonService docCommonService;

    @GetMapping("/workflow")
    public String viewWorkflow(@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        List<Map<String, Object>> documentsUnderApproval = docCommonService.findDocumentsUnderApproval(customUserDetails.getUserId());
        String roleCode = customUserDetails.getRole();
        if(ALLOWED_ROLES.contains(roleCode)){
            model.addAttribute("documents", docCommonService.findPendingApprovalDocuments(customUserDetails.getUserId()) );
            model.addAttribute("role", roleCode);
        }else{
            model.addAttribute("documents", documentsUnderApproval);
        }
        return "/admin/jihee/content/document";
    }

    @GetMapping("/workflow/selectWrite")
    public String selectWrite(HttpServletRequest request) {
        return "/admin/jihee/content/selectWrite";
    }

    @ResponseBody
    @GetMapping("/workflow/changeList")
    public List<Map<String,Object>> viewWorkflowChangeList(@RequestParam String type, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        String roleCode = customUserDetails.getRole();
        if ("pending".equals(type) && Set.of("01", "02", "03").contains(roleCode)) {
            // 승인 대기 문서 반환
            return docCommonService.findPendingApprovalDocuments(customUserDetails.getUserId());
        } else if ("complete".equals(type)) {
            return docCommonService.findCompleteDocuments(customUserDetails.getUserId());
        } else {
            // 결재 진행 중 문서 반환
            return docCommonService.findDocumentsUnderApproval(customUserDetails.getUserId());
        }
    }

    @RequestMapping(value = "/workflow/write")
    public String writeWorkflow(HttpServletRequest request, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/jihee/content/write";
    }
}
