package kr.or.wabis.framework.mybatis;

import java.util.List;
import java.util.Properties;

import org.apache.ibatis.cache.CacheKey;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Intercepts({ @Signature(type = Executor.class, method = "update", args = { MappedStatement.class, Object.class }), @Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class, CacheKey.class, BoundSql.class }), @Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class }) })
public class MybatisLoggingPlugin implements Interceptor {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    private final String sqlId1 = "MsgSttsLDao_fw.searchMsgSttsL";
    private final String sqlId2 = "MsgMDao_fw.searchMsgM";
    
    public Object intercept(Invocation invocation) throws Throwable {
        
        try {
            Object[] args = invocation.getArgs();
            
            MappedStatement mappedStatement = (MappedStatement) args[0];
            Object paramObject = args[1];
            
            if (sqlId1.equals(mappedStatement.getId()) || sqlId2.equals(mappedStatement.getId())) {
                return invocation.proceed(); // except batch's Select-Query
            }
            
            BoundSql boundSql = mappedStatement.getBoundSql(paramObject);
            String sql = boundSql.getSql();
            
            if (paramObject == null) {
                sql = sql.replaceAll("\\?", "null");
            }
            else if (paramObject instanceof Integer || paramObject instanceof Long || paramObject instanceof Float || paramObject instanceof Double) {
                sql = sql.replaceAll("\\?", paramObject.toString());
            }
            else if (paramObject instanceof String) {
                sql = sql.replaceAll("\\?", "'" + paramObject + "'");
            }
            
            else {
                
                List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
                if (paramMapping == null) {
                    return invocation.proceed();
                }
                
                MetaObject metaObject = mappedStatement.getConfiguration().newMetaObject(paramObject);
                
                for (ParameterMapping mapping : paramMapping) {
                    
                    String propertyName = mapping.getProperty();
                    Object valueObj = null;
                    
                    /**
                     * <foreach collection="xxxList" item="item">#{item.authId} </foreach> "__frch_item_0.authId" : org.apache.ibatis.scripting.xmltags.ForEachSqlNode --> ITEM_PREFIX
                     */
                    if (boundSql.hasAdditionalParameter(propertyName)) {
                        valueObj = boundSql.getAdditionalParameter(propertyName);
                        
                    } else {
                        valueObj = metaObject.getValue(propertyName);
                    }
                    
                    if (valueObj == null) {
                        sql = sql.replaceFirst("\\?", "null");
                    } else if (valueObj instanceof String) {
                        sql = sql.replaceFirst("\\?", "'" + (String) valueObj + "'");
                    } else {
                        sql = sql.replaceFirst("\\?", valueObj.toString());
                    }
                }
            }
            
            // SQLFormatter formatter = new SQLFormatter(sql);
            // sql = formatter.format();
            
            log.debug("\n----------------------------------------------------------------------------------------\n{}\n----------------------------------------------------------------------------------------", sql);
            
        } catch (Exception e) {
            log.error("### SQL Foramtting Error in Mybatis Logging Plugin : {}", e.getMessage());
        }
        
        return invocation.proceed();
    }
    
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }
    
    public void setProperties(Properties properties) {
    }
    
}
