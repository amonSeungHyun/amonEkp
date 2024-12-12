package kr.co.amonsoft.scheduler;

import kr.co.amonsoft.mapper.doc.Doc1070Mapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Log4j2
@Component
public class IntraScheduler {

    private final Doc1070Mapper doc1070Mapper;

    /**
     * 퇴사 스케줄링 처리
     */
    @Scheduled(cron = "0 0 0 * * *")
    public void resignedUserScheduler() {
        log.info("resignedUserScheduler");
        List<Map<String, Object>> resignedUserList = doc1070Mapper.selectResignedUserList();
        doc1070Mapper.updateUserStatus(resignedUserList);
    }
}
