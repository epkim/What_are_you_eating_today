<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>    
    
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
<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>


	<div class="container-fluid">
		<div class="container">
			
			<!-- top 페이지 분리 -->
			<jsp:include page="top.jsp"/>
			
			
			<div class="container main_carousel">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<img src="./imgs/main_img1_re.jpg">
							<div class="carousel-caption">
								<h1 class="">오늘 뭐 먹지???</h1>
								<p>지금 이 순간에도 어떤걸 먹을지 고민하는 당신을 위해 만들었습니다.</p>
								<p><a class="btn btn-primary btn-pull" href="#" role="button" data-target="#layerpop" data-toggle="modal">추천 받기</a></p>
							</div>
						</div>
						<div class="item">
							<img src="./imgs/main_img2_re.png">
						</div>
						<div class="item">
							<img src="./imgs/main_img3_re.jpg">
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</div>
			</div>
			
			
			
			
			<div class="modal fade" id="layerpop" >
			<div class="modal-dialog">
			
				<!-- map.jsp로 전송할 폼양식 -->
				<form action="map.jsp" method="post">
				    <div class="modal-content">
				      <!-- header -->
				      <div class="modal-header">
				        <!-- 닫기(x) 버튼 -->
				        <button type="button" class="close" data-dismiss="modal">×</button>
				        <!-- header title -->
				        <h4 class="modal-title">대한민국 어디든지 가능합니다!!!</h4>
				      </div>
				      <!-- body -->
				      <div class="modal-body">
				            <p>지역만 입력해주시면 다 찾아드릴께요.</p>
				            
				            
				            
				            
				            <!-- 검색 기능을 표시할 <div>를 생성한다 -->
							<div id="postcodify"></div>
							
							<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 id를 부여한다 -->
							주소 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" name="address" id="address" value="" /><br />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" name="extra_info" id="extra_info" value="" /><br />
							우편번호 : &nbsp;<input type="text" name="postcode" id="postcode" value="" /><br />
							<br />상세주소를 입력해주세요.<br /><input type="text" name="details" id="details" value="" /><br />
							
	
							
							<!-- 위에서 생성한 <div>에 검색 기능을 표시하고, 결과를 입력할 <input>들과 연동한다 -->
							<script>
							    $(function() { $("#postcodify").postcodify({
							        insertPostcode5 : "#postcode",
							        insertAddress : "#address",
							        insertDetails : "#details",
							        insertExtraInfo : "#extra_info",
							        hideOldAddresses : false
							    }); });
							</script>
				            
				            
				            
				            
				      </div>
				      <!-- Footer -->
				      <div class="modal-footer">
				        <input type="submit" class="btn btn-default" value="찾아보기">
				        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				      </div>
			      </form>
			    </div>
			  </div>
			</div>


			
			
			
			<div class="container">
				<div class="row service">
					<div class="col-xs-6 col-md-3">
						<a href="#"><span class="glyphicon glyphicon-certificate icons"></span>
							<h4>오늘의 식사 추천</h4>
							<p>오늘의 식사를 자동으로 추천하여 사용자에게 안내해줍니다.</p>
						</a>
					</div>
					<div class="col-xs-6 col-md-3">
						<a href="#"><span class="glyphicon glyphicon-phone icons"></span>
							<h4>오늘의 날씨 안내</h4>
							<p>오늘의 날씨를 지역별로 사용자에게 안내해줍니다.</p>
						</a>
					</div>
					<div class="col-xs-6 col-md-3">
						<a href="#"><span class="glyphicon glyphicon-refresh icons"></span>
							<h4>맛집 인증</h4>
							<p>식사를 하신 다른 사용자들의 이야기를 적어놓은 게시판입니다.</p>
						</a>
					</div>
					<div class="col-xs-6 col-md-3">
						<a href="#"><span class="glyphicon glyphicon-user icons"></span>
							<h4>뭐먹었었지?,가상화폐 결제</h4>
							<p>사이트를 통해 먹었던 음식을 알려주고 주문한 음식을 가상화폐로 결제할수 있습니다.</p>
						</a>
					</div>
				</div>
			</div>
			
			
			
			<div class="panel panel-primary" style="margin-bottom: 130px;">
			 	<div class="panel-heading">
			 		<h3 class="panel-title"><span class="glyphicon-pencil"></span>
			 		&nbsp;&nbsp;방송맛집목록</h3>		
			 	</div>
			 	<div class="panel-body">
			 		<div class="media">
			 			<div class="media-left">
			 				<a href="#"><img class="media-object" src="imgs/tv.jpg" width="150" height="150" alt="tv"></a>
			 			</div>
			 			<div class="media-body">
			 				<h4 class="media-heading">"기타채널에 나왔던 맛집"<a href="#"></a>&nbsp;<span class="badge">New</span></h4>
			 				케이블채널방송을 보면서 입맛을 다셨지만 어딘지 몰라서 못 가셨던 여러분들을 위해 어느 방송에 나왔던 어느 맛집인지 여러분들한테 소개해드립니다.
			 			</div>	
			 		</div>
			 		<hr>
			 		<div class="media">
			 			<div class="media-left">
			 				<a href="#"><img class="media-object" src="imgs/kbs.jpg" width="150" height="150" alt="tv"></a>
			 			</div>
			 			<div class="media-body">
			 				<h4 class="media-heading">"KBS에 나왔던 맛집"<a href="#"></a>&nbsp;<span class="badge">New</span></h4>
			 				KBS방송을 보면서 입맛을 다셨지만 어딘지 몰라서 못 가셨던 여러분들을 위해 어느 방송에 나왔던 어느 맛집인지 여러분들한테 소개해드립니다.
			 			</div>	
			 		</div>
			 		<hr>
			 		<div class="media">
			 			<div class="media-left">
			 				<a href="#"><img class="media-object" src="imgs/sbs.jpg" width="150" height="150" alt="tv"></a>
			 			</div>
			 			<div class="media-body">
			 				<h4 class="media-heading">"SBS에 나왔던 맛집"<a href="#"></a>&nbsp;<span class="badge">New</span></h4>
			 				SBS방송을 보면서 입맛을 다셨지만 어딘지 몰라서 못 가셨던 여러분들을 위해 어느 방송에 나왔던 어느 맛집인지 여러분들한테 소개해드립니다.
			 			</div>	
			 		</div>
			 		<hr>
			 		<div class="media">
			 			<div class="media-left">
			 				<a href="#"><img class="media-object" src="imgs/mbc.jpg" width="150" height="150" alt="tv"></a>
			 			</div>
			 			<div class="media-body">
			 				<h4 class="media-heading">"MBC에 나왔던 맛집"<a href="#"></a>&nbsp;<span class="badge">New</span></h4>
			 				MBC방송을 보면서 입맛을 다셨지만 어딘지 몰라서 못 가셨던 여러분들을 위해 어느 방송에 나왔던 어느 맛집인지 여러분들한테 소개해드립니다.
			 			</div>	
			 		</div>
			 	</div>		
			</div>	
			
			
			
		</div>
		
		<!-- footer 페이지 분리 -->
		<jsp:include page="footer.jsp"/>
		
	</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="./js/bootstrap.js"></script>

<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

</body>
</html>