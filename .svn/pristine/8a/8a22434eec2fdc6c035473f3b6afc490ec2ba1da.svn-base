package kr.co.amonsoft.controller;

import kr.co.amonsoft.service.HomeService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
public class LoginController {

    private final HomeService homeService;

    @GetMapping("/login")
    public String home() {
        List<Map<String, Object>> byTest = homeService.findByTest();

        String rawPassword = "1234";
        String encodedPassword = "$2b$12$e9ymVNtBVfJR.qMO3ZmhfOpnH/uK.D1CXBXYQDpTzA0FlFSn6zQCm";

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        boolean isMatch = encoder.matches(rawPassword, encodedPassword);

        System.out.println("Password match: " + isMatch);

        return "login/login";
    }
}
