package kr.co.amonsoft.config.security;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Getter
@Slf4j
public class CustomUserDetails implements UserDetails {


    private final String userId;
    private final String username;
    private final String password;
    private final String positionName;
    private final String postionCode;
    private final String employmentStatusName;
    private final String employmentStatus;
    private final String organizationName;
    private final String organizationId;
    private final String role;

    public CustomUserDetails(UserEntity userEntity) {
        this.userId = userEntity.getUserId();
        this.username = userEntity.getUsername();
        this.password = userEntity.getPassword();
        this.positionName = userEntity.getPositionName();
        this.postionCode =  userEntity.getPositionCode();
        this.employmentStatusName = userEntity.getEmploymentStatusName();
        this.employmentStatus = userEntity.getEmploymentStatus();
        this.organizationName = userEntity.getOrganizationName();
        this.organizationId = userEntity.getOrganizationId();
        this.role = userEntity.getRole();
    }

    /**
     * 사용자의 특정한 권한을 위해 만들어주는 메소드
     * Role값에 대해 반환해주는 메소드
     * @return
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Position code에 따라 권한 설정
        String roleCd = switch (role) {
            case "01" -> "ROLE_CEO";
            case "02" -> "ROLE_ADMIN";
            case "03" -> "ROLE_LEADER";
            case "04" -> "ROLE_VICE_PRESIDENT";
            case "05" -> "ROLE_STAFF";
            default -> "ROLE_STAFF";
        };
        return List.of(new SimpleGrantedAuthority(roleCd));
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        // 계정의 만료 여부를 설정 (true를 반환하면 만료되지 않음)
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // 계정이 잠겨있지 않도록 설정 (true를 반환하면 잠기지 않음)
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // 인증 정보의 만료 여부 설정 (true를 반환하면 만료되지 않음)
        return true;
    }

    @Override
    public boolean isEnabled() {
        // 계정 활성화 상태를 설정 (true를 반환하면 활성화됨)
        return true;
    }

}
