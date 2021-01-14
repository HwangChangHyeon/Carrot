<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 - 회원 추가</title>

<!-- 폰트 적용 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" >

<!-- 아이콘 적용-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!--Jquery-->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>

<!-- 사용자 설정 CSS, JS -->
<link rel="stylesheet" href="../css/adminuseradd.css">
<link rel="stylesheet" href="../css/form-validation.css" >
<script src="../js/main.js" defer></script>

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="AdminHeader.jsp" />
	<!-- 틀 잡기위한 메인 -->
	<div class="main">
		<!-- 아티클 -->
		<jsp:include page="AdminArticle.jsp" />
		<!-- 섹션 -->
		<section>
			<div class="container">
				<div class="py-5 text-center">
					<div class="Carrot">
						<a href="AdminController.jsp?action=usernum"><i class="fas fa-carrot"></i></a>
					</div>
					<h3>일반 회원 추가</h3>
				</div>
				<div class="row">
					<div class="col-md-8 order-md-1">
						<!-- 회원 추가 Form 태그 -->
						<form class="needs-validation" novalidate method="post"	action="AdminController.jsp">
							<div class="mb-3">
								<!-- 컨트롤러에 넘길 파라미터 -->
								<input type=hidden name="action" value="admininsert"> 
								<label for="lastName">이름</label>
								<input type="text" class="form-control" name="amember_name" id="name" placeholder="이름을 적으세요" required>
								<div class="invalid-feedback">이름을 적으셔야 합니다.</div>
							</div>
							<div class="mb-3">
								<label for="username">아이디</label>
								<div class="input-group">
									<input type="text" class="form-control" name="amember_id" id="username" placeholder="아이디를 적으세요" required>
									<div class="invalid-feedback" style="width: 100%;">아이디를 적으셔야 합니다.</div>
								</div>
							</div>
							<label for="pwd" class="mr-sm-2">패스워드</label> 
							<input type="password" name="amember_pw"	class="form-control mb-2 mr-sm-2" placeholder="패스워드를 입력하세요"	id="pwd" required>
							<div class="invalid-feedback" style="width: 100%;">패스워드를 적으셔야 합니다.</div>
							<label for="pwd2" class="mr-sm-2">패스워드 확인</label> 
							<input type="password" name="amember_pw2" class="form-control mb-2 mr-sm-2" placeholder="패스워드를 다시 한 번 입력하세요" id="pwd2" required>
							<div class="invalid-feedback" style="width: 100%;">패스워드를 적으셔야 합니다.</div>
							<div class="mb-3">
								<label for="email">이메일</label> 
								<input type="email"	name="amember_email" class="form-control" id="email" placeholder="you@example.com" required>
								<div class="invalid-feedback">이메일을 적으셔야 합니다.</div>
							</div>
							<div class="mb-3">
								<label for="tel">연락처</label> 
								<input type="tel" name="amember_phone" class="form-control" id="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-0000-0000 형식으로 적으세요" required>
								<div class="invalid-feedback">연락처를 적으셔야합니다.</div>
							</div>
							<div class="row">
								<div class="col-md-12 mb-3">
									<label for="country">국가</label> 
									<select	class="custom-select d-block w-100" name="amember_country" id="country" required>
										<option value="">Choose...</option>
										<option>Korea</option>
										<option>United State</option>
										<option>China</option>
										<option>Japanese</option>
									</select>
									<div class="invalid-feedback">국가를 선택하세요.</div>
								</div>
							</div>
							<hr class="mb-4">
							<button class="btn btn-primary btn-lg btn-block" type="submit">회원 추가</button>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../Template/C_footer.jsp" flush="true" />
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/form-validation.js"></script>
</body>
</html>