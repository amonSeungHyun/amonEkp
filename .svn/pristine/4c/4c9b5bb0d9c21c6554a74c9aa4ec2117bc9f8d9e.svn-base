package kr.co.amonsoft.service.impl;

import kr.co.amonsoft.mapper.HomeMapper;
import kr.co.amonsoft.service.HomeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class HomeServiceImpl implements HomeService {

    private final HomeMapper homeMapper;


    @Override
    public List<Map<String, Object>> findByTest() {
        return homeMapper.findByTest();
    }

}
