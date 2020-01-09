package kr.or.wabis.framework.util.sms;

public interface SmsSendInterface {
    public long sendMessage(String receiver, String msg, String sender) throws Exception;
}
