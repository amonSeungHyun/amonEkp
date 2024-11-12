package kr.co.amonsoft.controller.com;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.amonsoft.service.com.Com1010Service;
@Controller
public class Com1010Controller {
	@Autowired
	private Com1010Service com1010Service;

	@GetMapping(value = "/amonsoft/controller/com/com1010")
    public String com1010(HttpServletRequest request, ModelAndView mav) throws Exception {
		
        return "/admin/com/com1010";
    }
	
    @ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/selectCom1010List")
    public List<Map<String, Object>> selectCom1010List(@RequestBody Map<String, Object> param) throws Exception {
        return com1010Service.selectCom1010List(param);
    }
}
