package egovframework.seoul.util;

import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;

public class RequestUtil {

	/**
	 * HttpServletRequest 객체를 받아 getParameterNames 깂을 HashMap 타입으로 리턴
	 * 
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings({ "rawtypes" })
	public static HashMap<String, Object> paramToHashMap(HttpServletRequest request) {
		HashMap<String, Object> param = new HashMap<String, Object>();

		Enumeration penum = request.getParameterNames();

		String key = null;
		String value = null;

		while (penum.hasMoreElements()) {
			key = (String) penum.nextElement();
			value = (new String(request.getParameter(key)) == null) ? "" : new String(request.getParameter(key));
			value = MatcherUtil.quoteReplacement(value);
			value = value.replaceAll("&quot;", "\"");
			value = value.replaceAll("&apos;", "\'");
			
			param.put(key, value);
			
			
		}

		return param;
	}
}