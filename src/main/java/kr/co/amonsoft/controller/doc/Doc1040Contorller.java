package kr.co.amonsoft.controller.doc;

import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
import kr.co.amonsoft.util.PageUtil;

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
import kr.co.amonsoft.service.doc.Doc1040Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Doc1040Contorller {

    private final Doc1040Service doc1040Service;
    private final DocCommonService docCommonService;
    private final ApvCommonService apvCommonService;
    private final FileService fileService;

    @GetMapping("/doc/doc1040")
    public String selectWrite(@RequestParam(defaultValue = "1", required = false) int pageNum, @AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
    	Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
    	int totalCnt = 0;
    	Map<String, Object> pagingParams;
    	
    	totalCnt = doc1040Service.selectReferenceApprovalCnt();
        pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
        
        List<Map<String, Object>> documents = doc1040Service.selectReferenceApproval(pagingParams);
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        model.addAttribute("documents", documents);
        model.addAttribute("pager",pagingParams);
        
        return "/admin/doc/doc1040/doc1040Write";
    }
    
    @ResponseBody
    @RequestMapping(value = "/doc/getApprovalId")
    public Map<String, Object> getApprovalId() {
        Map<String, Object> result = doc1040Service.getApprovalId();
        return result;
    }
    
    @ResponseBody
    @PostMapping("/doc/insertApprovalRequest")
    public ResponseEntity<BigInteger> insertApprovalRequest(
            @AuthenticationPrincipal CustomUserDetails customUserDetails,
            @RequestParam("data") String data,
            @RequestParam(value = "files", required = false) List<MultipartFile> files) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> param = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});
        String userId = customUserDetails.getUserId();
        param.put("userId",userId);

        BigInteger docId = doc1040Service.insertApprovalRequest(param);
        param.put("referenceId",docId);
        if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, param);
        }

        return ResponseEntity.ok(docId);
    }
    
    @GetMapping("/doc/doc1040View")
    public String approvalRequestDetailView(@AuthenticationPrincipal CustomUserDetails customUserDetails
    		, @RequestParam BigInteger docId
    		, @RequestParam String referenceType
    		, Model model) {
    	model.addAttribute("docId", docId);
    	List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
    	List<Map<String,Object>> fileList = fileService.findFileDatas(docId, referenceType);
    	Map<String,Object>  documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
    	Map<String, Object> currentStepNo = apvCommonService.findCurrentStepNo(docId);
        Map<String, Object> userStepNo = apvCommonService.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());
    	
        Map<String,Object>  approvalRequestDetails = doc1040Service.findApprovalRequestDetailsByDocId(docId);
        
        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("fileList",fileList);
        model.addAttribute("currentStepNo",currentStepNo);
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("approvalRequestDetails", approvalRequestDetails);
        
        return "/admin/doc/doc1040/doc1040View";
    }
    
    @ResponseBody
    @RequestMapping(value = "/doc/approvalRequestDetailView")
    public Map<String,Object> approvalRequestDetailView(@RequestBody Map<String,Object> param){
    	String docIdString = (String) param.get("docId");
    	BigInteger docId = new BigInteger(docIdString);
    	Map<String,Object> approvalRequestDetails = doc1040Service.findApprovalRequestDetailsByDocId(docId);
    	return approvalRequestDetails;
    }
    
    @ResponseBody
    @RequestMapping(value = "/doc/selectReferenceApprovalView")
    public Map<String,Object> selectReferenceApprovalView(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
    	List<Map<String,Object>> approvalRequestDetails = doc1040Service.selectReferenceApprovalView(param);
    	result.put("result", approvalRequestDetails);
    	return result;
    }
    
    @ResponseBody
    @GetMapping("/doc/doc1040changeList")
    public Map<String,Object> doc1040changeList(@RequestParam(defaultValue = "1") int pageNum
            , @AuthenticationPrincipal CustomUserDetails customUserDetails) {
        int totalCnt = 0;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<Map<String, Object>> resultList;
        Map<String, Object> pagingParams = new HashMap<String, Object>();

    	totalCnt = doc1040Service.selectReferenceApprovalCnt();
        pagingParams = PageUtil.getPagingParams(pageNum,totalCnt);
        resultList = doc1040Service.selectReferenceApproval(pagingParams);

        resultMap.put("resultList", resultList);
        resultMap.put("pager", pagingParams);
        
        return resultMap;
    }
    
}
