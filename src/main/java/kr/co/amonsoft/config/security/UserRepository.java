package kr.co.amonsoft.config.security;

import kr.co.amonsoft.dto.com.UserEntityDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserRepository{

    UserEntity findByUserId(String userId);

    UserEntityDTO findAllByUserId(String userId);

}
