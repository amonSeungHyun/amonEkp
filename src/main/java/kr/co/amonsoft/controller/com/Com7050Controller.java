package kr.co.amonsoft.controller.com;

import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.service.com.Com7050Service;
import kr.co.amonsoft.util.PageUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/members")
public class Com7050Controller {

    private final Com7050Service com7050Service;

    @GetMapping("/com7050")
    public String index() {
        return "/admin/members/com7050";
    }

    @PostMapping("selectMemberList")
    @ResponseBody
    public Map<String, Object> selectMemberList(@RequestParam Map<String, Object> param){
        log.info("[구성원 조회 컨트롤러 - selectMemberList] param : {}", param);

        int totalCnt = com7050Service.selectMemberCnt(param);
        Map<String, Object> pagingParams = PageUtil.getPagingParams(param, totalCnt);
        param.putAll(pagingParams);

        List<MemberListDTO> resultList = com7050Service.selectMemberList(param);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", resultList);
        resultMap.put("pager", pagingParams);

        return resultMap;
    }

}
