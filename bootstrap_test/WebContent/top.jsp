<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		request.setCharacterEncoding("UTF-8");
	
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
%>

<nav class="navbar navbar-default navbar-fixed-top" role="navigation"
	id="navbar-scroll">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-1-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"><img
				src="./imgs/logo_text.png" alt="logo_text" id=logo></a>
		</div>

		<div
			class="collapse navbar-collapse navbar-right navbar-1-collapse pull-right"
			id="navbar">
			<ul class="nav navbar-nav navbar-text">
				<!-- navbar-text는 임의지정(아래와 차별) -->
				<li><a href="index.jsp">home</a></li>
				<li><a href="#">음식 추천받기</a></li>
				<li><a href="#">맛집 인증</a></li>
				<li><a href="#">결제하기</a></li>


			</ul>



			<%
							if (userID == null) {
						%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
			</ul>
			<%
							} else {
						%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
			</ul>
			<%
							}
						%>


		</div>
	</div>
</nav>