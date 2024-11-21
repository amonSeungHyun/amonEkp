package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1060Mapper {

    void insertTransportExpense(Map<String, Object> param);

    List<Map<String,Object>> findTransportExpenseDetailsByDocId(BigInteger docId);

}
