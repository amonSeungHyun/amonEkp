package kr.co.amonsoft.service.doc;

import com.fasterxml.jackson.core.JsonProcessingException;

import java.math.BigInteger;
import java.util.Map;

public interface Doc1070Service {
    BigInteger insertResignation(String insertResignationRequest, String userId) throws JsonProcessingException;

    Map<String, Object> findResignationDetailsByDocId(BigInteger docId);

}
