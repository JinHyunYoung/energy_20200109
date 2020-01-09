package kr.or.wabis.framework.util;

import java.util.ArrayList;
import java.util.List;

import kr.or.wabis.framework.code.CodeService;
import kr.or.wabis.framework.code.CommCdCondVo;
import kr.or.wabis.framework.code.CommCdVo;

public class CodeUtil {
    
    private static CodeService codeService;
    
    public void setCodeService(CodeService codeService) {
        CodeUtil.codeService = codeService;
    }
    
    public static List<CommCdVo> getCode(String cdId) throws Exception {
        return getCode(cdId, LocaleUtil.getLanguage());
    }
    
    public static List<CommCdVo> getCode(String cdId, String lngaCd) throws Exception {
        CommCdCondVo vo = new CommCdCondVo();
        vo.setCdId(cdId);
        vo.setLngaCd(lngaCd);
        return getCode(vo);
    }
    
    public static List<CommCdVo> getCodeAny(String[] cdIds) throws Exception {
        return getCodeAny(cdIds, LocaleUtil.getLanguage());
    }
    
    public static List<CommCdVo> getCodeAny(String[] cdIds, String lngaCd) throws Exception {
        List<CommCdVo> list = new ArrayList<>();
        if (cdIds != null) {
            for (String cdId : cdIds) {
                list.addAll(getCode(cdId, lngaCd));
            }
        }
        return list;
    }
    
    public static List<CommCdVo> getCode(CommCdCondVo vo) throws Exception {
        return codeService.searchCommCd(vo);
    }
    
    public static CommCdVo getCodeItem(String cdId, String cdItemId) throws Exception {
        return getCodeItem(cdId, cdItemId, LocaleUtil.getLanguage());
    }
    
    public static CommCdVo getCodeItem(String cdId, String cdItemId, String lngaCd) throws Exception {
        return codeService.searchCommCdItem(cdId, cdItemId, lngaCd);
    }
    
    public static String getCodeItemNm(String cdId, String cdItemId) throws Exception {
        return getCodeItemNm(cdId, cdItemId, LocaleUtil.getLanguage());
    }
    
    public static String getCodeItemNm(String cdId, String cdItemId, String lngaCd) throws Exception {
        CommCdVo vo = getCodeItem(cdId, cdItemId, lngaCd);
        if (vo == null) {
            return null;
        } else {
            return vo.getCdItemNm();
        }
    }
}
