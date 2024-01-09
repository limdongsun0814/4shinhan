package com.shinhan.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.PatternMatchUtils;

//@WebFilter("*")
public class loginFilter implements Filter {

	//"/app/", 
	private static final String[] LoginList = { 
			"/app/", 
			"/app/member/countNewAlarm.do", 
			"/app/loginCheck.do", 
			"/app/memberjoinpage.do", 
			"/app/naverEmpty.do", 
			"/app/kakaologinCheck.do", 
			"/app/memberjoin.do", 
			"/app/memberlogin.do", 
			"/app/kakaoMemberJoin.do", 
			"/app/search_id.do", 
			"/app/search_password.do", 
			"/app/idCheck.do", 
			"/app/goOnwer.do", 
			"/app/naverlogin.do",
			"/app/store/getStoreListByFiltering.do",
			"/app/store/getStoreListByFilteringMap.do",
			"/app/getBestMenuList.do",
			"/app/store/getMenuList.do",
			"/app/memberlogin.do",
			"/app/store/getMap.do",
			"/app/store/getStoreDetail.do/*",
			"/app/store/getMenuListPage.do",
			"/app/store/getIngredientsInfo.do",
			"/app/store/getStoreReviews.do",
			"/app/store/getStoreNotice.do",
			"/app/store/getStoreAddress.do",
			"/app/store/searchMenu.do",
			"/app/store/getMenuDetail.do",
			"/app/filter.do",
			"/app/resources/*"};

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		String requestURI = httpRequest.getRequestURI();
		HttpSession session = httpRequest.getSession(false);
		System.out.println(requestURI+" requestURI");
		try {
			if (!PatternMatchUtils.simpleMatch(LoginList, requestURI)) {
				System.out.println(requestURI+" requestURI++++");
				if (session == null || session.getAttribute("member") == null) {
					httpResponse.sendRedirect("/app/filter.do");
					return;
				}
			}

			chain.doFilter(request, response);
		} catch (Exception e) {
			throw e;
		} finally {
			System.out.println("login filter");
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
