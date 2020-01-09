package kr.or.wabis.directory.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.wabis.admin.directory.service.CmpyDirMtServiceImpl;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;

/**
 * <PRE>
 * !=
 * 기업디렉토리 상세 정보를 수정하는 기능
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Service("cmpyDirServiceImpl")
public class CmpyDirServiceImpl extends CmpyDirMtServiceImpl implements CmpyDirService {
	
	/**
     * 기업정보 중복확인
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Map<String, Object> checkCmpyDir(Map<String, Object> param) throws Exception {
        return cmpyDirDao.checkCmpyDir(param);
    }
    
    /**
     * 기업정보 인증번호 확인
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Map<String, Object> checkCmpyDirAuth(Map<String, Object> param) throws Exception {
        return cmpyDirDao.checkCmpyDirAuth(param);
    }
    
	/**
     * 기업정보를 수정한다. (기업 디렉토리 생성시)
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirForMake(Map<String, Object> param) throws Exception {

        if (!StringUtil.nvl(param.get("manager_tel")).equals("")) {
            param.put("manager_tel", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("manager_tel"))));
        }
        if (!StringUtil.nvl(param.get("manager_email")).equals("")) {
            param.put("manager_email", CryptoUtil.AES_Encode((String) param.get("manager_email")));
        }
        
        return cmpyDirDao.updateCmpyDirForMake(param);
    }
}
