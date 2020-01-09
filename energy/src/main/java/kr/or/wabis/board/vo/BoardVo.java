package kr.or.wabis.board.vo;

import java.util.Map;

public class BoardVo {
    
    private String board_id;
    private String size;
    private String domestic_yn;
    
    public BoardVo(){        
    }
    
    public BoardVo(Map<String, Object> param ){
        
        Object board_id_obj = param.get("board_id");
        if(board_id_obj != null) board_id =  board_id_obj.toString();
        
        Object size_obj = param.get("size");
        if(size_obj != null) size = size_obj.toString();
        
        Object domestic_yn_obj = param.get("domestic_yn");
        if(domestic_yn_obj != null) domestic_yn =  domestic_yn_obj.toString();
    }

    public String getBoard_id() {
        return board_id;
    }

    public void setBoard_id(String board_id) {
        this.board_id = board_id;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getDomestic_yn() {
        return domestic_yn;
    }

    public void setDomestic_yn(String domestic_yn) {
        this.domestic_yn = domestic_yn;
    }    
    
}
