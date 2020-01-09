package kr.or.wabis.framework.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import kr.or.wabis.framework.dao.CommonDao;
import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.StringUtil;

public class CodeService {
    
    @Resource(name = "commonDao")
    private CommonDao commonDao;
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    private final Map<String, Map<String, List<CommCdVo>>> allCodeMap = new HashMap<>();
    private final Map<String, CommCdVo> directCodeMap = new HashMap<>(); // map-key::english's ET038's USD --> EN_ET038_USD
    
    private final String defaultLanguage = LocaleUtil.getLanguage();
    private String[] languages;
    private boolean useCache = false;
    
    public CodeService() throws Exception {
    }
    
    /**
     * ------------------------------------------------------------------------- --- Setter Start ------------------------------------------------------------------------- --
     */
    public void setLanguages(String[] languages) {
        if (languages != null) {
            this.languages = new String[languages.length];
            for (int idx = 0; idx < languages.length; ++idx) {
                String language = languages[idx];
                Assert.hasText(language, "language must not be empty");
                this.languages[idx] = language.trim().toUpperCase();
            }
        } else {
            this.languages = new String[] { defaultLanguage };
        }
    }
    
    public boolean isUseCache() {
        return useCache;
    }
    
    public void setUseCache(boolean useCache) {
        this.useCache = useCache;
    }
    
    /**
     * searchCommCd != 코드 정보를 조회한다 =!
     *
     * @param vo
     *            CommCdCondVo
     * @return List<CommCdVo>
     * @throws Exception
     */
    public List<CommCdVo> searchCommCd(CommCdCondVo vo) throws Exception {
        
        List<CommCdVo> cdList = null;
        String cdId = vo.getCdId();
        String lngaCd = StringUtil.defaultIfEmpty(vo.getLngaCd(), defaultLanguage);
        String whereCondition = vo.getCodeItemCondition();
        
        if (StringUtil.isEmpty(cdId)) {
            throw new Exception("Code Id is Null.");
        }
        
        /*-----------------------------------------------------------------------------------------
         * If not exists where-cause, return cache != where절 조건이 없으면 캐쉬데이터 리턴 =!
         *----------------------------------------------------------------------------------------*/
        if (useCache && StringUtil.isEmpty(whereCondition)) {
            
            cdList = new ArrayList<>();
            
            List<CommCdVo> tempList = allCodeMap.get(lngaCd).get(cdId);
            if (tempList == null) {
                log.debug("### searchComnCd()::No data::lngaCd:{}, cdId:{}", lngaCd, cdId);
            } else {
                log.debug("### searchComnCd()::Return cache::lngaCd:" + lngaCd + ", cdId:" + cdId + ", size:" + cdList.size());
                cdList.addAll(tempList);
            }
            
            return cdList;
        }
        
        /*-----------------------------------------------------------------------------------------
         * If exists where-cause, query from DB != where절 조건이 있으면 쿼리로 조회 =!
         *----------------------------------------------------------------------------------------*/
        else {
            Map<String, String> map = strToMap(vo);
            cdList = commonDao.selectList("CodeDao_fw.searchComnCd", map);
        }
        
        for (CommCdVo commCdVo : cdList) {
            this.makeJqueryAutoComplete(commCdVo); // For Jquery AutoComplete
        }
        
        return cdList;
    }
    
    /**
     * For Jquery-ui Autocomplete.
     * 
     * @param commCdVo
     */
    private void makeJqueryAutoComplete(CommCdVo commCdVo) {
        commCdVo.setLabel("[" + commCdVo.getCdItemId() + "] " + commCdVo.getCdItemNm());
        commCdVo.setValue(commCdVo.getCdItemId());
        commCdVo.setText(commCdVo.getCdItemNm());
        commCdVo.setDesc(commCdVo.getCdItemDesc());
    }
    
    public CommCdVo searchCommCdItem(String cdId, String cdItemId, String language) throws Exception {
        if (useCache) {
            return directCodeMap.get(language + "_" + cdId + "_" + cdItemId);
            
        } else {
            
            if (StringUtil.isBlank(cdItemId)) {
                return null;
                
            } else {
                CommCdCondVo vo = new CommCdCondVo();
                
                vo.setCdId(cdId);
                vo.setCdItemId(cdItemId);
                vo.setLngaCd(language);
                
                List<CommCdVo> lst = this.searchCommCd(vo);
                return lst.isEmpty() ? null : lst.get(0);
            }
        }
    }
    
    public String searchCommCdItemNm(String cdId, String cdItemId, String language) throws Exception {
        CommCdVo commCdVo = this.searchCommCdItem(cdId, cdItemId, language);
        return commCdVo == null ? "" : commCdVo.getCdItemNm();
    }
    
    /**
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    private Map<String, String> strToMap(CommCdCondVo vo) throws Exception {
        
        String cdId = vo.getCdId();
        String cdItemId = vo.getCdItemId();
        String lngaCd = vo.getLngaCd();
        String whereCondition = vo.getCodeItemCondition();
        
        log.debug("### strToMap::whereCondition:" + whereCondition + ", cdId:" + cdId + ", cdItemId:" + cdItemId);
        log.debug("### strToMap::lngaCd:{}", lngaCd);
        
        Map<String, String> map = new HashMap<>();
        map.put("cdId", cdId);
        map.put("cdItemId", cdItemId);
        map.put("lngaCd", lngaCd);
        
        String[] arr = StringUtil.split(whereCondition, ",");
        
        if (arr != null) {
            for (String condition : arr) {
                String[] temp = StringUtil.split(condition, "=");
                if (temp.length == 1) {
                    map.put(temp[0], "");
                } else {
                    map.put(temp[0], temp[1]);
                }
            }
        }
        
        return map;
    }
    
}
