package kr.co.amonsoft.controller.doc;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.Doc1010Service;
import kr.co.amonsoft.service.doc.Doc1070Service;
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
public class Doc1070Controller {

    private final Doc1070Service doc1070Service;
    private final DocCommonService docCommonService;
    private final ApvCommonService apvCommonService;

    /** ##########################################################################################################################
     * 사직서 작성 화면
     */
    @GetMapping(value = "/admin/doc/doc1070/resignationView")
    public String resignationView( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1070/resignationView";
    }

    /**
     * 결재된 사직서 화면
     */
    @GetMapping("/doc/doc1070View")
    public String resignationWriteView(@AuthenticationPrincipal CustomUserDetails customUserDetails
            , @RequestParam BigInteger docId
            , Model model) {
        log.info("##################################################");
        log.info("사직서 결재 화면 진입");
        log.info(docId.toString());
        log.info("##################################################");

        List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
        Map<String,Object> resignationDetails = doc1070Service.findResignationDetailsByDocId(docId);
        Map<String,Object> documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        Map<String, Object> currentStepNo = apvCommonService.findCurrentStepNo(docId);
        Map<String, Object> userStepNo = apvCommonService.findStepNoByDocIdAndUserId(docId, customUserDetails.getUserId());

        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("resignationDetails", resignationDetails);
        model.addAttribute("currentStepNo",currentStepNo);
        model.addAttribute("userStepNo",userStepNo);
        model.addAttribute("docId", docId);
        return "/admin/doc/doc1070/resignationWriteView";
    }

    /**
     * 사직서 결재 처리
     */
    @ResponseBody
    @PostMapping("/approval/insertResignationDetail")
    public ResponseEntity<BigInteger> insertResignationDetail(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestParam("data") String data) throws JsonProcessingException {
        String userId = customUserDetails.getUserId();
        BigInteger docId = doc1070Service.insertResignation(data, userId);
        return ResponseEntity.ok(docId);
    }



}
