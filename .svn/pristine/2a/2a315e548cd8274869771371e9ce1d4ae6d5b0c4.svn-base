package kr.co.amonsoft.controller.com;

import kr.co.amonsoft.Pager;
import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.service.com.Com7050Service;
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

        int pageNum = param.get("pageNum") != null ? Integer.parseInt(param.get("pageNum").toString()) : 1;
        int pageSize = param.get("pageSize") != null ? Integer.parseInt(param.get("pageSize").toString()) : 5;

        List<MemberListDTO> resultList = new ArrayList<>();

        int totalCnt = com7050Service.selectMemberCnt(param);
        log.info(" 페이지번호값 확인 @@@ > {}", pageNum);
        int blockSize = 10;

        Pager pager = new Pager(pageNum, totalCnt, pageSize, blockSize);

        param.put("startRow", pager.getStartRow());
        param.put("endRow", pager.getEndRow());
        log.info(" 페이지번호값 확인 @@@ > {}", param);
        resultList = com7050Service.selectMemberList(param);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", resultList);
        resultMap.put("pager", pager);

        return resultMap;
    }

}
