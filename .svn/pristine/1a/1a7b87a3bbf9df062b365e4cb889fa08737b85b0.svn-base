package kr.co.amonsoft.service.com.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.mapper.com.Com7050Mapper;
import kr.co.amonsoft.mapper.com.Com7080Mapper;
import kr.co.amonsoft.service.com.Com7080Service;

@Service
public class Com7080ServiceImpl implements Com7080Service {
	
	@Autowired
	private Com7080Mapper com7080Mapper;	
	
    @Override
    public List<MemberListDTO> selectCom7080List(Map<String, Object> param) {
        return com7080Mapper.selectCom7080List(param);
    }

	@Override
	public int insertCom7080(Map<String, Object> param) throws Exception {
		return com7080Mapper.insertCom7080(param);
	}

}
