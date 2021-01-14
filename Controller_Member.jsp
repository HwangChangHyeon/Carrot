<!-- 로그인, 회원가입 등 유저 관련된 컨트롤러 -->

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="ErrorPage.jsp" import="DAODTO.*,java.util.*,DAODTO.KakaoMemberDAO"%>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- DB 접근 클래스 생성 -->
<jsp:useBean class="DAODTO.MemberDAO" id="memberdao" scope="session" />

<!-- 데이터 접근 클래스 생성 -->
<jsp:useBean class="DAODTO.MemberAddDTO" id="memberadddto" scope="session" />
<jsp:useBean class="DAODTO.MemberEditDTO" id="membereditdto" scope="session" />
<jsp:useBean class="DAODTO.MemberLoginDTO" id="memberlogindto" scope="session" />
<jsp:useBean class="DAODTO.KakaoMemberDTO" id="kakaomemberdto" scope="session" />
<jsp:useBean class="DAODTO.KakaoMemberLoginDTO" id="kakaomemberlogindto" scope="session" />

<!-- 클래스에 값 설정  -->
<jsp:setProperty name="memberadddto" property="*" />
<jsp:setProperty name="membereditdto" property="*" />
<jsp:setProperty name="memberlogindto" property="*" />
<jsp:setProperty name="kakaomemberdto" property="*" />
<jsp:setProperty name="kakaomemberlogindto" property="*" />

