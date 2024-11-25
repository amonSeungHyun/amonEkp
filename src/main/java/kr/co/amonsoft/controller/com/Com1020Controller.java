package kr.co.amonsoft.controller.com;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.com.Com1020Service;
import kr.co.amonsoft.service.doc.Doc1060Service;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Com1020Controller {
	
	@Autowired
	private Com1020Service com1020Service;
    private final FileService fileService;

	@GetMapping(value = "/com/com1020")
    public String com1020(@AuthenticationPrincipal CustomUserDetails customUserDetails
            , @RequestParam BigInteger board_number
            , @RequestParam String referenceType
    		, Model model) throws Exception {
		model.addAttribute("board_number", board_number);
		List<Map<String,Object>> fileList = fileService.findFileDatas(board_number, referenceType);
		
		Map<String, Object> currentStepNo = new HashMap<>();
		currentStepNo.put("docCurrentStep", "1");

		
		model.addAttribute("fileList",fileList);
		model.addAttribute("currentStepNo",currentStepNo);
		
        return "/admin/com/com1020";
    }
	
    @ResponseBody
    @PostMapping("/com/selectCom1020")
    public Map<String,Object> selectCom1020(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = com1020Service.selectCom1020(param);
    	return result;
    }
	
    @ResponseBody
    @PostMapping("/com/updateCom1020")
    public Map<String,Object> updateCom1020(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
    	System.out.println("param >> " + param);
    	com1020Service.updateCom1020(param);
        return result;
    }
    
}
