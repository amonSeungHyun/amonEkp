package kr.co.amonsoft.service.com.impl;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.com.Com1010Mapper;
import kr.co.amonsoft.service.com.Com1010Service;

@Service
public class Com1010ServiceImpl implements Com1010Service {
	
	@Autowired
	private Com1010Mapper com1010Mapper;
	
	@Override
	public List<Map<String, Object>> selectCom1010List(Map<String, Object> param) {
		return com1010Mapper.selectCom1010List(param);
	}

	@Override
	public int selectCom1010ListCnt(Map<String, Object> param) {
		return com1010Mapper.selectCom1010ListCnt(param);
	}

	@Override
	public BigInteger insertCom1010(Map<String, Object> param) {
		com1010Mapper.insertCom1010(param);
		BigInteger boardNumber = (BigInteger) param.get("boardNumber");
		return boardNumber;
		
	}

	@Override
	public void deleteCom1010(Map<String, Object> param) {
		com1010Mapper.deleteCom1010(param);
		
	}

}
