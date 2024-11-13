package kr.co.amonsoft.controller.doc;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.DocCommonService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.Doc1020Service;
import kr.co.amonsoft.service.doc.Doc1060Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Doc1060Contorller {

    private final DocCommonService docCommonService;
    private final Doc1060Service doc1060Service;
    private final ApvCommonService apvCommonService;
    
    @GetMapping("/doc/doc1060")
    public String selectWrite(HttpServletRequest request, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
    	Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1060";
    }
    @ResponseBody
    @PostMapping("/doc/insertTransportExpense")
    public Map<String,Object> insertTransportExpense(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
        doc1060Service.insertTransportExpense(param);
        return result;
    }
    
    @GetMapping("/doc/doc1060View")
    public String doc1060View(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam BigInteger docId, Model model) {
    	model.addAttribute("docId", docId);
    	List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
        Map<String,Object> documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        List<Map<String,Object>> transportExpenseDetails = doc1060Service.findTransportExpenseDetailsByDocId(docId);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("transportExpenseDetails", transportExpenseDetails);
        return "/admin/doc/doc1060View";
    }
    /*
    
    @ResponseBody
    @RequestMapping(value = "/doc/approvalRequestDetailView")
    public Map<String,Object> approvalRequestDetailView(@RequestBody Map<String,Object> param){
    	String docIdString = (String) param.get("docId");
    	BigInteger docId = new BigInteger(docIdString);
    	Map<String,Object> approvalRequestDetails = doc1040Service.findApprovalRequestDetailsByDocId(docId);
    	return approvalRequestDetails;
    }
    
    */
}
