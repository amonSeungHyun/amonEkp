package kr.co.amonsoft.controller.com;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.service.com.Com7050Service;
import kr.co.amonsoft.service.com.Com7080Service;

@Controller
public class Com7080Controller {
	
	@Autowired
	private Com7080Service com7080Service;
	
	@Autowired
	private Com7050Service com7050Service;

	@GetMapping(value = "/amonsoft/controller/com/com7080")
    public String com7080(HttpServletRequest request, ModelAndView mav) throws Exception {
		
        return "/admin/com/com7080";
    }
	
	@ResponseBody
    @RequestMapping(value = "/amonsoft/controller/com/selectCom7080List")
    public List<MemberListDTO> selectCom7080List(@RequestParam Map<String, Object> param) throws Exception {

        return com7080Service.selectCom7080List(param);
    }
	
	@ResponseBody
	@RequestMapping(value = "/amonsoft/controller/com/insertCom7080")
	public Map<String, Object> insertCom7080(@RequestBody Map<String, Object> param) throws Exception {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        String password = (String) param.get("password");
	        System.out.println("password >> " + password);

			if (!password.isEmpty()) {
		        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		        String encryptedPassword = passwordEncoder.encode(password);
	
		        param.put("password", encryptedPassword);
			}
	        System.out.println("param >>> " + param);

	        int insertResult = com7080Service.insertCom7080(param); 
	        result.put("insertResult", insertResult);

	        result.put("status", "success");

	    } catch (Exception e) {
	        result.put("status", "failure");
	        result.put("error", e.getMessage());
	        throw e;
	    }

	    return result;
	}
	
}
