package kr.co.amonsoft.service.com.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.com.Com1020Mapper;
import kr.co.amonsoft.service.com.Com1020Service;

@Service
public class Com1020ServiceImpl implements Com1020Service {
	
	@Autowired
	private Com1020Mapper com1020Mapper;

	@Override
	public Map<String, Object> selectCom1020(Map<String, Object> param) {
		return com1020Mapper.selectCom1020(param);
	}

	@Override
	public void updateCom1020(Map<String, Object> param) {
		com1020Mapper.updateCom1020(param);	
	}

}
