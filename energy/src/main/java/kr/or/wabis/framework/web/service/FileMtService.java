package kr.or.wabis.framework.web.service;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.wabis.framework.dao.CommonDao;
import kr.or.wabis.framework.util.FileUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.SessionUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.vo.AttchFileInfoVo;
import kr.or.wabis.framework.web.vo.ElecDocAttchFileInfoVo;

/**
 * <PRE>
 * Attach File Management Service
 * </PRE>
 *
 * @author jansgoo kim
 * @version 1.0
 * @since 22-09-2016
 */
@Service("fileMtService")
public class FileMtService {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name = "commonDao")
    protected CommonDao commonDao;
    
    /**
     * 
     * != (신고서가 아닌 일반화면의) 첨부파일 목록을 등록한다. =!
     * 
     * @param iAttchFileInfoVoList - != 화면에서 넘어온 MultiPart List =!
     * @return
     * @throws Exception
     */
    public List<AttchFileInfoVo> registNormalAttchFileList(List<AttchFileInfoVo> iAttchFileInfoVoList) throws Exception {
        
        List<AttchFileInfoVo> returnList = new ArrayList<>();
        
        if (iAttchFileInfoVoList == null) {
            return returnList;
        }
        
        String userId = SessionUtil.getUserVo().getUserId();
        
        String newAttchFileMtNo = FileUtil.getNewAttchFileMtNo();
        int newAttchFileSn = 0;
        String saveFilePath = FileUtil.getElecDocAttchFilePath();
        
        for (AttchFileInfoVo attchFileInfoVo : iAttchFileInfoVoList) {
            
            MultipartFile multipart = attchFileInfoVo.getAttchFile();
            
            // 첨부파일관리번호
            String attchFileMtNo = attchFileInfoVo.getAttchFileMtNo(); 
            
            //  첨부파일일련번호
            Integer attchFileSn = attchFileInfoVo.getAttchFileSn();
            
            // 첨부파일원본파일명
            String attchFileOgnlFileNm = attchFileInfoVo.getAttchFileOgnlFileNm(); 
            
            // 첨부파일컨텐츠구분명
            String attchFileCtenTpNm = attchFileInfoVo.getAttchFileCtenTpNm(); 
            
            // 첨부파일크기
            BigDecimal attchFileSize = attchFileInfoVo.getAttchFileSize();
            
            // 전자문서대상여부
            String elecDocTrgtYn = attchFileInfoVo.getElecDocTrgtYn(); 
            
            if (StringUtil.isEmpty(attchFileInfoVo.getFrstRegstId())) {
                attchFileInfoVo.setFrstRegstId(userId);
            } else if (StringUtil.isEmpty(attchFileInfoVo.getLastChprId())) {
                attchFileInfoVo.setLastChprId(userId);
            }
                        
            // 다중 첨부 파일
            if (multipart != null) {
                
                newAttchFileSn++;
                
                attchFileInfoVo.setAttchFileMtNo(newAttchFileMtNo);
                attchFileInfoVo.setAttchFileSn(newAttchFileSn);
                attchFileInfoVo.setAttchFilePathNm(saveFilePath);
                
                // Save File Name
                String saveFileName = newAttchFileMtNo + "_" + newAttchFileSn; // yyyyMMddHHmmssSSS_1
                if (StringUtil.contains(attchFileOgnlFileNm, ".")) {
                    saveFileName += "." + StringUtil.substringAfterLast(attchFileOgnlFileNm, "."); // yyyyMMddHHmmssSSS_1.doc
                }
                
                attchFileInfoVo.setAttchFileStrgNm(saveFileName);
                
                /** Insert INTO ATTCH_FILE_L */
                this.registNormalAttchFile(attchFileInfoVo);
                
                /** Write Physical */
                FileUtils.writeByteArrayToFile(new File(saveFilePath, saveFileName), multipart.getBytes());
                
                /** Return List */
                returnList.add(attchFileInfoVo);
                
            } else if (multipart == null && StringUtil.isNotBlank(attchFileMtNo) && attchFileSn != 0) {
                
                newAttchFileSn++;
                
                /** Search ATTCH_FILE_L, using attchFileMtNo,attchFileSn */
                log.debug("### Search legacy Attachements");
                
                AttchFileInfoVo searchVo = new AttchFileInfoVo();
                searchVo.setAttchFileMtNo(attchFileMtNo);
                searchVo.setAttchFileSn(attchFileSn);
                
                AttchFileInfoVo previousVo = this.searchNormalAttchFile(searchVo);                
                attchFileInfoVo.setAttchFileMtNo(newAttchFileMtNo);
                attchFileInfoVo.setAttchFileSn(newAttchFileSn);
                attchFileInfoVo.setAttchFileOgnlFileNm(previousVo.getAttchFileOgnlFileNm());
                attchFileInfoVo.setAttchFilePathNm(saveFilePath);
                
                // Save File Name
                String saveFileName = newAttchFileMtNo + "_" + newAttchFileSn; // yyyyMMddHHmmssSSS_1
                if (StringUtil.contains(previousVo.getAttchFileOgnlFileNm(), ".")) {
                    saveFileName += "." + StringUtil.substringAfterLast(previousVo.getAttchFileOgnlFileNm(), "."); // yyyyMMddHHmmssSSS_1.doc
                }
                attchFileInfoVo.setAttchFileStrgNm(saveFileName);
                attchFileInfoVo.setAttchFileCtenTpNm(previousVo.getAttchFileCtenTpNm());
                attchFileInfoVo.setAttchFileSize(previousVo.getAttchFileSize());
                
                /** Insert INTO ATTCH_FILE_L */
                this.registNormalAttchFile(attchFileInfoVo);
                
                /** Write Physical */
                File previousFile = new File(previousVo.getAttchFilePathNm(), previousVo.getAttchFileStrgNm());
                FileUtils.copyFile(previousFile, new File(saveFilePath, saveFileName));
                
                /** Return List */
                returnList.add(attchFileInfoVo);
            }
        }
        
        log.debug("### Normal Attachements Insert Count : {}", newAttchFileSn);
        
        return returnList;
    }
    
    /**
     * 
     * != 메세지ID와 파일순번에 해당하는 첨부파일을 조회한다. =!
     * 
     * @param ElecDocAttchFileInfoVo - iElecDocAttchFileInfoVo
     * @return ElecDocAttchFileInfoVo
     * @throws Exception
     */
    public ElecDocAttchFileInfoVo searchElecDocAttchFile(ElecDocAttchFileInfoVo iElecDocAttchFileInfoVo) throws Exception {
        
        log.debug("### msgId       : {}", iElecDocAttchFileInfoVo.getMsgId());
        log.debug("### attchFileSn : {}", iElecDocAttchFileInfoVo.getAttchFileSn());
        
        ElecDocAttchFileInfoVo vo = commonDao.select("AttchFileLDao_fw.searchElecDocAttchFile", iElecDocAttchFileInfoVo);
        if (vo == null) {
            
            // 첨부문서정보
            String info = MessageUtil.getMessage("system.00019"); 
            
            // {0} not exists != 해당 {0}는(은) 존재하지 않습니다 =!
            String msg = MessageUtil.getMessage("system.20012", new String[] { info }); 
            
            throw new Exception(msg);
        }
        
        return vo;
    }
    
    /**
     * 
     * != (신고서가 아닌 일반화면의) 첨부파일을 등록한다. =!
     * 
     * @param iAttchFileInfoVo
     * @return int
     * @throws Exception
     */
    public int registNormalAttchFile(AttchFileInfoVo iAttchFileInfoVo) throws Exception {
        return commonDao.insert("AttchFileLDao_fw.registNormalAttchFile", iAttchFileInfoVo);
    }
    
    /**
     * 
     * != (신고서가 아닌 일반화면의) 첨부파일관리번호,일련번호에 해당하는 첨부파일 1개를 조회한다. =!
     * 
     * @param iAttchFileInfoVo
     * @return AttchFileInfoVo
     * @throws Exception
     */
    public AttchFileInfoVo searchNormalAttchFile(AttchFileInfoVo iAttchFileInfoVo) throws Exception {
        return commonDao.select("AttchFileLDao_fw.searchNormalAttchFile", iAttchFileInfoVo);
    }
    
    /**
     * 
     * != (신고서가 아닌 일반화면의) 첨부파일관리번호에 해당하는 첨부파일 목록을 조회한다. =!
     * 
     * @param attchFileMtNo - Attaching File Management Number != 첨부파일관리번호 =!
     * @return List<AttchFileLVo>
     * @throws Exception
     */
    public List<AttchFileInfoVo> searchNormalAttchFileList(String attchFileMtNo) throws Exception {
        return commonDao.selectList("AttchFileLDao_fw.searchNormalAttchFileList", attchFileMtNo);
    }
    
    /**
     * 
     * != 전자문서 전송대상 첨부파일 목록을 조회한다. =!
     * 
     * @param attchFileMtNo - Attaching File Management Number != 첨부파일관리번호 =!
     * @return List<AttchFileLVo>
     * @throws Exception
     */
    public List<AttchFileInfoVo> searchElecDocSendAttchFileList(String attchFileMtNo) throws Exception {
        return commonDao.selectList("AttchFileLDao_fw.searchElecDocSendAttchFileList", attchFileMtNo);
    }
    
}
