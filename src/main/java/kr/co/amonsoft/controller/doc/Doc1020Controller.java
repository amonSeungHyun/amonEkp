package kr.co.amonsoft.controller.doc;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.Doc1020Service;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
public class Doc1020Controller {

    private final Doc1020Service doc1020Service;

    @ResponseBody
    @PostMapping("/approval/insertExpenseDetail")
    public  ResponseEntity<BigInteger> insertExpenseDetail(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestBody Map<String,Object> param){
        param.put("userId",customUserDetails.getUserId());
        BigInteger docId = doc1020Service.insertApprovalDocument(param);
        return ResponseEntity.ok(docId);
    }

    @GetMapping("/approval/expenseDetailView")
    public String approvalExpenseDetailView(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam BigInteger docId, Model model) {
        List<Map<String,Object>> approvalSteps = doc1020Service.findApprovalStepsByDocId(docId);
        List<Map<String,Object>>  expenseDetails = doc1020Service.findExpenseDetailsByDocId(docId);
        Map<String,Object>  documentCreatorInfo = doc1020Service.findDocumentCreatorInfo(docId);
        Map<String, Object> currentStepNo = doc1020Service.findCurrentStepNo(docId);
        Map<String, Object> userStepNo = doc1020Service.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());

        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("currentStepNo",currentStepNo);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("expenseDetails", expenseDetails);

        return "/admin/jihee/content/writeView";
    }

    @PostMapping("/approval/updateApprovalStep")
    public ResponseEntity<Integer> updateApprovalStep(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestBody Map<String,Object> param){
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        param.put("roleCode",customUserDetails.getRole());
        int result = doc1020Service.updateApprovalStatus(param);
        if (result == 1) {
            return ResponseEntity.ok(docId);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(docId);
        }
    }

}
