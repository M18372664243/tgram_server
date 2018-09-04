package com.youzan.pfcase.conf;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.youzan.pfcase.conf.BusinessException;

public class BusinessResult<T> implements Serializable {
	  private static final long serialVersionUID = -1L;
	  private T data;
	  private int code;
	  private String msg;
	  public static final int successCode = 200;
	  public static final int defaultErrorCode = 500;
	  public static final int commonErrorCode = 502;
	  public static final int serviceErrorCode = 400;
	  public static final int concurrentErrorCode = 999;
	  
	  public static final int usernameExist = 301;   //用户名存在
	  public static final int passwordShort = 302;   //密码太简单
	  public static final int loginInvalid = 303;   //用户名或密码错误

	  public static final int resultSuccess = 1;
	  
	  public BusinessResult()
	  {
	    this(null, 200, null);
	  }
	  
	  public BusinessResult(T data)
	  {
	    this(data, 200, null);
	  }
	  
	  public BusinessResult(T data, int code)
	  {
	    this(data, code, null);
	  }
	  
	  public BusinessResult(T data, String msg)
	  {
	    this(data, 500, msg);
	  }
	  
	  public BusinessResult(T data, int code, String msg)
	  {
	    this.data = data;
	    this.code = code;
	    this.msg = msg;
	  }
	  
	  public BusinessResult(BusinessException be)
	  {
	    this(null, be.getCode(), be.getMessage());
	  }
	  
	  @Deprecated
	  public T getData()
	  {
	    return (T)this.data;
	  }
	  
	  public T checkAndGetData()
	  {
	    check();
	    return (T)this.data;
	  }
	  
	  public Map<String, Object> checkAndWrapList()
	  {
	    return checkAndWrapData("list");
	  }
	  
	  public Map<String, Object> checkAndWrapData(String key)
	  {
	    Map<String, Object> result = new HashMap();
	    result.put(key, checkAndGetData());
	    return result;
	  }
	  
	  public void check()
	  {
	    if (!isSuccess()) {
	      throw new BusinessException(this.code, this.msg);
	    }
	  }
	  
	  public boolean isSuccess()
	  {
	    return this.code == 200;
	  }
	  
	  public String getMsg()
	  {
	    return this.msg;
	  }
	  
	  public int getCode()
	  {
	    return this.code;
	  }
}
