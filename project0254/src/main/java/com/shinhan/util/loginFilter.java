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
				"/app4/onwerlogin.do",
				"/app4/naverEmpty.do",
				"/app4/naverlogin.do",
				"/app4/login.do",
				"/app4/logout.do",
				"/app4/kakaologinCheck.do",
				"/app4/loginCheck.do",
				"/app4/signUp.do",
				"/app4/search_id.do",
				"/app4/search_password.do",
				"/app4/registCodeCheck.do",
				"/app4/idCheck.do",
				"/app4/chageAddress.do",
				"/app4/resources/*"
			};

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
				if (session == null || session.getAttribute("owner") == null) {
					httpResponse.sendRedirect("/app4/login.do");
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
