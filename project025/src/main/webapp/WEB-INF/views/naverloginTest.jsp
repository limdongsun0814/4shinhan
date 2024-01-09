
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>네이버로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  </head>
  <body>
  <h1> 네이버 로그인 페이지!!!</h1>
  <h1> zzzzz</h1>
  <button> 이것으 생기나</button>
  <div id="naver_id_login"></div>
    <script type="text/javascript">
  	var naver_id_login = new naver_id_login("ndlsjRz8kILDPZJYSPk2", "http://localhost:9090/app/Successnaverlogin.do");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	//naver_id_login.setDomain(".service.com");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  </script>
  <%-- <%
    
    String clientId = "z28qtKujeQl7xKP64hWZ";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:9090/app/Successnaverlogin.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %> --%>
  <%-- <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
   --%></body>
</html>