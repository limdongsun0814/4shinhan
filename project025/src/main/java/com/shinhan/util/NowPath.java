package com.shinhan.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

public class NowPath {
	private String nowPath;
	
	public NowPath(HttpServletRequest request)  {
		InetAddress ipAddress = null;
		try {
			ipAddress = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
			//현재 위치를 찾을 수 없음. 잠시 후에 다시 시도해주세요 페이지 떠야?
		}
		String protocol = request.isSecure()?"https://":"http://";
		this.setNowPath(protocol+ipAddress.getHostAddress()+":"+request.getServerPort()+request.getContextPath());
	}
	public String getNowPath() {
		return nowPath;
	}
	public void setNowPath(String nowPath) {
		this.nowPath = nowPath;
	}
}
