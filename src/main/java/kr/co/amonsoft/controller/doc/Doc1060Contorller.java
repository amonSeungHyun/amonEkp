package kr.co.amonsoft.controller.doc;

import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@Controller
public class Doc1060Contorller {

    private final DocCommonService docCommonService;
    private final Doc1060Service doc1060Service;
    private final ApvCommonService apvCommonService;
    private final FileService fileService;

    private final String UPLOAD_PATH = "C:\\test";
    
    @GetMapping("/doc/doc1060")
    public String selectWrite(HttpServletRequest request, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
    	Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1060/doc1060Write";
    }

    @ResponseBody
    @PostMapping("/doc/insertTransportExpense")
    public ResponseEntity<BigInteger> insertTransportExpense(
            @AuthenticationPrincipal CustomUserDetails customUserDetails,
            @RequestParam("data") String data,
            @RequestParam(value = "files", required = false) List<MultipartFile> files) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> param = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});
        String userId = customUserDetails.getUserId();
        param.put("userId",userId);

        BigInteger docId = doc1060Service.insertTransportExpense(param);
        param.put("referenceId",docId);
        if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, UPLOAD_PATH, param);
        }

        return ResponseEntity.ok(docId);
    }
    
    @GetMapping("/doc/doc1060View")
    public String doc1060View(@AuthenticationPrincipal CustomUserDetails customUserDetails
            , @RequestParam BigInteger docId
            , @RequestParam String referenceType
            , Model model) {
    	model.addAttribute("docId", docId);
        List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
        List<Map<String,Object>> fileList = fileService.findFileDatas(docId, referenceType);
        Map<String,Object>  documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        Map<String, Object> currentStepNo = apvCommonService.findCurrentStepNo(docId);
        Map<String, Object> userStepNo = apvCommonService.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());

        List<Map<String,Object>> transportExpenseDetails = doc1060Service.findTransportExpenseDetailsByDocId(docId);


        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("fileList",fileList);
        model.addAttribute("currentStepNo",currentStepNo);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("transportExpenseDetails", transportExpenseDetails);

        return "/admin/doc/doc1060/doc1060View";
    }

}
