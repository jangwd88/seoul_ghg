package egovframework.seoul.interceptor;

/**
 * 공통 상수 정의
 * @author cslee
 *
 */
public class BizConst {
    
    public static final String _HEADER_AUTH = "Authorization";
    
    public static final String _CHARSET_UTF8 = "UTF-8";
    
    public static final String _HTTPATTR_KEY_KEYVALUE = "keyValue";
    
    public static final String _RESULT_CODE_SUCCESS = "00";
    public static final String _RESULT_CODE_FAILURE = "-1";
    
    public static final String _SESSION_KEY_USERID    = "ssUserId";
    public static final String _SESSION_KEY_USERNAME  = "ssUserName";
    public static final String _SESSION_KEY_USERROLEID  = "ssUserRoleId";
  
    public static final String _URL_SPACE_MAIN  = "/space/selectArch.do";
    
   
    public static final String _URL_LOGIN = "/main/login.do";
    public static final String _URL_INTRO = "/main/intro.do";
    
    public static final String _ATTR_SERVER_TYPE  = "SERVER_TYPE";
    
    
    private BizConst() {}
}
