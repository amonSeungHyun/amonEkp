package kr.co.amonsoft.controller.doc;

import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.doc.Doc1020Service;
import kr.co.amonsoft.service.doc.Doc1050Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Doc1050Controller {
	
    private final Doc1050Service doc1050Service;
    private final DocCommonService docCommonService;
    private final ApvCommonService apvCommonService;
    private final FileService fileService;

    @RequestMapping(value = "/doc/doc1050")
    public String doc1050( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1050/doc1050Write";
    }
    
    @ResponseBody
    @PostMapping("/doc/insertDoc1050")
    public ResponseEntity<BigInteger> insertDoc1050(
            @AuthenticationPrincipal CustomUserDetails customUserDetails,
            @RequestParam("data") String data,
            @RequestParam(value = "files", required = false) List<MultipartFile> files) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> param = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});
        String userId = customUserDetails.getUserId();
        param.put("userId",userId);

        BigInteger docId = doc1050Service.insertDoc1050(param);
        param.put("referenceId",docId);
        if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, param);
        }

        return ResponseEntity.ok(docId);
    }
    
    @GetMapping("/doc/doc1050View")
    public String doc1050View(@AuthenticationPrincipal CustomUserDetails customUserDetails
    		 , @RequestParam BigInteger docId
             , @RequestParam String referenceType
             , Model model) {
    	model.addAttribute("docId", docId);
    	List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
    	List<Map<String,Object>> fileList = fileService.findFileDatas(docId, referenceType);
        Map<String,Object> documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        Map<String, Object> currentStepNo = apvCommonService.findCurrentStepNo(docId);
        List<Map<String,Object>> doc1050Details = doc1050Service.selectDoc1050(docId);
        Map<String, Object> userStepNo = apvCommonService.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());
        
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("doc1050Details", doc1050Details);
        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("fileList",fileList);
        model.addAttribute("currentStepNo",currentStepNo);
        
        return "/admin/doc/doc1050/doc1050View";
    }
    
}
