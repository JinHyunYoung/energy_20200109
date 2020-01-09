package kr.or.wabis.framework.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

public class ImageUtil {
    
    public static void resizing(File source, File dest, int width, int height) throws IOException {
        BufferedImage sourceImage = ImageIO.read(source);
        BufferedImage destImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        
        Graphics2D graphics = destImage.createGraphics();
        graphics.setComposite(AlphaComposite.Src);
        graphics.drawImage(sourceImage, 0, 0, width, height, null);
        graphics.dispose();
        
        FileOutputStream fos = new FileOutputStream(dest);
        
        ImageIO.write(destImage, "jpg", fos);
    }
    
    public static void cropping(File source, File dest, int width, int height, int posX, int posY) throws IOException {
        BufferedImage sourceImage = ImageIO.read(source);
        BufferedImage destImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        
        Graphics2D graphics = destImage.createGraphics();
        graphics.setComposite(AlphaComposite.Src);
        graphics.drawImage(sourceImage, 0, 0, width, height, posX, posY, posX + width, posY + height, null);
        graphics.dispose();
        
        FileOutputStream fos = new FileOutputStream(dest);
        
        ImageIO.write(destImage, "jpg", fos);
    }
    
    /**
     * 이미지를 resizing 한다.
     * 
     * @param source
     * @param dest
     * @param width
     * @throws IOException
     */
    public static void resize(File source, File dest, int width) throws IOException {
        BufferedImage sourceImage = ImageIO.read(source);
        int resizedHeight = (width * sourceImage.getHeight()) / sourceImage.getWidth();
        resizing(source, dest, width, resizedHeight);
    }
    
    /**
     * 이미지를 resizing 한다. 주어진 width 와 height를 넘지 않도록 한다.
     * 
     * @param source
     * @param dest
     * @param width
     * @throws IOException
     */
    public static void resize(File source, File dest, int width, int height) throws IOException {
        BufferedImage sourceImage = ImageIO.read(source);
        
        if (sourceImage.getHeight() > sourceImage.getWidth()) {
            if (sourceImage.getHeight() < height) {
                resizing(source, dest, sourceImage.getWidth(), sourceImage.getHeight());
            } else {
                int re_width = (int) (sourceImage.getWidth() * ((double) height / sourceImage.getHeight()));
                if (re_width < width) {
                    resizing(source, dest, re_width, height);
                } else {
                    resizing(source, dest, width, (int) (sourceImage.getHeight() * ((double) width / sourceImage.getWidth())));
                }
            }
        } else {
            if (sourceImage.getWidth() < width) {
                resizing(source, dest, sourceImage.getWidth(), sourceImage.getHeight());
            } else {
                int re_height = (int) (sourceImage.getHeight() * ((double) width / sourceImage.getWidth()));
                if (re_height < height) {
                    resizing(source, dest, width, re_height);
                } else {
                    resizing(source, dest, (int) (sourceImage.getWidth() * ((double) height / sourceImage.getHeight())), height);
                }
            }
        }
    }
    
    /**
     * 이미지의 특정영역을 crop 한다.
     * 
     * @param source
     * @param dest
     * @param width
     * @param height
     * @param vertical
     * @param horizontal
     * @throws IOException
     */
    public static void crop(File source, File dest, int width, int height, String vertical, String horizontal) throws IOException {
        
        int x = 0;
        int y = 0;
        BufferedImage sourceImage = ImageIO.read(source);
        width = sourceImage.getWidth() > width ? width : sourceImage.getWidth();
        height = sourceImage.getHeight() > height ? height : sourceImage.getHeight();
        x = horizontal.equalsIgnoreCase("left") ? 0 : horizontal.equalsIgnoreCase("center") ? (sourceImage.getWidth() - width) / 2 : horizontal.equalsIgnoreCase("right") ? sourceImage.getWidth() - width : 0;
        
        y = vertical.equalsIgnoreCase("top") ? 0 : vertical.equalsIgnoreCase("middle") ? (sourceImage.getHeight() - height) / 2 : vertical.equalsIgnoreCase("bottom") ? sourceImage.getHeight() - height : 0;
        
        cropping(source, dest, width, height, x, y);
    }
    
