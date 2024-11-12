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
import kr.co.amonsoft.service.doc.Doc1050Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Doc1050Controller {
	
    private final Doc1050Service doc1050Service;
    
    private final Doc1020Service doc1020Service;
    
    @RequestMapping(value = "/doc/doc1050")
    public String doc1050( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = doc1020Service.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1050";
    }
    
    @ResponseBody
    @PostMapping("/doc/insertDoc1050")
    public  Map<String,Object> insertDoc1050(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
        doc1050Service.insertDoc1050(param);
        return result;
    }
    
    @GetMapping("/doc/doc1050View")
    public String doc1050View(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam BigInteger docId, Model model) {
    	model.addAttribute("docId", docId);
    	List<Map<String,Object>> approvalSteps = doc1020Service.findApprovalStepsByDocId(docId);
        Map<String,Object> documentCreatorInfo = doc1020Service.findDocumentCreatorInfo(docId);
        List<Map<String,Object>> doc1050Details = doc1050Service.selectDoc1050(docId);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("doc1050Details", doc1050Details);
        return "/admin/doc/doc1050View";
    }
    
}
