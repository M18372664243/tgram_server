package com.youzan.pfcase.conf;

public class BusinessException extends RuntimeException{
	
	  private int code;
	  
	  public BusinessException(int code, String msg){
	    super(msg);
	    this.code = code;
	  }
	  
	  public BusinessException(){
	    this(500, null);
	  }
	  
	  public BusinessException(int code){
	    this(code, null);
	  }
	  
	  public BusinessException(String msg){
	    this(500, msg);
	  }
	  
	  public static BusinessException common(String msg){
	    return new BusinessException(502, msg);
	  }
	  
	  public int getCode(){
	    return this.code;
	  }
	  
	  public static void checkNotNull(Object... objects)
	  {
	    int i = 0;
	    for (Object o : objects)
	    {
	      i++;
	      if (o == null) {
	        throw new BusinessException(100100, "第" + i + "个参数为null");
	      }
	    }
	  }
	  
	  public String firstOutStackInfo()
	  {
	    for (StackTraceElement stackTraceElement : getStackTrace()) {
	      if (!stackTraceElement.getClassName().endsWith("BusinessResult")) {
	        return stackTraceElement.toString();
	      }
	    }
	    return "no stack info";
	  }
	 
}
