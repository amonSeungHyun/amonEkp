package kr.co.amonsoft.controller.com;

import kr.co.amonsoft.dto.com.CommonDTO;
import kr.co.amonsoft.service.com.Com7060Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/members")
public class Com7060Controller {

    private final Com7060Service com7060Service;

    @PostMapping("/insertMember")
    @ResponseBody
    public Map<String, Object> insertMember(@RequestParam Map<String, Object> param){
        log.info(" *** [구성원 등록 컨트롤러] insertMember(param) : {} ", param);
        Map<String, Object> result = new HashMap<>();
        result = com7060Service.insertMember(param);
        log.info(" *** [구성원 등록 컨트롤러] insertMember(result) : {} ", result);

        return result;
    }

    @PostMapping("/updateMember")
    @ResponseBody
    public Map<String, Object> updateMember(@RequestParam Map<String, Object> param){
        log.info(" *** [구성원 수정 컨트롤러] updateMember(param) : {} ", param);
        Map<String, Object> result = new HashMap<>();
        result = com7060Service.updateMember(param);
        log.info(" *** [구성원 수정 컨트롤러] updateMember(result) : {} ", result);

        return result;
    }

    @PostMapping("/deleteMember")
    @ResponseBody
    public int deleteMember(@RequestBody Map<String, Object> param){
        log.info(" *** [구성원 삭제 컨트롤러] deleteMember(param) : {} ", param);
        int result = 0;
        result = com7060Service.deleteMember(param);
        log.info(" *** [구성원 삭제 컨트롤러] deleteMember(result) : {} ", result);

        return result;
    }

    @PostMapping("/resetPassword")
    @ResponseBody
    public int resetPassword(@RequestParam(name = "userId", required = true) String userId){
        log.info(" *** [비밀번호 초기화 컨트롤러] resetPassword(userId) : {} ", userId);

        int result = 0;
        result = com7060Service.resetPassword(userId);
        log.info(" *** [비밀번호 초기화 컨트롤러] resetPassword(userId) : {} ", result);

        return result;
    }

























    /** ********************************************************** 공통 조회 건 ********************************************************************* */

    /**
     * 부서 조회
     * @return
     */
    @GetMapping("/departmentList")
    @ResponseBody
    public List<CommonDTO> departmentList() {

        List<CommonDTO> departmentList = com7060Service.departmentList();

        log.info("##### [부서 컨트롤러] 부서 : {}", departmentList);

        return departmentList;
    }

    /**
     * 직책 조회
     * @return
     */
    @GetMapping("/positionList")
    @ResponseBody
    public List<CommonDTO> positionList(){
        List<CommonDTO> positionList = com7060Service.positionList();

        log.info("##### [직위 컨트롤러] 부서 : {}", positionList);

        return positionList;
    }

    /**
     * 권한 조회
     * @return
     */
    @GetMapping("/roleList")
    @ResponseBody
    public List<CommonDTO> roleList(){
        List<CommonDTO> roleList = com7060Service.roleList();

        log.info("##### [직책 컨트롤러] 부서 : {}", roleList);

        return roleList;
    }

}

