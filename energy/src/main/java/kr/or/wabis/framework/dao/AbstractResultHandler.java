package kr.or.wabis.framework.dao;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

public abstract class AbstractResultHandler implements ResultHandler {
    
    public abstract void handleResult(ResultContext context);
    
    public abstract void close();
    
}
