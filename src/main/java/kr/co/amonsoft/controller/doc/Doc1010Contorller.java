package kr.co.amonsoft.controller.doc;

import java.io.IOException;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.print.Doc;
import javax.servlet.http.HttpServletRequest;

import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
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
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@Controller
@Slf4j
public class Doc1010Contorller {

    private final Doc1010Service doc1010Service;
    private final DocCommonService docCommonService;
    private final ApvCommonService apvCommonService;
    private final FileService fileService;

    private final String UPLOAD_PATH = "C:\\test";

    /** ##########################################################################################################################
     * 휴가계
     */
    @RequestMapping(value = "/admin/doc/doc1010/annualLeave")
    public String annualLeave( HttpServletRequest request,@AuthenticationPrincipal CustomUserDetails customUserDetails, Model model) {
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1010/annualLeave";
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

        List<Map<String,Object>> approvalSteps = apvCommonService.findApprovalStepsByDocId(docId);
        Map<String,Object>  vacationDetails = doc1010Service.findVacationDetailsByDocId(docId);
        Map<String,Object>  documentCreatorInfo = apvCommonService.findDocumentCreatorInfo(docId);
        Map<String, Object> teamLeadersByUserOrganization = docCommonService.findTeamLeadersByUserOrganization(customUserDetails.getUserId());
        model.addAttribute("approvalSteps", approvalSteps);
        model.addAttribute("documentCreatorInfo", documentCreatorInfo);
        model.addAttribute("vacationDetails", vacationDetails);
        model.addAttribute("leaderInfo", teamLeadersByUserOrganization);
        return "/admin/doc/doc1010/annualLeaveWriteView";
    }

    @ResponseBody
    @PostMapping("/approval/insertAnnualLeaveDetail")
    public ResponseEntity<BigInteger> insertAnnualLeaveDetail(
            @RequestBody Map<String,Object> param
            , @RequestParam(value = "files", required = false) List<MultipartFile> files
    ) throws IOException {
        log.info("#####################");
        log.info("휴가계 : {}", param);
        log.info("#####################");
        BigInteger docId = doc1010Service.insertApprovalDocument(param);

        if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, UPLOAD_PATH, param);
        }

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

}
