<!-- 카카오 컨트롤러 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="DAODTO.KakaoMemberDAO"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	// 카카오 API 처리 1차 컨트롤러 담당 페이지
	
	// 이전 페이지에서 넘긴 값 받아오기(login인지 회원가입인지 체크하는 단계)
	String a = request.getParameter("a");

    // 코드 가져오기
	String code = request.getParameter("code");
    
    
	KakaoMemberDAO kakao = new KakaoMemberDAO();
	// 키 가져오기
	String key = kakao.getKey();
	// 리다이렉트 URL 가져오기
	String url = kakao.getRedirecturl();
	String token;	
	
	
	// 카카오 로그인 버튼을 눌렀을 때
	if(a.equals("login")){
		String fullurl = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id="+key+"&redirect_uri="+url+"?a=login"+"&code="+code;
		// 카카오서버에 키와 코드를 포함해서 url Request하기
		kakao.Request(fullurl);
		
		// request 한 번 더해서 토큰 가져오기 
		kakao.request_Rotation();
		token = kakao.getB();
		
		// 토큰을 가지고 실제 요청한 사람의 카카오 계정 정보 가져오기
		kakao.request_profile();
		
		// 로그인시 해당 토큰 유지를 위해 세션에 저장
		session.setAttribute("token", token);
		
		// 카카오 로그인 된 닉네임을 받아 컨트롤러 페이지로 넘기기
		String nickname = URLEncoder.encode(kakao.getNickname(), "UTF-8");
		response.sendRedirect("Controller_Member.jsp?action=kakaologin&kid="+kakao.getC()+"&kemail="+kakao.getEmail()+"&knickname="+nickname);
		
	// 카카오 회원가입을 눌렀을 때
	} else{
		String fullurl = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id="+key+"&redirect_uri="+url+"?a=no"+"&code="+code;
		// 카카오서버에 키와 코드를 포함해서 url Request하기
		kakao.Request(fullurl);
		
		// request 한 번 더해서 토큰 가져오기 
		kakao.request_Rotation();
		
		// 토큰을 가지고 실제 요청한 사람의 카카오 계정 정보 가져오기
		kakao.request_profile();
		String nickname = URLEncoder.encode(kakao.getNickname(), "UTF-8");
		
		// 카카오 로그인 된 닉네임을 받아 컨트롤러 페이지로 넘기기
		response.sendRedirect("Controller_Member.jsp?action=kakaosignup&id="+kakao.getC()+"&email="+kakao.getEmail()+"&nickname="+nickname);
	}
%>