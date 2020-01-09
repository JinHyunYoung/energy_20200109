package kr.or.wabis.framework.util;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class CryptoUtil {
    
    private static volatile CryptoUtil INSTANCE;
    
    final static String secretKey = "7892583571596541"; // 32bit
    static String IV = "7892583571596541"; // 16bit
    
    public static CryptoUtil getInstance() {
        if (INSTANCE == null) {
            synchronized (CryptoUtil.class) {
                if (INSTANCE == null)
                    INSTANCE = new CryptoUtil();
            }
        }
        return INSTANCE;
    }
    
    private CryptoUtil() {
        IV = secretKey.substring(0, 16);
    }
    
    /**
     * 암호화
     * 
     * @param str
     * @return
     * @throws java.io.UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     * @throws NoSuchPaddingException
     * @throws InvalidKeyException
     * @throws InvalidAlgorithmParameterException
     * @throws IllegalBlockSizeException
     * @throws BadPaddingException
     */
    public static String AES_Encode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        
        byte[] keyData = secretKey.getBytes();
        
        SecretKey secureKey = new SecretKeySpec(keyData, "AES");
        
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(IV.getBytes()));
        
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
        
        return enStr;
    }
    
    /**
     * 복호화
     * 
     * @param str
     * @return
     * @throws java.io.UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     * @throws NoSuchPaddingException
     * @throws InvalidKeyException
     * @throws InvalidAlgorithmParameterException
     * @throws IllegalBlockSizeException
     * @throws BadPaddingException
     */
    public static String AES_Decode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        
        byte[] keyData = secretKey.getBytes();
        SecretKey secureKey = new SecretKeySpec(keyData, "AES");
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(IV.getBytes("UTF-8")));
        
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
        
        return new String(c.doFinal(byteStr), "UTF-8");
    }
    
    /**
     * 
     * @param planText
     * @return
     */
    public static String SHA_encrypt(String planText) {
        
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(planText.getBytes());
            byte byteData[] = md.digest();
            
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                String hex = Integer.toHexString(0xff & byteData[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }
    
}
