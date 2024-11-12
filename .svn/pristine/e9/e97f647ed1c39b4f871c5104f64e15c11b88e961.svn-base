package kr.co.amonsoft.controller.doc;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import kr.co.amonsoft.service.doc.Doc1020Service;
import kr.co.amonsoft.service.doc.Doc1040Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Doc1040Contorller {

    private final Doc1040Service doc1040Service;

    private final Doc1020Service doc1020Service;
    
    @GetMapping("/doc/doc1040")
    public String selectWrite(HttpServletRequest request, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
    	Map<String, Object> teamLeadersByUserOrganization = doc1020Service.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1040";
    }
    
    @ResponseBody
    @RequestMapping(value = "/doc/getApprovalId")
    public Map<String, Object> getApprovalId() {
        Map<String, Object> result = doc1040Service.getApprovalId();
        return result;
    }
    
    @ResponseBody
    @PostMapping("/doc/insertApprovalRequest")
    public Map<String,Object> insertApprovalRequest(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
        doc1040Service.insertApprovalRequest(param);
        return result;
    }
    
    @GetMapping("/doc/doc1040View")
    public String approvalRequestDetailView(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam BigInteger docId, Model model) {
    	model.addAttribute("docId", docId);
    	List<Map<String,Object>> approvalSteps = doc1020Service.findApprovalStepsByDocId(docId);
        Map<String,Object>  approvalRequestDetails = doc1040Service.findApprovalRequestDetailsByDocId(docId);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("approvalRequestDetails", approvalRequestDetails);
        return "/admin/doc/doc1040View";
    }
    
    @ResponseBody
    @RequestMapping(value = "/doc/approvalRequestDetailView")
    public Map<String,Object> approvalRequestDetailView(@RequestBody Map<String,Object> param){
    	String docIdString = (String) param.get("docId");
    	BigInteger docId = new BigInteger(docIdString);
    	Map<String,Object> approvalRequestDetails = doc1040Service.findApprovalRequestDetailsByDocId(docId);
    	return approvalRequestDetails;
    }
    /*
    @GetMapping("/workflow")
    public String viewWorkflow(@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        List<Map<String, Object>> documentsUnderApproval = doc1040Service.findDocumentsUnderApproval(customUserDetails.getUserId());
        model.addAttribute("documents", documentsUnderApproval);
        return "/admin/jihee/content/document";
    }
    */
}
