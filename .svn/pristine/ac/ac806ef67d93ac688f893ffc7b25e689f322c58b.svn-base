package kr.co.amonsoft.controller.com;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.amonsoft.Pager;
import kr.co.amonsoft.service.com.Com7010Service;

@Controller
public class Com7010Controller {
	
	@Autowired
	private Com7010Service com7010Service;

	@GetMapping(value = "/amonsoft/controller/com/com7010")
    public String com7010(HttpServletRequest request, ModelAndView mav) throws Exception {
		
        return "/admin/com/com7010";
    }
	
    @ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/selectCom7010List")
    public Map<String, Object> selectCom7010List(@RequestBody Map<String, Object> param) throws Exception {
    	
    	int pageNum = param.get("pageNum") != null ? Integer.parseInt(param.get("pageNum").toString()) : 1;
        int pageSize = param.get("pageSize") != null ? Integer.parseInt(param.get("pageSize").toString()) : 5;
        
    	List<Map<String, Object>> resultList = new ArrayList<>();
    	
    	int totalCnt = com7010Service.selectCom7010Cnt(param); 
    	int blockSize = 5; 
    	
    	Pager pager = new Pager(pageNum, totalCnt, pageSize, blockSize);
    	
        Map<String, Object> pageMap = new HashMap<>(param); 
        pageMap.put("startRow", pager.getStartRow());
        pageMap.put("endRow", pager.getEndRow());
        
		resultList = com7010Service.selectCom7010List(pageMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", resultList);
        resultMap.put("pager", pager);
    	
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/selectCom7010Code")
    public List<Map<String, Object>> selectCom7010Code(@RequestBody Map<String, Object> param) throws Exception {
        return com7010Service.selectCom7010Code(param);
    }
    
    @ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/insertCom7010")
    public Map<String, Object> insertCom7010(@RequestBody Map<String, Object> param) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            // 공통코드 메인 테이블 insert
        	int mainInsertResult = com7010Service.insertCom7010(param);
            result.put("mainInsertResult", mainInsertResult);

            // 공통코드 상세 테이블 insert
            int detailInsertResult = com7010Service.insertCom7010Detail(param);
            result.put("detailInsertResult", detailInsertResult);

            result.put("status", "success");

        } catch(Exception e) {
            // 실패 상태 추가 및 예외 throw
            result.put("status", "failure");
            result.put("error", e.getMessage());
            throw e;
        }

        return result;
    }
	
    @ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/deleteCom7010")
    public Map<String, Object> deleteCom7010(@RequestBody Map<String, Object> param) {
        List<Map<String, String>> selectedItems = (List<Map<String, String>>) param.get("selectedItems");
        Map<String, Object> result = new HashMap<>();

        try {
            com7010Service.deleteCom7010(selectedItems);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }

        return result;
    }
}
