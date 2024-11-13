package kr.co.amonsoft.controller.apv;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.apv.ApvCommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@RequiredArgsConstructor
@Controller
public class ApvCommonController {

    private final ApvCommonService apvCommonService;

    @PostMapping("/approval/updateApprovalStep")
    public ResponseEntity<Integer> updateApprovalStep(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestBody Map<String,Object> param){
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        param.put("roleCode",customUserDetails.getRole());
        int result = apvCommonService.updateApprovalStatus(param);
        if (result == 1) {
            return ResponseEntity.ok(docId);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(docId);
        }
    }
}
