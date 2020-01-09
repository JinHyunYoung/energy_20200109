package kr.or.wabis.admin.directory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.directory.CmpyDirCertDao;
import kr.or.wabis.dao.directory.CmpyDirCslfDao;
import kr.or.wabis.dao.directory.CmpyDirDao;
import kr.or.wabis.dao.directory.CmpyDirExpDao;
import kr.or.wabis.dao.directory.CmpyDirFncDao;
import kr.or.wabis.dao.directory.CmpyDirHstrDao;
import kr.or.wabis.dao.directory.CmpyDirPrdtDao;
import kr.or.wabis.dao.directory.CmpyDirPrdtPctrDao;
import kr.or.wabis.dao.directory.CmpyDirVdoDao;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.util.email.DirectoryApprovalService;
import kr.or.wabis.framework.util.email.DirectoryRejectService;

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
@Service("cmpyDirMtServiceImpl")
public class CmpyDirMtServiceImpl implements CmpyDirMtService {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name = "cmpyDirDao")
    protected CmpyDirDao cmpyDirDao;
    
    @Resource(name = "cmpyDirExpDao")
    protected CmpyDirExpDao cmpyDirExpDao;
    
    @Resource(name = "cmpyDirHstrDao")
    protected CmpyDirHstrDao cmpyDirHstrDao;
    
    @Resource(name = "cmpyDirCslfDao")
    protected CmpyDirCslfDao cmpyDirCslfDao;
    
    @Resource(name = "cmpyDirCertDao")
    protected CmpyDirCertDao cmpyDirCertDao;
    
    @Resource(name = "cmpyDirFncDao")
    protected CmpyDirFncDao cmpyDirFncDao;
    
    @Resource(name = "cmpyDirVdoDao")
    protected CmpyDirVdoDao cmpyDirVdoDao;
        
    @Resource(name = "cmpyDirPrdtDao")
    protected CmpyDirPrdtDao cmpyDirPrdtDao;
    
    @Resource(name = "cmpyDirPrdtPctrDao")
    protected CmpyDirPrdtPctrDao cmpyDirPrdtPctrDao;
    
    /**
     * 기업디렉토리 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirVo>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> searchCmpyDirPageList(Map<String, Object> param) throws Exception {
        return cmpyDirDao.searchCmpyDirPageList(param);
    }
    
    /**
     * 기업디렉토리 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirVo>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirListExcel(Map<String, Object> param) throws Exception {
        return cmpyDirDao.selectCmpyDirListExcel(param);
    }
    
    /**
     * 기업디렉토리 상세조회
     *
     * @param Map<String, Object> param
     * @return CmpyDirInfoVo
     * @throws Exception
     */
    @Override
    public Map<String, Object> searchCmpyDir(Map<String, Object> param) throws Exception {
        
        Map<String, Object> map = cmpyDirDao.selectCmpyDir(param);
        
        if (map.get("tel") != null) {
        	
    		String tel = StringUtil.nvl(map.get("tel"));
			String[] tels = StringUtil.split(tel, "-");
			
			map.put("tel_1", tels[0]);
			map.put("tel_2", tels[1]);
			map.put("tel_3", tels[2]);    		
            map.put("tel", tel);
        }
        
        if (map.get("fax") != null) {
        	
    		String fax = StringUtil.nvl(map.get("fax"));
			String[] faxs = StringUtil.split(fax, "-");
			
			map.put("fax_1", faxs[0]);
			map.put("fax_2", faxs[1]);
			map.put("fax_3", faxs[2]);    		
            map.put("fax", fax);
        }
        
        if (map.get("manager_tel") != null) {
        	
    		String manager_tel = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("manager_tel")));
			String[] tel = StringUtil.split(manager_tel, "-");
			
			map.put("manager_tel_1", tel[0]);
			map.put("manager_tel_2", tel[1]);
			map.put("manager_tel_3", tel[2]);    		
            map.put("manager_tel", manager_tel);
        }
        
        if (map.get("manager_email") != null) {

    		String manager_email = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("manager_email")));
			String[] email = StringUtil.split(manager_email, "@");
    		
			map.put("manager_email_1", email[0]);
			map.put("manager_email_2", email[1]);
            map.put("manager_email", manager_email);
        }
        
        return map;
    }
    
    @Override
	public Map<String, Object> searchCmpyDirExpCountry(Map<String, Object> param) throws Exception {
		return cmpyDirDao.selectCmpyDir(param);
	}

	/**
     * 중복확인
     *
     * @param Map<String, Object> param
     * @return Map<String, Object> 
     * @throws Exception
     */
    public Map<String, Object> confirmDupl(Map<String, Object> param) throws Exception {
        return cmpyDirDao.selectCmpyDir(param);
    }
    
    /**
     * 기업디렉토리승인 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
	public Integer approveCmpyDir(Map<String, Object> param) throws Exception {
		
		Integer result = 0;

		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);
		
		String cmpy_nm = StringUtil.nvl(param.get("cmpy_nm"), null);
		String cmpy_nm_en = StringUtil.nvl(param.get("cmpy_nm_en"), null);
		String biz_reg_no = StringUtil.nvl(param.get("biz_reg_no"), null);
		String ceo_nm = StringUtil.nvl(param.get("ceo_nm"), null);
		String manager_email = StringUtil.nvl(param.get("manager_email"), null);
		
		if( dir_sn != null){		
			String[] dir_sn_arr = dir_sn.split(",");
			
			String[] cmpy_nm_arr = cmpy_nm.split(",");
			String[] cmpy_nm_en_arr = cmpy_nm_en.split(",");
			String[] biz_reg_no_arr = biz_reg_no.split(",");
			String[] ceo_nm_arr = ceo_nm.split(",");
			String[] manager_email_arr = manager_email.split(",");
			
			
			for (int i = 0; i < dir_sn_arr.length; i++) {
				Map<String, Object> updateParam = new HashMap<String, Object>();
				updateParam.put("dir_sn", dir_sn_arr[i]);
				updateParam.put("app_stt_cd", param.get("app_stt_cd"));
				updateParam.put("auth_no", param.get("auth_no"));

				result = cmpyDirDao.approveCmpyDir(updateParam);
				
				if(result > 0) {
					updateParam.put("cmpy_nm", cmpy_nm_arr[i]);
					updateParam.put("cmpy_nm_en", cmpy_nm_en_arr[i]);
					updateParam.put("biz_reg_no", biz_reg_no_arr[i]);
					updateParam.put("ceo_nm", ceo_nm_arr[i]);
					
					if(manager_email_arr[i] != null && !"".equals(manager_email_arr[i])) {
			    		String receive_email = CryptoUtil.AES_Decode(StringUtil.nvl(manager_email_arr[i]));
						new DirectoryApprovalService().sendEmail(receive_email, updateParam);	
					}
				}
			}
		}		
		
        return result;
    }
    
    /**
     * 기업디렉토리반려 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
	public Integer rejectCmpyDir(Map<String, Object> param) throws Exception {
		
		Integer result = 0;

		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);
		
		String cmpy_nm = StringUtil.nvl(param.get("cmpy_nm"), null);
		String cmpy_nm_en = StringUtil.nvl(param.get("cmpy_nm_en"), null);
		String biz_reg_no = StringUtil.nvl(param.get("biz_reg_no"), null);
		String ceo_nm = StringUtil.nvl(param.get("ceo_nm"), null);
		
		String app_dt = StringUtil.nvl(param.get("app_dt"), null);
		String manager_nm = StringUtil.nvl(param.get("manager_nm"), null);
		
		String manager_email = StringUtil.nvl(param.get("manager_email"), null);
		
		if( dir_sn != null){		
			String[] dir_sn_arr = dir_sn.split(",");
			
			String[] cmpy_nm_arr = cmpy_nm.split(",");
			String[] cmpy_nm_en_arr = cmpy_nm_en.split(",");
			String[] biz_reg_no_arr = biz_reg_no.split(",");
			String[] ceo_nm_arr = ceo_nm.split(",");
			
			String[] app_dt_arr = app_dt.split(",");
			String[] manager_nm_arr = manager_nm.split(",");
			
			String[] manager_email_arr = manager_email.split(",");
			
			for (int i = 0; i < dir_sn_arr.length; i++) {
				Map<String, Object> updateParam = new HashMap<String, Object>();
				updateParam.put("dir_sn", dir_sn_arr[i]);
				updateParam.put("app_stt_cd", param.get("app_stt_cd"));
				updateParam.put("rjt_rsn", StringUtil.nvl(param.get("rjt_rsn"), null));
	
				result = cmpyDirDao.rejectCmpyDir(updateParam);
				
				if(result > 0) {
					updateParam.put("cmpy_nm", cmpy_nm_arr[i]);
					updateParam.put("cmpy_nm_en", cmpy_nm_en_arr[i]);
					updateParam.put("biz_reg_no", biz_reg_no_arr[i]);
					updateParam.put("ceo_nm", ceo_nm_arr[i]);
					
					updateParam.put("app_dt", app_dt_arr[i]);
					updateParam.put("manager_nm", manager_nm_arr[i]);
					
					if(manager_email_arr[i] != null && !"".equals(manager_email_arr[i])) {
			    		String receive_email = CryptoUtil.AES_Decode(StringUtil.nvl(manager_email_arr[i]));
						new DirectoryRejectService().sendEmail(receive_email, updateParam);	
					}
				}
			}
		}		
		
        return result;
    }
    
    /**
     * 기업디렉토리 회원여부 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
	public Integer updateMember(Map<String, Object> param) throws Exception {
		
		Integer result = 0;

		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);
		
		if( dir_sn != null){		
			String[] dir_sn_arr = dir_sn.split(",");
			for (int i = 0; i < dir_sn_arr.length; i++) {
				Map<String, Object> updateParam = new HashMap<String, Object>();
				updateParam.put("dir_sn", dir_sn_arr[i]);
				updateParam.put("member_yn", param.get("member_yn"));
	
				result = cmpyDirDao.updateMember(updateParam);
			}
		}	
		
        return result;
    }
	
    /**
     * 기업디렉토리 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDir(Map<String, Object> param) throws Exception {
    	
		Integer result = 0;

		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);
		
		if( dir_sn != null){		
			String[] dir_sn_arr = dir_sn.split(",");
			for (int i = 0; i < dir_sn_arr.length; i++) {
				Map<String, Object> updateParam = new HashMap<String, Object>();
				updateParam.put("dir_sn", dir_sn_arr[i]);
	
				result = cmpyDirDao.deleteCmpyDir(updateParam);
			}
		}	
		
        return result;
    }

	/**
     * 기업정보 상세조회
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    @Override
    public Map<String, Object> selectCmpyDir(Map<String, Object> param) throws Exception {
        return cmpyDirDao.selectCmpyDir(param);
    }
    
    /**
     * 기업정보 등록
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDir(Map<String, Object> param) throws Exception {

        if (!StringUtil.nvl(param.get("manager_tel")).equals("")) {
            param.put("manager_tel", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("manager_tel"))));
        }
        if (!StringUtil.nvl(param.get("manager_email")).equals("")) {
            param.put("manager_email", CryptoUtil.AES_Encode((String) param.get("manager_email")));
        }
        
        return cmpyDirDao.insertCmpyDir(param);
    }
    
    /**
     * 기업정보 수정
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDir(Map<String, Object> param) throws Exception {
    	int rv = 0;

        rv += cmpyDirDao.updateCmpyDir(param);
        
        rv += cmpyDirCslfDao.deleteCmpyDirCslf(param);
                
        if(param.get( "sub_inds_tp_cd" ) != null && param.get( "sub_inds_tp_cd" ) != null ){
        	
        	Object obj_inds_tp_cd = param.get( "sub_inds_tp_cd" );

        	String[] array_inds_tp_cd = null;
        	String[] array_wbiz_tp_l_cd = null;
        	String[] array_wbiz_tp_m_cd = null;
        	String[] array_wbiz_tp_s_cd = null;
        	
        	if(obj_inds_tp_cd instanceof String){
        		array_inds_tp_cd = param.get( "sub_inds_tp_cd" ).toString().split( "," );
        		array_wbiz_tp_l_cd = param.get( "sub_wbiz_tp_l_cd" ).toString().split( "," ); 
        		array_wbiz_tp_m_cd = param.get( "sub_wbiz_tp_m_cd" ).toString().split( "," );
        		array_wbiz_tp_s_cd = param.get( "sub_wbiz_tp_s_cd" ).toString().split( "," ); 
        	}
        	
        	else if(obj_inds_tp_cd instanceof String[]){
        		array_inds_tp_cd = (String[]) param.get( "sub_inds_tp_cd" );
        		array_wbiz_tp_l_cd = (String[]) param.get( "sub_wbiz_tp_l_cd" );
        		array_wbiz_tp_m_cd = (String[]) param.get( "sub_wbiz_tp_m_cd" );
        		array_wbiz_tp_s_cd = (String[]) param.get( "sub_wbiz_tp_s_cd" );
        	}
        	
        	if(array_inds_tp_cd != null){    		
		    	for( int i = 0 ; i < array_inds_tp_cd.length ; i++ ){    
		    		
		    		param.put( "sub_inds_tp_cd" ,array_inds_tp_cd[i]);     		
		    		param.put( "sub_wbiz_tp_l_cd" , array_wbiz_tp_l_cd[i]);	
		    		param.put( "sub_wbiz_tp_m_cd" , array_wbiz_tp_m_cd[i]);     		
		    		param.put( "sub_wbiz_tp_s_cd" , array_wbiz_tp_s_cd[i]);	
		    		
		    		rv += cmpyDirCslfDao.insertCmpyDirCslf(param);
		    	}
        	}
        }
        
		rv += cmpyDirDao.updateCmpyDirExpCountry(param);

		return new Integer(rv);
    	
    }
    
    /**
     * 담당자정보 상세조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return CmpyDirVo
     * @throws Exception
     */
    @Override
	public Map<String, Object> selectCmpyDirManager(Map<String, Object> param) throws Exception {
    	
    	Map<String, Object> map = cmpyDirDao.selectCmpyDirManager(param);
        
        if (map.get("manager_tel") != null) {
        	
    		String manager_tel = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("manager_tel")));
			String[] tel = StringUtil.split(manager_tel, "-");
			
			map.put("manager_tel_1", tel[0]);
			map.put("manager_tel_2", tel[1]);
			map.put("manager_tel_3", tel[2]);    		
            map.put("manager_tel", manager_tel);
        }
        
        if (map.get("manager_email") != null) {

    		String manager_email = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("manager_email")));
			String[] email = StringUtil.split(manager_email, "@");
    		
			map.put("manager_email_1", email[0]);
			map.put("manager_email_2", email[1]);
            map.put("manager_email", manager_email);
        }
    	
    	return map;
    }
    
    /**
     * 담당자정보 저장
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirManager(Map<String, Object> param) throws Exception {

        if (!StringUtil.nvl(param.get("manager_tel")).equals("")) {
            param.put("manager_tel", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("manager_tel"))));
        }
        if (!StringUtil.nvl(param.get("manager_email")).equals("")) {
            param.put("manager_email", CryptoUtil.AES_Encode((String) param.get("manager_email")));
        }
        
        return cmpyDirDao.updateCmpyDirManager(param);
    }
    
    /**
     * 찾아오시는길 상세조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return CmpyDirVo
     * @throws Exception
     */
    @Override
	public Map<String, Object> selectCmpyDirMap(Map<String, Object> param) throws Exception {
        return cmpyDirDao.selectCmpyDirMap(param);
    }
    
    /**
     * 찾아오시는길 저장
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirMap(Map<String, Object> param) throws Exception {
        return cmpyDirDao.updateCmpyDirMap(param);
    }
    
    /**
     * 실적내역 상세조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public Map<String, Object> selectCmpyDirBrec(Map<String, Object> param) throws Exception {
        return cmpyDirDao.selectCmpyDirBrec(param);
    }
    
    /**
     * 실적현황 수정
     *
     * @param List<CmpyDirBrecVo> iCmpyDirBrecList
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirBrec(Map<String, Object> param) throws Exception {
		return cmpyDirDao.updateCmpyDirBrec(param);
    }
    
    /**
     * 물산업분류 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirFncVo>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirCslfList(Map<String, Object> param) throws Exception {
        return cmpyDirCslfDao.selectCmpyDirCslfList(param);
    }
    
    /**
     * 물산업분류 등록
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirCslf(Map<String, Object> param) throws Exception {        
        return cmpyDirCslfDao.insertCmpyDirCslf(param);
    }
    
    /**
     * 물산업분류 수정
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirCslf(Map<String, Object> param) throws Exception {        
        return cmpyDirCslfDao.updateCmpyDirCslf(param);
    }
    
    /**
     * 물산업분류 삭제
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirCslf(Map<String, Object> param) throws Exception {        
        return cmpyDirCslfDao.deleteCmpyDirCslf(param);
    }
    
    /**
     * 재무현황 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirFncVo>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirFncList(Map<String, Object> param) throws Exception {
        return cmpyDirFncDao.selectCmpyDirFncList(param);
    }
    
    /**
     * 재무현황 등록
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirFnc(Map<String, Object> param) throws Exception {        
        return cmpyDirFncDao.insertCmpyDirFnc(param);
    }
    
    /**
     * 재무현황 수정
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirFnc(Map<String, Object> param) throws Exception { 

        int rv = 0;

        rv += cmpyDirFncDao.deleteCmpyDirFnc(param);
                
        if(param.get( "fnc_yy" ) != null && param.get( "fnc_amount" ) != null ){
        	
        	Object obj_fnc_yy = param.get( "fnc_yy" );
    		        	
        	String[] array_fnc_yy = null;
        	String[] array_fnc_amount = null;
        	
        	if(obj_fnc_yy instanceof String){
            	array_fnc_yy = param.get( "fnc_yy" ).toString().split( "," );
            	array_fnc_amount = param.get( "fnc_amount" ).toString().split( "," );        		
        	}
        	
        	else if(obj_fnc_yy instanceof String[]){
        		array_fnc_yy = (String[]) param.get( "fnc_yy" );
        		array_fnc_amount = (String[]) param.get( "fnc_amount" );
        	}
        	
        	if(array_fnc_yy != null){    		
		    	for( int i = 0 ; i < array_fnc_yy.length ; i++ ){    
		    		
		    		param.put( "fnc_yy" , array_fnc_yy[i]);     		
		    		param.put( "fnc_amount" , array_fnc_amount[i]);
		    		
		    		rv += cmpyDirFncDao.insertCmpyDirFnc(param);
		    	}
        	}
        }
			
        return new Integer(rv);
    }
    
    /**
     * 재무현황 삭제
     *
     * @param (Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirFnc(Map<String, Object> param) throws Exception {        
        return cmpyDirFncDao.deleteCmpyDirFnc(param);
    }
    
    /**
     * 수출현황 조회
     *
     * @param ist<Map<String, Object>>
     * @return Map<String, Object> param
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirExpList(Map<String, Object> param) throws Exception {
        return cmpyDirExpDao.selectCmpyDirExpList(param);
    }
    
    /**
     * 수출현황 등록
     *
     * @param List<CmpyDirExpVo> iCmpyDirExpList
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirExp(Map<String, Object> param) throws Exception {        
        return cmpyDirExpDao.insertCmpyDirExp(param);
    }
    
    /**
     * 수출현황 수정
     *
     * @param List<CmpyDirExpVo> iCmpyDirExpList
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirExp(Map<String, Object> param) throws Exception {  

        int rv = 0;
		if ("cmpyDirExp".equals(param.get("update_type"))) {
	        rv += cmpyDirExpDao.deleteCmpyDirExp(param);
	                
	        if(param.get( "exp_yy" ) != null && param.get( "exp_amount" ) != null ){
	        	
	        	Object obj_exp_yy = param.get( "exp_yy" );
	    		        	
	        	String[] array_exp_yy = null;
	        	String[] array_exp_amount = null;
	        	
	        	if(obj_exp_yy instanceof String){
	        		array_exp_yy = param.get( "exp_yy" ).toString().split( "," );
	        		array_exp_amount = param.get( "exp_amount" ).toString().split( "," ); 
	        	}
	        	
	        	else if(obj_exp_yy instanceof String[]){
	        		array_exp_yy = (String[]) param.get( "exp_yy" );
	        		array_exp_amount = (String[]) param.get( "exp_amount" );
	        	}
	        	
	        	if(array_exp_yy != null){    		
			    	for( int i = 0 ; i < array_exp_yy.length ; i++ ){    
			    		
			    		param.put( "exp_yy" , array_exp_yy[i]);     		
			    		param.put( "exp_amount" , array_exp_amount[i]);		
			    		
			    		rv += cmpyDirExpDao.insertCmpyDirExp(param);
			    	}
	        	}
	        }
		}
		if ("country".equals(param.get("update_type"))) {
			rv += cmpyDirDao.updateCmpyDirExpCountry(param);
		}

		return new Integer(rv);
    }
    
    
    
    
    
    
    /**
     * 수출현황 삭제
     *
     * @param List<CmpyDirExpVo> iCmpyDirExpList
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirExp(Map<String, Object> param) throws Exception {        
        return cmpyDirExpDao.deleteCmpyDirExp(param);
    }
    
    /**
     * 인증내역 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirCertVo>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirCertList(Map<String, Object> param) throws Exception {
        return cmpyDirCertDao.selectCmpyDirCertList(param);
    }
    
    /**
     * 인증현황 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
	public Integer insertCmpyDirCert(Map<String, Object> param) throws Exception {
		return cmpyDirCertDao.insertCmpyDirCert(param);
	}
    
    /**
     * 인증현황 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
	public Integer updateCmpyDirCert(Map<String, Object> param) throws Exception {

        int rv = 0;

        rv += cmpyDirCertDao.deleteCmpyDirCert(param);
                
        if( param.get( "cert_date" ) != null && param.get( "domestic_yn" ) != null &&
        	param.get( "issu_agc" ) != null && param.get( "issu_agc_en" ) != null && 
        	param.get( "prdt_nm" ) != null && param.get( "prdt_nm_en" ) != null){
        	
        	Object obj_cert_date = param.get( "cert_date" );

        	String[] array_cert_date = null;
        	String[] array_domestic_yn = null;
        	String[] array_issu_agc = null;
        	String[] array_issu_agc_en = null;
        	String[] array_prdt_nm = null;
        	String[] array_prdt_nm_en = null;
        	
        	if(obj_cert_date instanceof String){
        		array_cert_date = param.get( "cert_date" ).toString().split( "," ); 
        		array_domestic_yn = param.get( "domestic_yn" ).toString().split( "," );  
        		array_issu_agc = param.get( "issu_agc" ).toString().split( "," ); 
        		array_issu_agc_en = param.get( "issu_agc_en" ).toString().split( "," );   
        		array_prdt_nm = param.get( "prdt_nm" ).toString().split( "," );
        		array_prdt_nm_en = param.get( "prdt_nm_en" ).toString().split( "," );      		
        	}
        	
        	else if(obj_cert_date instanceof String[]){
        		array_cert_date = (String[]) param.get( "cert_date" );
        		array_domestic_yn = (String[]) param.get( "domestic_yn" );
        		array_issu_agc = (String[]) param.get( "issu_agc" );
        		array_issu_agc_en = (String[]) param.get( "issu_agc_en" );
        		array_prdt_nm = (String[]) param.get( "prdt_nm" );
        		array_prdt_nm_en = (String[]) param.get( "prdt_nm_en" );
        	}
        	
        	if(array_cert_date != null){    		
		    	for( int i = 0 ; i < array_cert_date.length ; i++ ){    
		    		
		    		param.put( "cert_date" , array_cert_date[i]);     		
		    		param.put( "domestic_yn" , array_domestic_yn[i]);		
		    		param.put( "issu_agc" , array_issu_agc[i]);		
		    		param.put( "issu_agc_en" , array_issu_agc_en[i]);
		    		param.put( "prdt_nm" , array_prdt_nm[i]);		
		    		param.put( "prdt_nm_en" , array_prdt_nm_en[i]);
		    		
		    		rv += cmpyDirCertDao.insertCmpyDirCert(param);
		    	}
        	}
        }
			
        return new Integer(rv);
	}
    
    /**
     * 인증현황 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
	public Integer deleteCmpyDirCert(Map<String, Object> param) throws Exception {
		return cmpyDirCertDao.deleteCmpyDirCert(param);
	}
    
    /**
     * 연혁 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirHstrList(Map<String, Object> param) throws Exception {
        return cmpyDirHstrDao.selectCmpyDirHstrList(param);
    }
    
    /**
     * 연혁 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirHstr(Map<String, Object> param) throws Exception {
        return cmpyDirHstrDao.insertCmpyDirHstr(param);
    }
    
    /**
     * 연혁 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirHstr(Map<String, Object> param) throws Exception {

        int rv = 0;

        rv += cmpyDirHstrDao.deleteCmpyDirHstr(param);
                
        if(param.get( "hstr_yy" ) != null && param.get( "hstr_mm" ) != null &&
        	param.get( "hstr_cn" ) != null && param.get( "hstr_cn_en" ) != null){
        	
        	Object obj_hstr_yy = param.get( "hstr_yy" );
    		        	
        	String[] array_hstr_yy = null;
        	String[] array_hstr_mm = null;
        	String[] array_hstr_cn = null;
        	String[] array_hstr_cn_en = null;
        	
        	if(obj_hstr_yy instanceof String){
        		array_hstr_yy = param.get( "hstr_yy" ).toString().split( "," );
        		array_hstr_mm = param.get( "hstr_mm" ).toString().split( "," );  
        		array_hstr_cn = param.get( "hstr_cn" ).toString().split( "," );  
        		array_hstr_cn_en = param.get( "hstr_cn_en" ).toString().split( "," );        		
        	}
        	
        	else if(obj_hstr_yy instanceof String[]){
        		array_hstr_yy = (String[]) param.get( "hstr_yy" );
        		array_hstr_mm = (String[]) param.get( "hstr_mm" );
        		array_hstr_cn = (String[]) param.get( "hstr_cn" );
        		array_hstr_cn_en = (String[]) param.get( "hstr_cn_en" );
        	}
        	
        	if(array_hstr_yy != null){    		
		    	for( int i = 0 ; i < array_hstr_yy.length ; i++ ){    
		    		
		    		param.put( "hstr_yy" , array_hstr_yy[i]);     		
		    		param.put( "hstr_mm" , array_hstr_mm[i]);
		    		param.put( "hstr_cn" , array_hstr_cn[i]);
		    		param.put( "hstr_cn_en" , array_hstr_cn_en[i]);
		    		
		    		rv += cmpyDirHstrDao.insertCmpyDirHstr(param);
		    	}
        	}
        }
			
        return new Integer(rv);
    }
    
    /**
     * 연혁 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirHstr(Map<String, Object> param) throws Exception {
        return cmpyDirHstrDao.deleteCmpyDirHstr(param);
    }
    
    /**
     * 제품 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirPrdtList(Map<String, Object> param) throws Exception {
        return cmpyDirPrdtDao.selectCmpyDirPrdtList(param);
    }
    
    /**
     * 제품 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirPrdt(Map<String, Object> param) throws Exception {        
        return cmpyDirPrdtDao.insertCmpyDirPrdt(param);
    }
    
    /**
     * 제품 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirPrdt(Map<String, Object> param) throws Exception {   

        int rv = 0;

        rv += cmpyDirPrdtDao.deleteCmpyDirPrdt(param);
                
        if(param.get( "inds_tp_cd" ) != null && param.get( "wbiz_tp_l_cd" ) != null &&
        	param.get( "wbiz_tp_m_cd" ) != null && param.get( "wbiz_tp_s_cd" ) != null && 
        	param.get( "prdt_nm" ) != null && param.get( "prdt_nm_en" ) != null){
        	
        	Object obj_inds_tp_cd = param.get( "inds_tp_cd" );
    		        	
        	String[] array_inds_tp_cd = null;
        	String[] array_wbiz_tp_l_cd = null;
        	String[] array_wbiz_tp_m_cd = null;
        	String[] array_wbiz_tp_s_cd = null;
        	String[] array_prdt_nm = null;
        	String[] array_prdt_nm_en = null;
        	
        	if(obj_inds_tp_cd instanceof String){
        		array_inds_tp_cd = param.get( "inds_tp_cd" ).toString().split( "," );
        		array_wbiz_tp_l_cd = param.get( "wbiz_tp_l_cd" ).toString().split( "," );  
        		array_wbiz_tp_m_cd = param.get( "wbiz_tp_m_cd" ).toString().split( "," );  
        		array_wbiz_tp_s_cd = param.get( "wbiz_tp_s_cd" ).toString().split( "," );  
        		array_prdt_nm = param.get( "prdt_nm" ).toString().split( "," );  
        		array_prdt_nm_en = param.get( "prdt_nm_en" ).toString().split( "," );        		
        	}
        	
        	else if(obj_inds_tp_cd instanceof String[]){
        		array_inds_tp_cd = (String[]) param.get( "inds_tp_cd" );
        		array_wbiz_tp_l_cd = (String[]) param.get( "wbiz_tp_l_cd" );
        		array_wbiz_tp_m_cd = (String[]) param.get( "wbiz_tp_m_cd" );
        		array_wbiz_tp_s_cd = (String[]) param.get( "wbiz_tp_s_cd" );
        		array_prdt_nm = (String[]) param.get( "prdt_nm" );
        		array_prdt_nm_en = (String[]) param.get( "prdt_nm_en" );
        	}
        	
        	if(array_inds_tp_cd != null){    		
		    	for( int i = 0 ; i < array_inds_tp_cd.length ; i++ ){    
		    		
		    		param.put( "inds_tp_cd" , array_inds_tp_cd[i]);     		
		    		param.put( "wbiz_tp_l_cd" , array_wbiz_tp_l_cd[i]);
		    		param.put( "wbiz_tp_m_cd" , array_wbiz_tp_m_cd[i]);
		    		param.put( "wbiz_tp_s_cd" , array_wbiz_tp_s_cd[i]);
		    		param.put( "prdt_nm" , array_prdt_nm[i]);
		    		param.put( "prdt_nm_en" , array_prdt_nm_en[i]);
		    		
		    		rv += cmpyDirPrdtDao.insertCmpyDirPrdt(param);
		    	}
        	}
        }
        
        return new Integer(rv);
    }
    
    /**
     * 제품 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirPrdt(Map<String, Object> param) throws Exception {        
        return cmpyDirPrdtDao.deleteCmpyDirPrdt(param);
    }
    
    
    /**
     * 제품사진 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirPrdtPctrList(Map<String, Object> param) throws Exception {
        return cmpyDirPrdtPctrDao.selectCmpyDirPrdtPctrList(param);
    }
    
    /**
     * 제품사진 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {        
        return cmpyDirPrdtPctrDao.insertCmpyDirPrdtPctr(param);
    }
    
    /**
     * 제품사진 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {             
        return cmpyDirPrdtPctrDao.updateCmpyDirPrdtPctr(param);
    }
    
    /**
     * 제품사진 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {          
        return cmpyDirPrdtPctrDao.deleteCmpyDirPrdtPctr(param);
    }
    
    /**
     * 동영상 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectCmpyDirVdoList(Map<String, Object> param) throws Exception {
    	List<Map<String, Object>> vodList = cmpyDirVdoDao.selectCmpyDirVdoList(param);
		for (Map<String, Object> vodDataMap : vodList) {
			String vdo_path = StringUtil.nvl(vodDataMap.get("vdo_path"));
			if (!StringUtil.isEmpty(vdo_path) && vdo_path.indexOf("/") > 0) {
				String code = StringUtil.substringAfterLast(vdo_path, "/");
				vodDataMap.put("vdo_img_path", "http://img.youtube.com/vi/" + code + "/default.jpg");
			}
		}
        return vodList;
    }
    
    /**
     * 동영상 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer insertCmpyDirVdo(Map<String, Object> param) throws Exception {
        return cmpyDirVdoDao.insertCmpyDirVdo(param);
    }
    
    /**
     * 동영상 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer updateCmpyDirVdo(Map<String, Object> param) throws Exception {   

        int rv = 0;

        rv += cmpyDirVdoDao.deleteCmpyDirVdo(param);
                
        if(param.get( "vdo_title" ) != null && param.get( "vdo_path" ) != null){
        	
        	Object obj_vdo_title = param.get( "vdo_title" );
    		        	
        	String[] array_vdo_title = null;
        	String[] array_vdo_title_en = null;
        	String[] array_vdo_path = null;
        	
        	if(obj_vdo_title instanceof String){
        		array_vdo_title = param.get( "vdo_title" ).toString().split( "," );  
        		array_vdo_title_en = param.get( "vdo_title_en" ).toString().split( "," );    
        		array_vdo_path = param.get( "vdo_path" ).toString().split( "," );      		
        	}
        	
        	else if(obj_vdo_title instanceof String[]){
        		array_vdo_title = (String[]) param.get( "vdo_title" );
        		array_vdo_title_en = (String[]) param.get( "vdo_title_en" );
        		array_vdo_path = (String[]) param.get( "vdo_path" );
        	}
        	
        	if(array_vdo_title != null){    		
		    	for( int i = 0 ; i < array_vdo_title.length ; i++ ){    
		    		
		    		param.put( "vdo_title" , array_vdo_title[i]);
		    		param.put( "vdo_title_en" , array_vdo_title_en[i]);
		    		param.put( "vdo_path" , array_vdo_path[i]);
		    		
		    		rv += cmpyDirVdoDao.insertCmpyDirVdo(param);
		    	}
        	}
        }
        
        return new Integer(rv);
    }
    
    /**
     * 동영상 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    @Override
    public Integer deleteCmpyDirVdo(Map<String, Object> param) throws Exception {
        return cmpyDirVdoDao.deleteCmpyDirVdo(param);
    } 
    
}
