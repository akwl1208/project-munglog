package kr.inyo.munglog.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	//폴더형식 년/월/일
	public static String uploadFile(String uploadPath, String originalName,
			byte[] fileData)throws Exception{
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() +"_" + originalName;
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		String uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		return uploadFileName;
	}
	
	//폴더 형식 dir/년/월/일
	public static String uploadFileDir(String uploadPath, String dir, String originalName,
			byte[] fileData)throws Exception{
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() +"_" + originalName;
		String savedPath = calcLogPath(uploadPath , dir);
		File target = new File(uploadPath + savedPath, savedName); 
		FileCopyUtils.copy(fileData, target);
		String uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		return uploadFileName;
	}
	
	//폴더 형식 prefix 폴더만들기 없음
	public static String uploadFilePrefix(String uploadPath, String prefix, String originalName,
			byte[] fileData)throws Exception{
		String savedName = originalName;
		if(prefix != null && prefix.length() != 0)
			savedName = prefix + "_" + originalName;
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		String uploadFileName = makeIcon(uploadPath, "", savedName);
		return uploadFileName;
	}
	
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	private static String calcLogPath(String uploadPath, String dir) {
		Calendar cal = Calendar.getInstance();
		
		dir = File.separator + dir;
		String yearPath = dir + File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, dir, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	private static void makeDir(String uploadPath, String... paths) {
		if(new File(paths[paths.length-1]).exists())
			return;
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if( !dirPath.exists())
				dirPath.mkdir();
		}
	}
	
	private static String makeIcon(String uploadPath, String path, String fileName)
        	throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	//파일 삭제
	public static boolean deleteFile(String uploadPath, String fileName) {
		String delFileName = fileName.replace('/', File.separatorChar);
		File file = new File(uploadPath+delFileName);
		if(!file.exists())
			return false;
		return file.delete();
	}
}
