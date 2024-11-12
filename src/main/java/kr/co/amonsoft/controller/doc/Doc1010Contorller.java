package kr.co.amonsoft.controller.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.Doc1010Service;
import kr.co.amonsoft.service.doc.Doc1020Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Controller
@Slf4j
public class Doc1010Contorller {

    private final Doc1020Service doc1020Service;
    private static final Set<String> ALLOWED_ROLES = Set.of("01", "02", "03");

    private final Doc1010Service doc1010Service;

    @GetMapping("/workflow/selectWrite")
    public String selectWrite(HttpServletRequest request) {
        return "/admin/jihee/content/selectWrite";
    }

    @RequestMapping(value = "/workflow/write")
    public String writeWorkflow( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = doc1020Service.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/jihee/content/write";
    }

    @GetMapping("/workflow")
    public String viewWorkflow(@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        List<Map<String, Object>> documentsUnderApproval = doc1020Service.findDocumentsUnderApproval(customUserDetails.getUserId());
        String roleCode = customUserDetails.getRole();
        if(ALLOWED_ROLES.contains(roleCode)){
            model.addAttribute("documents", doc1020Service.findPendingApprovalDocuments(customUserDetails.getUserId()) );
            model.addAttribute("role", roleCode);
        }else{
            model.addAttribute("documents", documentsUnderApproval);
        }
        return "/admin/jihee/content/document";
    }

    @ResponseBody
    @GetMapping("/workflow/changeList")
    public List<Map<String,Object>> viewWorkflowChangeList(@RequestParam String type,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        String roleCode = customUserDetails.getRole();
        if ("pending".equals(type) && Set.of("01", "02", "03").contains(roleCode)) {
            // 승인 대기 문서 반환
            return doc1020Service.findPendingApprovalDocuments(customUserDetails.getUserId());
        } else if ("complete".equals(type)) {
            return doc1020Service.findCompleteDocuments(customUserDetails.getUserId());
        } else {
            // 결재 진행 중 문서 반환
            return doc1020Service.findDocumentsUnderApproval(customUserDetails.getUserId());
        }
    }


    /** ##########################################################################################################################
     * 휴가계
     */
    @RequestMapping(value = "/admin/doc/annualLeave")
    public String annualLeave( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = doc1010Service.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/document/annualLeave";
    }

    /**
     * 휴가계 결재 화면
     */
    @GetMapping("/approval/annualLeaveView")
    public String annualLeaveView(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam BigInteger docId, Model model) {
        log.info("##################################################");
        log.info("휴가계 결재 화면 진입");
        log.info(docId.toString());
        log.info("##################################################");
        List<Map<String,Object>> approvalSteps = doc1010Service.findApprovalStepsByDocId(docId);
        Map<String,Object>  vacationDetails = doc1010Service.findVacationDetailsByDocId(docId);
        Map<String,Object>  documentCreatorInfo = doc1010Service.findDocumentCreatorInfo(docId);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("vacationDetails", vacationDetails);
        return "/admin/document/annualLeaveWriteView";
    }

    @ResponseBody
    @PostMapping("/approval/insertAnnualLeaveDetail")
    public ResponseEntity<BigInteger> insertAnnualLeaveDetail(@RequestBody Map<String,Object> param){
        log.info("#####################");
        log.info("휴가계 : {}", param);
        log.info("#####################");
        BigInteger docId = doc1010Service.insertApprovalDocument(param);
        return ResponseEntity.ok(docId);
    }

    @PostMapping("/approval/updateAnnualLeaveApprovalStep")
    public ResponseEntity<Integer> updateApprovalStep(@RequestBody Map<String,Object> param){
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        int result = doc1010Service.updateAnnualLeaveApprovalStep(param);
        if (result == 1) {
            return ResponseEntity.ok(docId);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(docId);
        }
    }

    /**
     *  ##############################################################################################################
     */

}
