package kr.co.amonsoft.config.security;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Slf4j
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
    private final CustomUserDetailsService customUserDetailsService;

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        log.info("[+] WebSecurityConfig Start !!! ");
        http
                .authorizeRequests(auth -> auth
                        .antMatchers("/css/**", "/js/**", "/images/**").permitAll()
                        .antMatchers("/login", "/loginProc").permitAll()
//                        .antMatchers("/workflow/**").hasAnyRole("CEO", "ADMIN", "LEADER", "VICE_PRESIDENT", "STAFF")
//                        .antMatchers("/admin/**").hasAnyRole("CEO", "ADMIN", "EMPLOYEE", "VICE_PRESIDENT", "STAFF")
                        .antMatchers("/").permitAll()
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/loginProc")
                        .usernameParameter("userId") // 여기서 폼 필드명을 "userId"로 매핑
                        .passwordParameter("password") // 비밀번호 필드명도 필요시 설정 가능
                        .successHandler(customAuthenticationSuccessHandler)
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                        .logoutSuccessUrl("/login")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS) // 항상 새로운 세션 생성
                        .invalidSessionUrl("/login") // 세션이 유효하지 않을 때 이동할 페이지
                        .maximumSessions(1) // 최대 허용 가능 세션 수, (-1: 무제한)
                        .maxSessionsPreventsLogin(false) // 동시 로그인 차단, false: 기존 세션 만료(default)
                        .expiredUrl("/expired") // 세션이 만료되었을 때 이동할 페이지
                )
                .csrf(AbstractHttpConfigurer::disable);

        log.info("[+] WebSecurityConfig End !!! ");
        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder =
                http.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder
                .userDetailsService(customUserDetailsService)
                .passwordEncoder(bCryptPasswordEncoder());
        return authenticationManagerBuilder.build();
    }
}
