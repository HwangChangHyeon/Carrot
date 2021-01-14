<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"  import="DAODTO.*,java.util.*" errorPage="../ErrorPage.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- DB 접근 Class 선언 -->
<jsp:useBean class="DAODTO.AdminDAO" id="admindao" scope="session"/>

<!-- 데이터 접근 Class 선언 -->
<jsp:useBean class="DAODTO.AdminLoginDTO" id="adminlogindto" scope="session"/>
<jsp:useBean class="DAODTO.AdminAddDTO" id="adminadddto" scope="session"/>
<jsp:useBean class="DAODTO.AdminEditDTO" id="admineditdto" scope="session"/>

<!-- 해당 Class에 값 설정 -->
<jsp:setProperty name="adminlogindto" property="*"/>
<jsp:setProperty name="adminadddto" property="*"/>
<jsp:setProperty name="admineditdto" property="*"/>

<% 
	// 컨트롤러 요청 파라미터
	String action = request.getParameter("action");
	HashMap<String, String> mbr = new HashMap<String, String>();


	// 관리자 페이지에 모든 회원 정보를 출력할 때 사용함
	if(action.equals("list")) {
		// DB 리스트를 datas 배열에 넣음
		ArrayList<AdminAddDTO> addatas = admindao.getDBList();
		// datas 배열을 세션에 변수로 저장
		session.setAttribute("addatas", addatas);
		// 모든 회원 정보를 출력하는 jsp로 이동
		response.sendRedirect("AdminUserinfo.jsp");
	}
	
	// 관리자 페이지에서 회원 추가 할 때 사용함
	else if(action.equals("admininsert")) {
		// 파라미터로 받아온 1차 패스워드와 2차패스워드가 동일하지 않을 때 경고 창 띄우고 다시 되돌아가기
		if(!adminadddto.getAmember_pw().equals(adminadddto.getAmember_pw2())){
			out.println("<script>alert('비밀번호를 1차 2차 동일하게 입력하세요!!');history.go(-1);</script>");
		}
		// 파라미터로 받은 회원 정보의 객체를 디비에 저장시킴
		else if(admindao.insertDB(adminadddto)) {
			response.sendRedirect("AdminController.jsp?action=usernum");
		}
		else
			throw new Exception("DB 입력오류");
	}
	
	
	// 관리자 로그인 할 때 사용
	else if(action.equals("adminsignin")) {
		// 관리자 ID와 관리자PW가 관리자 DB안에 있을 때
		if(admindao.AdminMatchIDDB(adminlogindto)==true){
			// 로그인 성공하여 인덱스 페이지로 가게함
			session.setAttribute("adminlogin","on");
			session.setAttribute("adminid",adminlogindto.getAdid());
			response.sendRedirect("AdminController.jsp?action=usernum");
		}else{
			// 없을 때 잘못 입력했다고 안내해주고 세션 초기화하여 뒤로 가기
			out.println("<script>alert('잘못 입력하셨습니다. 다시시도하세요!!!');history.go(-1);</script>");
		}
	}
	
	// 관리자 페이지에서 adminindex 페이지에 뜨는 그래프 현황을 띄우기 위해 유저의 ID 개수와 루트 유저의 ID개수를 구할 때 사용
	else if(action.equals("usernum")) {
		// 일반 유저 ID 개수 확인 후 세션에 저장
		session.setAttribute("usernum",admindao.getDBListnum());
		// 루트 유저 ID 개수 확인 후 세션에 저장
		session.setAttribute("adminnum",admindao.getadminDBListnum());
		session.setAttribute("contentnum",admindao.getContentListnum());
		response.sendRedirect("AdminIndex.jsp");
	}
	
	// 관리자 로그아웃 할 때 사용
	else if(action.equals("adminlogout")) {
		// 세션 초기화하여 로그인 정보 없애고 관리자 로그인 페이지로 가게하기
		session.setAttribute("adminlogin","off");
		session.removeAttribute("adminid");
		response.sendRedirect("AdminLogin.jsp");
	}
	
	// 관리자 회원이 일반 회원의 정보를 수정할 때 회원의 모든 정보를 불러오기 위한 용도로 사용함
	else if(action.equals("adminedit")){
	
		String editid = request.getParameter("edit_id");
		
		// 관리자가 입력한 회원의 ID가 DB정보에 있을 때
		if(admindao.AdminMatchIDDB(editid)==true)
		{
			// 관리자가 입력한 회원의 ID를 파라미터로 넘겨 그 회원의 정보를 해쉬맵으로 불러와 mbr에 저장하기
			mbr = admindao.getMbrDB(editid);
			// 불러온 회원 정보를 세션에 mbr로 저장하기
			session.setAttribute("admbr",mbr);
			// 회원 정보 수정 창으로 보내기
			response.sendRedirect("AdminUseredit2.jsp");
		}
		// 관리자가 입력한 회원의 ID가 DB에 없을 때 경고 창 띄우기
		else{
			out.println("<script>alert('잘못 입력하셨습니다. 다시시도하세요!!!');history.go(-1);</script>");
		}
	}
	
	
	// 관리자가 일반 회원의 정보를 수정하여 업데이트 할 때 사용함
	else if(action.equals("adminmbrupdate")){
		// 관리자가 일반 회원의 정보를 수정할 때 1차, 2차 패스워드가 동일하지 않으면 안내 메시지 띄움
		if(!admineditdto.getEmember_pw().equals(admineditdto.getEmember_pw2())){
			out.println("<script>alert('비밀번호를 1차 2차 동일하게 입력하세요!!');history.go(-1);</script>");
		}
		
		// 수정된 값을 파라미터로 받아 업데이트 하기
		else if(admindao.updateDB(admineditdto)){
			/// 업데이트 후 mbr 값 세션에서 삭제
			session.removeAttribute("admbr");
			// 수정 완료되었다는 창으로 보내기
			response.sendRedirect("AdminController.jsp?action=list");
		}
		
	}
	
	// 회원 정보 수정창에서 계정 삭제 클릭시 사용
	else if(action.equals("delete")) {
		
		// 회원 정보 수정창에서 설정한 admbr 객체에서 해당 아이디를 삭제하기 위해 id만 불러옴
		HashMap<String, String> admbr = new HashMap<String, String>();
		admbr = (HashMap<String, String>)session.getAttribute("admbr");

		// 해당 멤버의 id를 db에서 삭제시킴
		if(admindao.deleteDB(admbr.get("member_id"))) {
			// 삭제 완료되었다는 페이지로 안내
			response.sendRedirect("AdminController.jsp?action=usernum");
		}
		else
			throw new Exception("DB 삭제 오류");
	}
	
	// 관리자 페이지에서 회원 게시글 삭제처리 할 때 사용 
	else if(action.equals("contentdelete")) {
		
		// 회원 게시글의 게시글 번호를 받아온다
		int bbsid = Integer.parseInt(request.getParameter("bbsid"));

		// 게시글 삭제 처리하는 메서드에 게시글 번호 넣음
		int result = admindao.delete(bbsid);

		// 비정상 처리시 안내
		if(result==-1){
			out.println("<script>alert('삭제 처리가 되지 않았습니다')</script>");
		// 정상 처리시 게시글 현황으로 가게하기
		} else {
			response.sendRedirect("AdminCommunity.jsp");
		}
		
	}
	
	// 날라온 action 파라미터가 잘못되었을 경우
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>