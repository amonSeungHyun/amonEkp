package kr.co.amonsoft.config.security;

import kr.co.amonsoft.dto.com.UserEntityDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@Component
@Slf4j
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        // successResult 호출 후 사용자 데이터가 없으면 리다이렉트 중지
        if(!successResult(request, response, authentication)){// 사용자 리턴 데이터
            return;
        };

        // 사용자 권한에 따라 다른 경로로 리다이렉트
        if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_CEO"))) {
            log.info("[onAuthenticationSuccess] 대표로 들어옴 ***********************************");
            response.sendRedirect("/docList");
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_VICE_PRESIDENT"))) {
            log.info("[onAuthenticationSuccess] 부서장으로 들어옴 ***********************************");
            response.sendRedirect("/admin/members/com7050");
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
            log.info("[onAuthenticationSuccess] 경영관리자로 들어옴 ***********************************");
            response.sendRedirect("/docList");
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_LEADER"))) {
            log.info("[onAuthenticationSuccess] 팀장으로 들어옴 ***********************************");
            response.sendRedirect("/docList");
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_STAFF"))) {
            log.info("[onAuthenticationSuccess] 직원으로 들어옴 ***********************************");
            response.sendRedirect("/admin/members/com7050");
        } else {
            log.warn("[onAuthenticationSuccess] 권한이 없는 사용자가 로그인 시도함 **************************");
            // 권한이 없는 사용자에 대한 처리
            response.sendRedirect("/accessDenied"); // 권한이 없음을 알리는 페이지로 리디렉션
        }
    }



    /**
     * 사용자 리턴 데이터
     *
     * @param response
     * @param authentication
     * @throws IOException
     */
    private boolean  successResult(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException {

        // CustomUserDetails에서 userId 가져오기
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = userDetails.getUserId();

        UserEntityDTO userEntity = userRepository.findAllByUserId(userId); // 사용자 정보 조회

        if (userEntity != null) {
            // 사용자 정보를 세션에 저장
            request.getSession().setAttribute("userId", userEntity.getUserId());
            request.getSession().setAttribute("username", userEntity.getUserName());
            request.getSession().setAttribute("positionNm", userEntity.getPositionNm());
            request.getSession().setAttribute("phoneNo", userEntity.getPhoneNo());
            request.getSession().setAttribute("department", userEntity.getDepartment());
            request.getSession().setAttribute("address", userEntity.getAddress());
            request.getSession().setAttribute("roleNm", userEntity.getRoleNm());
            request.getSession().setAttribute("IP", request.getRemoteAddr());
            log.info("[onAuthenticationSuccess] 사용자 정보 세션에 저장 완료: {}", userEntity);
            return true;
        } else {
            log.warn("[onAuthenticationSuccess] 사용자 정보를 찾을 수 없습니다: {}", userId);
            response.sendRedirect("/accessDenied"); // 사용자 정보가 없을 경우 접근 거부 페이지로 리디렉션
            return false;

        }
    }


}
