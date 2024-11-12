package kr.co.amonsoft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class NoticeController {

    @GetMapping(value = "/admin/jinji/notice/noticeList")
    public String noticeList(HttpServletRequest request, ModelAndView mav) {
        return "/admin/jinji/notice/noticeList";
    }
    
    @GetMapping(value = "/admin/jinji/notice/depNoticeList")
    public String depNoticList(HttpServletRequest request, ModelAndView mav) {
        return "/admin/jinji/notice/depNoticeList";
    }

}
