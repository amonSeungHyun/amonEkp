package kr.co.amonsoft.controller.com;

import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.service.apv.ApvCommonService;
import kr.co.amonsoft.service.com.Com1010Service;
import kr.co.amonsoft.service.doc.DocCommonService;
import kr.co.amonsoft.service.file.FileService;
import kr.co.amonsoft.util.PageUtil;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class Com1010Controller {
	@Autowired
	private Com1010Service com1010Service;
	
	private final DocCommonService docCommonService;
	private final ApvCommonService apvCommonService;
    private final FileService fileService;
    
    private final String UPLOAD_PATH = "C:\\test";
    private static final Set<String> ALLOWED_ROLES = Set.of("01", "02", "03");

	@GetMapping(value = "/amonsoft/controller/com/com1010")
    public String com1010(HttpServletRequest request, Model model, @AuthenticationPrincipal CustomUserDetails customUserDetails) throws Exception {
		String roleCode = customUserDetails.getRole();
		//권한있는사람
        if(ALLOWED_ROLES.contains(roleCode)){
            model.addAttribute("role", roleCode);
        }		
        return "/admin/com/com1010";
    }
	
    @ResponseBody
    @PostMapping("/com/selectCom1010List")
    public Map<String, Object> selectCom1010List(@RequestParam(defaultValue = "1") int pageNum, @RequestParam Map<String, Object> param) throws Exception {
        int totalCnt = com1010Service.selectCom1010ListCnt(param);
        Map<String, Object> pagingParams = PageUtil.getPagingParams(pageNum, totalCnt);
        param.putAll(pagingParams);
    	
        List<Map<String, Object>>resultList = com1010Service.selectCom1010List(param);
        
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", resultList);
        resultMap.put("pager", pagingParams);

        return resultMap;
        
    }
    
    @ResponseBody
    @PostMapping("/com/insertCom1010")
    public Map<String,Object> insertCom1010(
    		@RequestParam("data") String data,
    		@AuthenticationPrincipal CustomUserDetails customUserDetails,
    		@RequestParam(value = "files", required = false) List<MultipartFile> files) throws IOException{
    	ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> param = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});
    	Map<String,Object> result = new HashMap<>();
    	System.out.println("param >> " + param);
    	BigInteger boardNumber = com1010Service.insertCom1010(param);
    	param.put("referenceId",boardNumber);
    	param.put("referenceType", "board");
    	
    	if(files != null && !files.isEmpty()) {
            fileService.uploadFiles(files, UPLOAD_PATH, param);
        }
    	
        return result;
    }
    
    @ResponseBody
    @PostMapping("/com/deleteCom1010")
    public Map<String,Object> deleteCom1010(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
    	System.out.println("param >> " + param);
    	com1010Service.deleteCom1010(param);
    	return result;
    }
}
