package com.shinhan.util;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class S3Upload {

	@Value("${cloud.aws.s3.bucket}")
    private String bucket;

    
    private final AmazonS3 amazonS3;

   
//    public String upload(MultipartFile multipartFile, String uuid, String extension) throws AmazonServiceException, SdkClientException, IOException {
//    	ObjectMetadata objMeta = new ObjectMetadata();
//    	try {
//			objMeta.setContentLength(multipartFile.getInputStream().available());
//			
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    	
//    	objMeta.setContentType(multipartFile.getContentType());
//    	
//    	String s3FileName = "image/oboard/" + uuid + extension;
//    	String str_url=amazonS3.getUrl(bucket, s3FileName).toString();
//    	System.out.println(str_url);
//    	amazonS3.putObject(bucket, s3FileName, multipartFile.getInputStream(), objMeta);
//        return amazonS3.getUrl(bucket, s3FileName).toString();
//    }
    public String upload(MultipartFile multipartFile,String path, String uuid) throws AmazonServiceException, SdkClientException, IOException {
    	System.out.println(bucket);
    	ObjectMetadata objMeta = new ObjectMetadata();
    	try {
    		objMeta.setContentLength(multipartFile.getInputStream().available());
    		
    	} catch (IOException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	objMeta.setContentType(multipartFile.getContentType());
    	
    	String s3FileName = "image/" +path+ uuid ;
    	String str_url=amazonS3.getUrl(bucket, s3FileName).toString();
    	System.out.println(str_url);
    	amazonS3.putObject(bucket, s3FileName, multipartFile.getInputStream(), objMeta);
    	return amazonS3.getUrl(bucket, s3FileName).toString();
    }
    
    
}