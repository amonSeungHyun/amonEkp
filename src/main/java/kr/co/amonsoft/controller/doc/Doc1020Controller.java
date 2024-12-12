package kr.co.amonsoft.controller.doc;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.Doc1020Service;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@Slf4j
public class Doc1020Controller {

    private final Doc1020Service doc1020Service;
    private final DocCommonService docCommonService;
    private final ApvCommonService apvCommonService;
    private final FileService fileService;

    @ResponseBody
    @PostMapping("/approval/insertExpenseDetail")
    public  ResponseEntity<BigInteger> insertExpenseDetail(
            @AuthenticationPrincipal CustomUserDetails customUserDetails,
            @RequestParam("data") String data,
            @RequestParam(value = "files", required = false) List<MultipartFile> files) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> param = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});
        String userId = customUserDetails.getUserId();

        param.put("userId",userId);
        BigInteger docId = doc1020Service.insertApprovalDocument(param);
        param.put("referenceId",docId);
        if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, param);
        }
        return ResponseEntity.ok(docId);
    }

    @GetMapping("/approval/expenseDetailView")
    public String approvalExpenseDetailView(@AuthenticationPrincipal CustomUserDetails customUserDetails
            , @RequestParam BigInteger docId
            , @RequestParam String referenceType
            , Model model) {
        List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
        List<Map<String,Object>> expenseDetails = doc1020Service.findExpenseDetailsByDocId(docId);
        List<Map<String,Object>> fileList = fileService.findFileDatas(docId, referenceType);
        Map<String,Object>  documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        Map<String, Object> currentStepNo = apvCommonService.findCurrentStepNo(docId);
        Map<String, Object> userStepNo = apvCommonService.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());

        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("fileList",fileList);
        model.addAttribute("currentStepNo",currentStepNo);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("expenseDetails", expenseDetails);

        return "/admin/doc/doc1020/expenseDetailView";
    }

    @RequestMapping(value = "/doc/expenseDetailWrite")
    public String writeWorkflow(HttpServletRequest request, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1020/expenseDetailWrite";
    }

}
