<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<title>오늘 뭐 먹지???</title>
</head>
<body>

	<div class="container-fluid">
		<div class="container">
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation" id="navbar-scroll">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collaspse" data-target=".navbar-1-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="index.jsp"><img src="./imgs/logo_text.png" alt="logo_text" id=logo></a>
					</div>
					
					<div class="collapse navbar-collapse navbar-right navbar-1-collapse">
						<ul class="nav navbar-nav navbar-text"> <!-- navbar-text는 임의지정(아래와 차별) -->
							<li><a href="index.jsp">home</a></li>
							<li><a href="#">about</a></li>
							<li><a href="#">portfolio</a></li>
							<li><a href="#">contact</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
							aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul>
						</ul>
					</div>
				</div>
			</nav>


			<div class="container" id="login_container">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">
					<div class="jumbotron" style="padding-top:20px;">
						<form method="post" action="loginAction.jsp">
							<h3 style="text-align:center; margin-bottom:30px;">로그인 화면</h3>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
							</div>
							<input type="submit" class="btn btn-primary form-control" value="로그인">
						</form>
					</div>
				</div>
				<div class="col-lg-3"></div>
				
			</div>



		</div>
		
		<footer class="footer">
			<div class="container">
				ALL CONTENTS COPYRIGHT&#169; 2018 김응표
			</div>
		</footer>
	</div>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
</body>
</html>