    /**
     * 이미지 파일의 확장자 타입을 가지고 온다
     * 
     * @param fname
     * @return
     */
    public static String getImageFileExtension(String fname) {
        if (!fname.equals("")) {
            int lst_in = fname.lastIndexOf('.');
            String fileNm = fname.substring(0, lst_in);
            String ext = fname.substring(lst_in + 1);
            return ext;
        } else {
            return "";
        }
    }
    
    /**
     * 이미지 파일의 이름을 가지고 온다
     * 
     * @param fname
     * @return
     */
    public static String getImageFileName(String fname) {
        if (!fname.equals("")) {
            int lst_in = fname.lastIndexOf('.');
            String fileNm = fname.substring(0, lst_in);
            return fileNm;
        } else {
            return "";
        }
    }
    
    /**
     * 사이즈를 줄일 이미지 명 뒤에 smaill 을 붙인후 리턴한다
     * 
     * @param fname
     * @return
     */
    public static String getImageSmallFileName(String fname) {
        if (!fname.equals("")) {
            int lst_in = fname.lastIndexOf('.');
            String fileNm = fname.substring(0, lst_in);
            String ext = fname.substring(lst_in + 1);
            return fileNm + "_small." + ext;
        } else {
            return "";
        }
    }
    
    /**
     * 핸드폰 mms 전송용 이미지를 생성한다
     * 
     * @param source
     * @param dest
     * @param width
     * @param height
     * @throws IOException
     */
    public static void mmsResize(File source, File dest, int width, int height) throws IOException {
        resizing(source, dest, width, height);
    }
    
    /**
     * 썸네일이미지를 생성해준다.
     * 
     * @param source
     * @param dest
     * @param thumbnail_width
     * @param thumbnail_height
     */
    public static void thumbnail(String source, String dest, int thumbnail_width, int thumbnail_height) {
        
        try {
            
            // 원본이미지파일의 경로+파일명
            File origin_file_name = new File(source);
            
            // 생성할 썸네일파일의 경로+썸네일파일명
            File thumb_file_name = new File(dest);
            
            BufferedImage buffer_original_image = ImageIO.read(origin_file_name);
            BufferedImage buffer_thumbnail_image = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
            Graphics2D graphic = buffer_thumbnail_image.createGraphics();
            graphic.drawImage(buffer_original_image, 0, 0, thumbnail_width, thumbnail_height, null);
            ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void mergeImage(String img1Path, String img2Path, int wSize, int hSize, String savePath, String fileName) {
        
        try {
            int width = wSize / 2;
            BufferedImage img1 = resizeImage(img1Path, width, hSize);
            BufferedImage img2 = resizeImage(img2Path, width, hSize);
            BufferedImage mergeImg = new BufferedImage(wSize, hSize, BufferedImage.TYPE_INT_RGB);
            
            Graphics2D graphics = (Graphics2D) mergeImg.getGraphics();
            graphics.setBackground(Color.white);
            graphics.drawImage(img1, 0, 0, null);
            graphics.drawImage(img2, img1.getWidth(), 0, null);
            ImageIO.write(mergeImg, "jpg", new File(savePath + fileName + ".jpg"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 
     * @param loadFile
     * @param wSize
     * @param hSize
     * @return
     */
    public static BufferedImage resizeImage(String loadFile, int wSize, int hSize) {
        try {
            RenderedOp rOp = JAI.create("fileload", loadFile);
            BufferedImage im = rOp.getAsBufferedImage();
            
            int img_width = im.getWidth();
            int img_height = im.getHeight();
            int width = wSize;
            int height = hSize;
            
            BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2 = thumb.createGraphics();
            g2.drawImage(im, 0, 0, width, height, null);
            return thumb;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public static void main(String[] args) {
        
        String filename = "C:\\ocm_fs\\upload\\contents\\private\\1450750738240.jpg";
        File f = new File(filename);
        File f2 = new File(getImageSmallFileName(filename));
        
        try {
            resize(f, f2, 290, 428);
            // crop(f, f2, 100, 100, "middle", "right");
            // resize(f, f2, 100);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}