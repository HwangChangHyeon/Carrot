<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<%@ page import="DAODTO.BbsDAO"%>
<%@ page import="DAODTO.BbsDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<jsp:useBean id="bbs" class="DAODTO.BbsDTO" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


<%
	// 전 페이지에서 어떤 동작을 해야하는지 확인하는 action 태그를 불러와 저장
	String action = request.getParameter("action");
	String userID = "";
	BbsDAO bbsDAO = new BbsDAO();
	String bbsTitle = null;
	String bbsContent = null;
	String filename = null;
	
	if(request.getParameter("action")==null){
		final String saveFolder = "C:\\Users\\korea\\workspace\\RiotApi\\WebContent\\img\\Communityimg";
		final String encoding = "UTF-8";
		final int maxSize = 10 * 1024 * 1024; //10mb 
		
		MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
		
		action = multi.getParameter("action");
		bbsTitle = multi.getParameter("bbsTitle");
		bbsContent = multi.getParameter("bbsContent");
		filename = multi.getFilesystemName("uploadFile");
	}
	
	
	
// 세션에서 멤버 ID를 불러와 null이 아니면 userID에 id 값을 집어넣는다 
if (session.getAttribute("memberid") != null) {
	userID = (String) session.getAttribute("memberid");
}

// 게시글 작성일 경우
if (action.equals("write")) {

	// 타이틀과 컨텐츠가 비었으면 다시 되돌아가게하고
	if (bbsTitle == null || bbsContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	// 내용이 모두 차 있으면
	} else {
		// DB에 저장시킨다
		int result = bbsDAO.write(bbsTitle, userID, bbsContent, filename);
		// DB에서 반환 값이 -1로 오류가 발생하면 실패했습니다를 띄우고
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		// DB에서 정상 처리되면 커뮤니티 페이지로 돌아간다.
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'Community.jsp'");
			script.println("</script>");
		}
	}
}

// 게시글 삭제일 경우
else if (action.equals("delete")) {
	
	int bbsID = 0;
	// 게시글 번호를 불러와 null 값이 아니면 bbsID를 가져온다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	// 게시글 번호가 0일 경우 유효하지 않은 글이므로 알림 띄우고 커뮤니티로 다시 간다.
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}

    // 게시글 번호를 집어넣어 게시글에 있는 값들을 모두 가져온다.
	BbsDTO bbsa = new BbsDAO().getBbs(bbsID);
    
    // 게시글을 작성한 사람의 ID와 현재 로그인 한 사람의 ID가 다를 경우 권한이 없음을 안내하고 커뮤니티 홈페이지로 가게한다.
	if (!userID.equals(bbsa.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	// 정상적인 권한 일 때 디비에서 삭제시킨다
	} else {
		int result = bbsDAO.delete(bbsID);
		// 반환 값이 -1일 때 비정상 종료로 글삭제 실패 안내
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		// 정상 처리 되었을 때 커뮤니티 사이트로 가게 함.
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'Community.jsp'");
			script.println("</script>");
		}
	}
}

// 게시글 수정 일 경우
else if (action.equals("update")) {
	
	
	int bbsID = 0;
	// 게시글 번호를 불러와 null 값이 아니면 bbsID를 가져온다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	// 게시글 번호가 0일 경우 유효하지 않은 글이므로 알림 띄우고 커뮤니티로 다시 간다.
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}
	
    // 게시글 번호를 집어넣어 게시글에 있는 값들을 모두 가져온다.
	BbsDTO bbss = new BbsDAO().getBbs(bbsID);
    
	// 게시글을 작성한 사람의 ID와 현재 로그인 한 사람의 ID가 다를 경우 권한이 없음을 안내하고 커뮤니티 홈페이지로 가게한다.
	if (!userID.equals(bbss.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
		
	// 정상적인 권한 일 때 
	} else {
		// 타이틀과, 내용이 비어있을 경우 입력 다시 하게 되돌아가기 기능 
		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
		|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		// 타이틀과, 내용이 차있을 경우 디비에 업데이트 시키기
		} else {
			int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
			
			// 반환 값이 -1일 때 비정상 종료로 글 수정 실패 안내
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				
			// 정상 처리 되었을 때 커뮤니티 사이트로 가게 함.
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'Community.jsp'");
				script.println("</script>");
			}
		}
	}
}

