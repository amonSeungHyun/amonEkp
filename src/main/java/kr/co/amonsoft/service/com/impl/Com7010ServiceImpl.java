package kr.co.amonsoft.service.com.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.com.Com7010Mapper;
import kr.co.amonsoft.service.com.Com7010Service;

@Service
public class Com7010ServiceImpl implements Com7010Service {

	@Autowired
	private Com7010Mapper com7010Mapper;	
	
    @Override
    public List<Map<String, Object>> selectCom7010List(Map<String, Object> param) {
        return com7010Mapper.selectCom7010List(param);
    }
    
    @Override
    public List<Map<String, Object>> selectCom7010Code(Map<String, Object> param) {
    	return com7010Mapper.selectCom7010Code(param);
    }

	@Override
	public int insertCom7010(Map<String, Object> param) {
		return com7010Mapper.insertCom7010(param);
	}

	@Override
	public int insertCom7010Detail(Map<String, Object> param) {
		return com7010Mapper.insertCom7010Detail(param);
	}

	@Override
    public void deleteCom7010(List<Map<String, String>> selectedItems) throws Exception {
        for (Map<String, String> item : selectedItems) {
            String codeNumber = item.get("codeNumber");
            String codeDetailNumber = item.get("codeDetailNumber");

            // 각 항목을 삭제
            com7010Mapper.deleteCom7010(codeNumber);
            com7010Mapper.deleteCom7010Detail(codeNumber, codeDetailNumber);
        }
    }

	@Override
	public int selectCom7010Cnt(Map<String, Object> param) {
		return com7010Mapper.selectCom7010Cnt(param);
	}
    
}
