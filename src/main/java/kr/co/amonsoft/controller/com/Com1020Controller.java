package kr.co.amonsoft.controller.com;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.amonsoft.service.com.Com1020Service;
@Controller
public class Com1020Controller {
	
	@Autowired
	private Com1020Service com1020Service;

	@GetMapping(value = "/com/com1020")
    public String com1020(@RequestParam("board_number") String board_number, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("board_number", board_number);
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
