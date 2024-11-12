package kr.co.amonsoft.config.web;

import org.springframework.jdbc.support.JdbcUtils;

import java.io.Serial;
import java.util.HashMap;

@SuppressWarnings("rawtypes")
public class LowerKeyMap extends HashMap {
    @Serial
    private static final long serialVersionUID = -2646044785538215570L;

    @SuppressWarnings("unchecked")
    @Override
    public Object put(Object key, Object value) {
        if (key instanceof String && ((String) key).contains("_")) {
            key = JdbcUtils.convertUnderscoreNameToPropertyName((String) key);
        }
        return super.put(key, value);
    }
}
