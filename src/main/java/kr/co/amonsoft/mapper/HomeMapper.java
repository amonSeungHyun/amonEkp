package kr.co.amonsoft.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface HomeMapper {
    List<Map<String,Object>> findByTest();
}