<%
	// 컨트롤러 요청 파라미터
	String action = request.getParameter("action");
	HashMap<String, String> mbr = new HashMap<String, String>();
	
	// 일반 인덱스 페이지에서 회원 가입 할 때 사용함
	if(action.equals("insert")) {
		
		// 파라미터로 받아온 1차 패스워드와 2차 패스워드가 동일하지 않을 때 경고 창 띄우고 다시 되돌아가기
		if(!memberadddto.getMember_pw().equals(memberadddto.getMember_pw2())){
			out.println("<script>alert('비밀번호를 1차 2차 동일하게 입력하세요!!');history.go(-1);</script>");
		}
		
		// 파라미터로 받은 회원 정보의 객체를 디비에 저장시킴
		else if(memberdao.insertDB(memberadddto)) {
			// 회원가입 완료되었다는 안내 페이지로 가게하기
			response.sendRedirect("Com_SignUp.jsp");
		}
		// 리턴 값으로 false가 나오면 이미 있는 ID이므로 안내 문구 
		else
			out.println("<script>alert('이미 있는 ID입니다 !! ID를 변경하세요.');location.href='SignUp.jsp';</script>");
	}
	
	// 일반 인덱스 페이지에서 회원 가입 할 때 사용함
	else if(action.equals("kakaosignup")) {
		
		// 파라미터로 받은 회원 정보의 객체를 디비에 저장시킴
		if(memberdao.kakaoinsertDB(kakaomemberdto)) {
			
			// 회원가입 완료되었다는 안내 페이지로 가게하기
			response.sendRedirect("Com_SignUp.jsp");
			session.invalidate();
		}
		// 리턴 값으로 false가 나오면 이미 가입되어 있는 회원이므로, 확인 안내
		else
			out.println("<script>alert('이미 가입되어있는 회원 입니다. 로그인하세요'); location.href='Index.jsp';</script>");
	}
	
	// 회원가입시 ID 중복 체크 확인
	else if(action.equals("Match")){
		
		String name = (String)request.getParameter("matchid");
		
		// 받아온 id가 공백일 경우
		if(name.equals("")){
			out.println("<script>alert('아이디가 비어있습니다. 다시 확인해주세요');history.go(-1);</script>");
		}
		
		// 받아온 id가 디비에서 확인했을 때 이미 있는 경우
		else if(memberdao.MatchIDDB(name)==true){
			out.println("<script>alert('이미 있는 ID입니다 !! ID를 변경하세요.');history.go(-1);</script>");
			
		// 정상 처리 되었을 경우
		} else {
			out.println("<script>alert('사용 가능한 ID입니다');history.go(-1);</script>");
		}
	}
	
	
	// 일반 유저 로그인 할 때 사용
	else if(action.equals("signin")) {
		// 멤버ID와 멤버PW가 MEMBER DB안에 있을 때
		if(memberdao.MatchIDDB(memberlogindto)==true){
			
			// 만약 이전 페이지에서 비밀번호 저장이 체크 되어있지 않으면
			if(request.getParameter("check")==null){
				// 비밀번호 저장되어있던 id,pw,check 값을 삭제시킴
				session.removeAttribute("checkid");
				session.removeAttribute("checkpw");
				session.removeAttribute("check");
			} else {
				
			// 비밀번호 저장이 체크 되어있다면 id, pw를 불러오고, check를 check로 설정하기
			session.setAttribute("checkid",memberlogindto.getid());
			session.setAttribute("checkpw",memberlogindto.getpw());
			session.setAttribute("check","check");
			}
			
		// 로그인 성공시 멤버가 로그인한 것을 on으로 하고 id를 세션에 저장해놓는다 -> 저장한 것은 index페이지에서 로그인 되어있는 것을 보여주기 위함
		session.setAttribute("memberlogin","on");
		session.setAttribute("memberid",memberlogindto.getid());
		
		// 로그인 성공하여 인덱스 페이지로 가게함
		response.sendRedirect("Index.jsp");
		} else {
		// 없을 때 잘못 입력했다고 안내해주고 세션 초기화하여 뒤로 가기
			out.println("<script>alert('잘못 입력하셨습니다. 다시시도하세요!!!');history.go(-1);</script>");
		}
	}
	
	
	// 카카오 로그인 유저 로그인 할 때 사용
	else if(action.equals("kakaologin")) {
		// 카카오 멤버ID와 멤버PW가 MEMBER DB안에 있을 때
		if(memberdao.kakaoMatchIDDB(kakaomemberlogindto)==true){
			// 카카오 로그인에 성공해서 받은 닉네임을 UTF-8로 해독하여 text 변수에 삽입 
			String text = URLDecoder.decode(kakaomemberlogindto.getKnickname(), "UTF-8") ;
			// 로그인 상태를 on으로 한다
			session.setAttribute("memberlogin","on");
			// 카카오 로그인 여부에 on으로 한다
			session.setAttribute("kakaologin","on");
			// 멤버ID에 닉네임을 설정한다
			session.setAttribute("memberid",text);
			// 로그인 성공하여 인덱스 페이지로 가게함
			response.sendRedirect("Index.jsp");
			// 카카오 멤버ID와 멤버PW가 MEMBER DB안에 없을 때
		} else {
			String token;
			String url;
			
			// 카카오 클래스 불러와 처음 로그인 했을 때 상태를 로그아웃으로 바꿔야한다.
			KakaoMemberDAO kakao = new KakaoMemberDAO();
			String key = kakao.getKey();
		
			// 토큰 값 설정
			if(session.getAttribute("token")==null){
				token="";
			}else{
				token=(String)session.getAttribute("token");
			}
	
			// kakaoLogout 함수에 토큰과, ID를 매개변수로 넘겨 로그아웃 시킨 후 인덱스 페이지로 다시 돌아가게한다
			url = "https://kauth.kakao.com/oauth/logout?client_id="+key+"&logout_redirect_uri=http://119.196.106.125/RiotApi/Index.jsp";
			kakao.kakaodelete(token);
			kakao.kakaoLogout(token,kakaomemberlogindto.getKid());
			out.print("<script>alert('회원가입이 되어있지 않은 상태 입니다. 다시 돌아가서 회원가입 먼저 하세요!!!!');location.href='"+url+"';</script>");
		}
	}
	
	
	// 일반 회원, 카카오 회원 로그아웃 할 때 사용
	else if(action.equals("logout")) {
		// 로그아웃 시 memberlogin을 off로 설정하여 인덱스 페이지에서 로그아웃 상태인 것을 보여주기 위함
		session.setAttribute("memberlogin","off");
		// 멤버 ID도 삭제시킴
		session.removeAttribute("memberid");
		
		// 카카오톡 로그아웃일 수 있으니 아래도 진행
		String token;
		KakaoMemberDAO kakao = new KakaoMemberDAO();
		String key = kakao.getKey();
		
		// 카카오 토큰이 없으면
		if(session.getAttribute("token")==null){
			// 토큰 값을 널 값으로 설정
			token=""; 
			// 토큰 값이 널 값이면 일반 로그인 이므로 인덱스 페이지로 바로 가게함
			response.sendRedirect("Index.jsp");
			// 카카오 토큰이 있으면 카카오 로그아웃을 해야하므로
		} else {
			// 토큰을 불러와
			token=(String)session.getAttribute("token");
			// 로그아웃 시키고
			kakao.kakaoLogout(token,kakaomemberlogindto.getKid());
			// 카카오 로그인 세션값을 삭제함
			session.removeAttribute("kakaologin");
			// 그리고 인덱스 페이지로 가게함
			response.sendRedirect("https://kauth.kakao.com/oauth/logout?client_id="+key+"&logout_redirect_uri=http://119.196.106.125/RiotApi/Index.jsp");
		}
	}
	
	// 카카오계정 삭제일 경우
	else if(action.equals("kakaodelete")) {
		// 로그아웃 시 memberlogin을 off로 설정하여 인덱스 페이지에서 로그아웃 상태인 것을 보여주기 위함;
		String token;
		KakaoMemberDAO kakao = new KakaoMemberDAO();
		// 카카오 키 받아오기
		String key = kakao.getKey();
		// 카카오 ID 받아오기
		String id = kakaomemberlogindto.getKid();
		
		// 토큰이 없으면 공백으로 설정
		if(session.getAttribute("token")==null){
			token="";
		// 토큰이 있으면 
		} else {
			// 토큰을 받아오기
			token=(String)session.getAttribute("token");
			// 해당 ID가 DB에 있어 정상적으로 삭제처리가 되면
			if(memberdao.deleteDB(id)) {
				// 삭제가 완료되면 로그인 상태였던 세션을 날리기
				session.setAttribute("memberlogin","off");
				session.removeAttribute("memberid");
				// 카카오 관련된 토큰 삭제, 아이디 삭제 처리하기
				kakao.kakaodelete(token);
				kakao.kakaoLogout(token,kakaomemberlogindto.getKid());
				session.removeAttribute("kakaologin");
				response.sendRedirect("https://kauth.kakao.com/oauth/logout?client_id="+key+"&logout_redirect_uri=http://119.196.106.125/RiotApi/Com_Delete.jsp");
			} else {
				throw new Exception("DB 삭제 오류");
			}
		}
	}
	
	// 일반 회원이 본인 정보 수정할 때 본인 정보를 불러오기 위한 용도로 사용함
	else if(action.equals("edit")){
		// 로그인 성공시 설정해두었던 memeberid를 불러옴
		String id = (String)session.getAttribute("memberid");
		// 본인 수정시 패스워드 입력하는 부분에서 파라미터로 패스워드를 가져옴
		String pw = request.getParameter("edpw");
		
		// 본인 ID와 본인의 PW가 DB와 동일 할 때
		if(memberdao.MatchIDDB(id, pw)==true)
		{
			// 본인 ID와 PW를 파라미터로 넘겨 본인의 정보를 해쉬맵으로 불러와 mbr에 저장하기
			mbr = memberdao.getMbrDB(id, pw);
			// 본인의 정보인 mbr 해쉬맵을 세션에 변수로 저장하기
			session.setAttribute("mbr",mbr);
			// 회원 수정하는 페이지로 가기
			response.sendRedirect("Edit_Member.jsp");
		}
		// 동일하지 않을 때 경고창 띄우고 다시 되돌아가기
		else {
			out.println("<script>alert('잘못 입력하셨습니다. 다시시도하세요!!!');history.go(-1);</script>");
		}
	}
	
	
	// 일반 회원이 본인의 정보를 수정하여 업데이트 할 때 사용함
	else if(action.equals("mbrupdate")){
		// 수정된 값을 파라미터로 받아 업데이트 하기
		if(!membereditdto.getEemember_pw().equals(membereditdto.getEemember_pw2())){
			out.println("<script>alert('비밀번호를 1차 2차 동일하게 입력하세요!!');history.go(-1);</script>");
		}
		else if(memberdao.updateDB(membereditdto)){
			// 업데이트 후 mbr 값 세션에서 삭제
			session.removeAttribute("mbr");
			response.sendRedirect("Com_Edit.jsp");
		}		
	}
	
	
	// 회원 정보 수정창에서 계정 삭제 클릭시 사용
	else if(action.equals("delete")) {
		// 해당 멤버의 id를 db에서 삭제시킴
		String id = (String)session.getAttribute("memberid");
		
		if(memberdao.deleteDB(id)) {
			// 삭제가 완료되면 로그인 상태였던 세션을 날리기
			session.setAttribute("memberlogin","off");
			session.removeAttribute("memberid");
			// 삭제 완료되었다는 페이지로 안내
			response.sendRedirect("Com_Delete.jsp");
		}
		else
			throw new Exception("DB 삭제 오류");
	}
	
	// 날라온 action 파라미터가 잘못되었을 경우
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>