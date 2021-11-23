package egovframework.seoul.util;

public class MatcherUtil {

	public static String quoteReplacement(String s) {
		if (s != null) {
			if ((s.indexOf('\\') == -1) && (s.indexOf('$') == -1)) {
				return s;
			}
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < s.length(); i++) {
				char c = s.charAt(i);
				if (c == '\\') {
					sb.append('\\');
					sb.append('\\');
				} else if (c == '$') {
					sb.append('\\');
					sb.append('$');
				} else {
					sb.append(c);
				}
			}
			return sb.toString();
		} else {
			return null;
		}
	}
}