package kr.co.amonsoft;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class AmonIntraApplication {

    public static void main(String[] args) {
        SpringApplication.run(AmonIntraApplication.class, args);
    }

}
