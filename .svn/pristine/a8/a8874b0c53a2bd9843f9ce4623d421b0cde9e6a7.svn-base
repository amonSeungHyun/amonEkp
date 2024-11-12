package kr.co.amonsoft.config.security;

import org.springframework.boot.CommandLineRunner;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.session.FindByIndexNameSessionRepository;
import org.springframework.session.Session;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class SessionInvalidator implements CommandLineRunner {

    private final SessionRegistry sessionRegistry;

    public SessionInvalidator(SessionRegistry sessionRegistry) {
        this.sessionRegistry = sessionRegistry;
    }

    @Override
    public void run(String... args) throws Exception {
        // 현재 활성화된 모든 세션을 가져와 무효화
        List<Object> allPrincipals = sessionRegistry.getAllPrincipals();
        for (Object principal : allPrincipals) {
            sessionRegistry.getAllSessions(principal, false)
                    .forEach(sessionInformation -> {
                        sessionInformation.expireNow(); // 세션을 만료시킴
                        System.out.println("Invalidating session for principal: " + principal);
                    });
        }
        System.out.println("All sessions invalidated on server startup.");
    }

}
