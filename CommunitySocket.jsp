<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>커뮤니티</title>

  <!-- 폰트 적용 -->
  <link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">

  <!-- 아이콘 적용-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

  <!-- 부트스트랩 -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 
  <!--Jquery-->
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
  <!-- 사용자 설정 CSS, JS -->
  <link rel="stylesheet" href="../css/Communitysocket.css">
</head>
<body>
  <!-- 헤더 -->
  <jsp:include page="../Template/C_header.jsp" flush="true"/>
<section>
  <div class="main">
  	<div class="content">
  		<div class="topbackground">
  			<div class="notuse"></div>
  			<div class="top-name"><img src="../img/lo.png"></div>
  			<div class="aa">
  			<div class="Searcha">
   				<form name=searchform class="search2" method=get action=../SearchResult.jsp style="opacity: 1.0;" >
      			<input class="submit1" placeholder="아이디를 입력하세요" type="search" id="gsearch" name="gsearch">
      			<button type="submit" ><i class="fas fa-search" ></i></button>
    			</form>
  			</div>
  			</div>
  			<div class="notuse"></div>
  		</div>
  		<div class="community">	
  			<div class="cnotuse"></div>
  			<div class="user_category">
  				<div class="uc">
  					<div class="userlogin">
  					 <% 
       					 String login;
        				 String kakaologin;
        
				         if((String)session.getAttribute("kakaologin")==null)	{
      						kakaologin="off";
      					 } else {
      						kakaologin = (String)session.getAttribute("kakaologin");
       					 }
    	
      					 if((String)session.getAttribute("memberlogin")==null)	{
      						login="off";
      					 } else {
      						login = (String)session.getAttribute("memberlogin");
      					 }
    					 String id = (String)session.getAttribute("memberid");
    					 if(login.equals("on")){
    						if(kakaologin.equals("on")){
    				%>	
     	     	<div class="userlogin2"><a href="../Edit_KakaoMember.jsp"><%=id%>님</a> 환영합니다 </div>
     			<div class="userlogin3"><button class='logoutbtn' onclick="location.href='../Controller_Member.jsp?action=logout'">로그아웃 하기</button></div>    
      		<%}else {%>
    	  
     			<div class="userlogin2"><a href="../Edit_MemberCheck.jsp"><%=id%>님</a> 환영합니다 </div>
     			<div class="userlogin3"><button class='logoutbtn' onclick="location.href='../Controller_Member.jsp?action=logout'">로그아웃 하기</button></div>
     		 		<% } %>
     				<% } else { %>
     					<div style="display:flex;justify-content:center;align-item:center;">
							<button type="submit" onclick="location.href='../SignIn.jsp'">로그인</button>
						</div>
					<%} %>
  					</div>
  					<hr>  				
  					<div class="category">
  						<ul>
  							<li class="b">홈</li>
  								<ul class="text">
  									<li><a href="Community.jsp">전체</a></li>
  								</ul>
  							<hr>
  							<li class="b">구분</li>
  								<ul class="text">
  									<li><a href="Community.jsp">전체</a></li>
  									<li><a href="CommunityPop.jsp">TOP 10</a></li>
  									<li><a href="Community.jsp">최신</a></li>
  								</ul>
  							<hr>
  						</ul>
  					</div>
  				</div>
  			</div>
  			<div class="write">
  				<div class="writeheader">
  					<div class="writer1">
  						<h4>실시간 대화</h4>
  					</div>
  				</div>
  				<div class="story">
  					<fieldset>
       				 	<textarea class="custom-textarea" id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
        				<br/>
        				<input id="inputMessage" type="text"/>
        				<input id="inputa" type="submit" value="입력" onclick="send()" />
        				<input id="aadd" type="hidden" value="<%=id%>">
    				</fieldset>
  				</div>
  			</div>
  			<div class="cnotuse"></div>
  		</div>
  	</div>
   </div>
</section>
  <!-- 푸터 -->
  <jsp:include page="../Template/C_footer.jsp" flush="true"/>
      <script type="text/javascript">
        // 상대방과 채팅하는 채팅 메시지가 보이는 messageWindow id 태그를 가져와서 textarea에 대입하기
        var textarea = document.getElementById("messageWindow");
     	// WebSocket 오브젝트 생성 (자동으로 접속 시작한다. - onopen 함수 호출)
        // 웹 소켓 오픈 -> 해당 웹 소켓을 처리하는 주소 입력 (ws는 http 방식 프로토콜 wss는 https 방식)
        var webSocket = new WebSocket('ws://119.196.106.125/RiotApi/broadcasting');
        var inputMessage = document.getElementById('inputMessage');
        var a = document.getElementById('aadd').value;
        var random = Math.floor(Math.random() * 10000000) + 1;
        
     	// 서버와 통신 중에 에러가 발생하면 요청되는 함수
 		webSocket.onerror = function(event) {
      		onError(event)
    	};
		
    	// 서버 접속이 되면 호출되는 함수
    	webSocket.onopen = function(event) {
      		onOpen(event)
    	};
	    
    	// 서버로 부터 메시지가 오면 호출되는 함수
	    webSocket.onmessage = function(event) {
      		onMessage(event)
      		textarea.scrollTop = textarea.scrollHeight;
    	};
    	
    	// 서버로 부터 메시지가 오면
    	function onMessage(event) {
    		// 받은 이벤트의 메시지 내용을 : 로 분리하여 array[0]번은 해당 사용자의 아이디가 나오게하고 array[1]번은 해당 사용자가 보낸 내용이 나오게 출력한다
    		var array = event.data.split(":");
    		
    		// 만약 받은 메시지안에 문자열 : 가 들어가면 문자열을 분리하여 아이디 : 내용 으로 출력될 수 있게 한다
    		if(event.data.includes(":")){
    			textarea.value += array[0] + ":" + array[1] + "\n";
    		// 그게 아니면 그냥 출력한다(입장했을 때 안내 메시지)
    		} else {
    			textarea.value += event.data;
    		}
	    }
		
    	// 서버 접속이 되면 
	    function onOpen(event) {
    		// 텍스트 창에 연결 성공이라고 띄우고
        	textarea.value += "연결 성공\n";
    		// 아이디가 없을 경우 즉 로그인이 안되있을 경우 익명입장
        	if(a==="null"){
        		webSocket.send("익명" + random + "님이 입장하셨습니다\n");
        	// 아이디가 있을 경우에는 그 아이디 입장 안내 메시지로 보낸다
        	} else {
        		webSocket.send(a+"님이 입장하셨습니다\n");
        	}
	    }
		
    	// 에러가 발생하면 에러 알림을 띄운다
	    function onError(event) {
      		alert(event.data);
    	}
	    
	 	// send 버튼을 누르면 호출되는 함수
    	function send() {
	 		// 스크롤을 계속 제일 아래로 유지하게 해주는 구문
    		textarea.scrollTop = textarea.scrollHeight;
	 		// 아이디가 없을 때 즉 로그인이 안되있을 경우 익명 : 내용 으로 나갈 수 있게하고
    		if(a==="null"){
    			textarea.value += "익명"+ random + " : " + inputMessage.value + "\n";
    			webSocket.send("익명"+ random +  " : " + inputMessage.value);
    		// 아이디가 있을 경우 아이디 : 내용으로 나갈 수 있게 한다
    		} else {
    			textarea.value += a + " : " + inputMessage.value + "\n";
    			webSocket.send(a + " : " + inputMessage.value);
    		}
	 		// 그리고 입력창을 다시 공백으로 비운다
        	inputMessage.value = "";
 	   }
	 	
 
  </script>
</body>
</html>