// 게시물 추천 기능
else if (action.equals("up")) {
	int bbsID = 0;
	
	// 게시글 번호를 불러와 null 값이 아니면 bbsID를 가져온다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	// 게시글 번호가 0일 경우 유효하지 않은 글이므로 알림 띄우고 커뮤니티로 다시 간다.
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}

	// 게시물 번호를 매개변수로 넘겨 해당 게시물의 디비에 + 1 값을 해준다
	int resultpop = bbsDAO.updatePop(bbsID);
	

	// 반환 값이 -1일 때 비정상 종료로 글 추천 실패 안내
	if (resultpop == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 추천에 실패하였습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		// 정상 처리 되었을 때 게시글로 가게함
		response.sendRedirect("CommunityView.jsp?bbsID=" + bbsID);
	}

}


// 게시물 댓글 달기 기능
else if (action.equals("reply")) {
	int bbsID = 0;
	
	// 게시글 번호를 불러와 null 값이 아니면 bbsID를 가져온다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	// 게시글 번호가 0일 경우 유효하지 않은 글이므로 알림 띄우고 커뮤니티로 다시 간다.
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}
	
	// userID가 공백일 경우(로그인이 아닐 경우) 되돌아가게함
	if (userID.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.go(-1);");
		script.println("</script>");
	// 정상 로그인 일 경우
	} else {
		
		// 해당 게시물 번호 글에 댓글 내용을 ID와 함께 DB에 저장  
		int result = bbsDAO.reply(bbsID, userID, request.getParameter("bbsContent"));


		// 반환 값이 -1일 때 비정상 종료로 댓글 입력 불가
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		// 정상 처리 되었을 때 게시글로 가게함
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'CommunityView.jsp?bbsID=" + bbsID + "'");
			script.println("</script>");
		}
	}
}


// 게시물 댓글 삭제 기능
else if (action.equals("deletereply")) {
	int bbsID = 0;
	
	// 게시글 번호를 불러와 null 값이 아니면 bbsID를 가져온다.
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	// 게시글 번호가 0일 경우 유효하지 않은 글이므로 알림 띄우고 커뮤니티로 다시 간다.
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}

	// DB에서 삭제 처리(받아온 content는 ID가 아닌 동일한 시간을 찾아서 삭제하는 것으로 함)
	int result = bbsDAO.deletereply(request.getParameter("content"));
	
	// 비정상 처리시 삭제 실패 안내
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 삭제에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	
	// 정상 처리시 게시글로 가게함
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'CommunityView.jsp?bbsID=" + bbsID + "'");
		script.println("</script>");
	}
}

// 게시물 찾기 기능
else if (action.equals("searchbbs")) {
	// 이전 페이지에서 찾는 게시물의 제목을 불러오기
	String search = request.getParameter("sbbs");
	
	// 공백일 경우 재안내
	if(search.equals("")){
		out.print("<script>alert('찾으시려는 제목을 입력하세요'); history.go(-1);</script>");
	}
	// 공백이 아닐 경우
	else{
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		// DB에서 해당 제목을 가지고 있는 게시글의 정보들을 전부 불러와 list에 담기
		list = bbsDAO.getsearchList(search);
		// 세션에 저장하고
		session.setAttribute("searchname", list);
		// Search 홈페이지로 가게하기
		response.sendRedirect("CommunitySearch.jsp");
	}
}

// 받은 파라미터 Action이 없는 값일 경우
else {
	out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
}
%>