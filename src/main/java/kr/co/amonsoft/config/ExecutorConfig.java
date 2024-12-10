package kr.co.amonsoft.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Configuration
public class ExecutorConfig {

    @Bean
    public ExecutorService executorService(){
        //쓰레드 풀 크기
        return Executors.newFixedThreadPool(3);
    }

}
