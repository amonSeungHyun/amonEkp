package kr.co.amonsoft.controller.com;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.amonsoft.service.com.Com1010Service;
import kr.co.amonsoft.util.PageUtil;
@Controller
public class Com1010Controller {
	@Autowired
	private Com1010Service com1010Service;

	@GetMapping(value = "/amonsoft/controller/com/com1010")
    public String com1010(HttpServletRequest request, ModelAndView mav) throws Exception {
		
        return "/admin/com/com1010";
    }
	
    @ResponseBody
    @RequestMapping(value = "/com/selectCom1010List")
    public Map<String, Object> selectCom1010List(@RequestBody Map<String, Object> param) throws Exception {
    	
        int totalCnt = com1010Service.selectCom1010ListCnt(param);
//        Map<String, Object> pagingParams = PageUtil.getPagingParams(param, totalCnt);
//        param.putAll(pagingParams);
    	
        List<Map<String, Object>>resultList = com1010Service.selectCom1010List(param);
        
        Map<String, Object> resultMap = new HashMap<String, Object>();
//        resultMap.put("resultList", resultList);
//        resultMap.put("pager", pagingParams);

        return resultMap;
        
    }
    
    @ResponseBody
    @PostMapping("/com/insertCom1010")
    public Map<String,Object> insertCom1010(@RequestBody Map<String,Object> param){
    	Map<String,Object> result = new HashMap<>();
    	System.out.println("param >> " + param);
    	com1010Service.insertCom1010(param);
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
