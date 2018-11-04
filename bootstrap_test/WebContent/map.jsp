<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="map.*" %>
<%@ page import="java.util.ArrayList" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>오늘 뭐 먹지???</title>
<link href="./css/bootstrap.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<!-- 네이버지도 API -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=gkj3RmtL051U7oUW9uA7&submodules=geocoder"></script>
<!-- jquery -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<!-- bootstrap.js -->
<script src="./js/bootstrap.js"></script>
<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
</head>
<body>

<style>
	.main {
		width: 100%;
		height: 100%;
	}
	
	.view {
		height: 100%;
		margin-top: 130px;
		margin-left: 25px;
		margin-right: 25px;
		margin-bottom: 50px;
	}
	
	.address, .weatherC, .content {
		padding: 15px;
	}
	
	.address {
		height: 25%;
	}
	
	.weatherC {
		height: 50%;
	}
	
	.content {
		height: 25%;
	}
	
	div.main {
		font-family: 'Nanum Pen Script', cursive;
		font-size: 25px;
	}
</style>

<jsp:include page="top.jsp"/>


	<%
		request.setCharacterEncoding("UTF-8");
	
		String address = (String)request.getParameter("address");
		String extra_info = (String)request.getParameter("extra_info");
		String postcode = (String)request.getParameter("postcode");
		String details = (String)request.getParameter("details");
		
		/* out.println("주소 : " + address + extra_info + "<br />");
		out.println("우편 번호 : " + postcode + "<br />");
		out.println("세부 주소 : " + details + "<br />"); */
		
		System.out.println(address);
		System.out.println(extra_info);
		System.out.println(postcode);
		System.out.println(details);
		
	%>


	<!-- DB에서 식당 정보 가져오기 -->
	<%
		String[][] restaurant_name = new String[1][];	// 식당 이름 배열(java)
		restaurant_name[0] = new String[10];
		restaurant_name[0][0] = "a";
		int a = 0;						// for문 임시 변수
	
      	MapDAO mapDAO = new MapDAO();
      	ArrayList<Map> list = mapDAO.mapList();
      	
      	int endCount = list.size();
    	int count = 1;
    	System.out.println(endCount);
    	String resultJSON = "";
    	
    	resultJSON += "[";
    	for(Map result : list) {
    		resultJSON += "{";
    		resultJSON += "name:\"" + result.getName() + "\",";
    		resultJSON += "Lat:\"" + result.getLat() + "\",";
    		resultJSON += "Lng:\"" + result.getLng() + "\",";
    		resultJSON += "height:\"" + result.getFood() + "\",";
    		resultJSON += "day:\"" + result.getAddress() + "\"";
    		if(count == endCount) {
    			resultJSON += "}";
    		} else {
    			resultJSON += "},";			
    		}
    		count++;
    	}
    	resultJSON += "]";
	%>
	


<div class="main">
	<div class="view row">
		<div class="col-xs-12 col-md-5">
			<div class="row address">
				검색하신 주소는 다음과 같습니다.<br>
				<%=address %>&nbsp;<%=extra_info %>&nbsp;<%=details %><br>
				<%=postcode %>
			</div>
			<div class="row weatherC">
				<table class="weather"></table>
			</div>
			<div class="row content">
				<%--
					for(Map res : list) {
						out.println(res.getName() + "&nbsp;");
						out.println(res.getAddress() + "&nbsp;");
						out.println(res.getPhone() + "&nbsp;");
						out.println(res.getWeather() + "&nbsp;");
						out.println(res.getFood() + "&nbsp;");
						out.println(res.getLat() + "&nbsp;");
						out.println(res.getLng() + "&nbsp;");
						out.println("<br>");
					}
				--%>
			</div>
		</div>
		<div class="col-xs-12 col-md-7">
			<div id="map" style="width:100%;height:500px;"></div>
		</div>
	</div>
</div>
	

	
	
	
      
      <%-- <%=map.getName() %> &nbsp;
      <%=map.getAddress() %> &nbsp;
      <%=map.getPhone() %> &nbsp;
      <%=map.getWeather() %> &nbsp;
      <%=map.getFood() %> &nbsp;
      <%=map.getLat() %> &nbsp;
      <%=map.getLng() %> &nbsp; --%>
	  
	<%
		for(Map map:list) {
	
		restaurant_name[0][a] = (String)map.getName();
		System.out.println("가게이름은 : " + restaurant_name[0][a]);
		a++;
      	}
	%>
	
	<script>alert("<%=restaurant_name[0][0]%>");</script>
	
	<br /><br />
	
	
	<!-- <div id="map2" style="width:100%;height:400px;"></div> -->
    <script type="text/javascript">
      var map = new naver.maps.Map('map');
      var myaddress = '<%= address %>';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          alert('<%= address %>');
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
          // 마커 클릭 이벤트 처리
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4> [네이버 개발자센터1]</h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
          });
          
          
       // 테스트
       var arr = [
        	{
        		Lat : 37.5122,
                Lng : 126.9229,
                name : "1"
        	}, {
        		Lat : 37.5224,
                Lng : 126.9326,
                name : "2"
        	}, {
        		Lat : 37.5223,
                Lng : 126.9097,
                name : "3"
        	}, {
        		Lat : 36.347665,	// 차이나문
                Lng : 127.450592,
                name : "차이나문"
            }, {
                Lat : 36.346195,    // 유가옥
                Lng : 127.444584,
                name : "유가옥"
            }
        ];
       
       
       // DB에서 받은 값을 배열로(Lat)
       var restaurant_Lat = [];
       <%int i=0;%>
       <%for(Map map:list) {%>
       restaurant_Lat[<%=i%>] = '<%=map.getLat()%>';
       <%i++; }%>

       
       // DB에서 받은 값을 배열로(Lng)
       var restaurant_Lng = [];
       <%int j=0;%>
       <%for(Map map:list) {%>
       restaurant_Lng[<%=j%>] = '<%=map.getLng()%>';
       <%j++; }%>
       
       
       // DB에서 받은 값을 배열로(name)
       var restaurant_name = [];
       <%int k=0;%>
       <%for(Map map:list) {%>
       restaurant_name[<%=k%>] = '<%=map.getName()%>';
       <%k++; }%>

       
        
       // 위경도 직접 입력
  		console.log(myaddr);
  		var marker2 = new naver.maps.Marker({
            position: new naver.maps.LatLng(36.3508310, 127.4486830),
            map: map
          });
  		
  		naver.maps.Event.addListener(marker2, "click", function(e) {
            if (infowindow2.getMap()) {
                infowindow2.close();
            } else {
                infowindow2.open(map, marker2);
            	map.setCenter(naver.maps.LatLng(36.3508310, 127.4486830)); // 검색된 좌표로 지도 이동
            }
          });
        var infowindow2 = new naver.maps.InfoWindow({
            content: '<h4> [다음 개발자센터2]</h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
        });
        
        
        console.log(arr);
        console.log(arr[0]);
        
        // 위경도 배열 입력
        var latLng = new naver.maps.LatLng(arr[1].Lat, arr[1].Lng);
        var marker3 = new naver.maps.Marker({
    		position: latLng,
    		map: map
    	});
        naver.maps.Event.addListener(marker3, "click", function(e) {
            if (infowindow3.getMap()) {
                infowindow3.close();
            } else {
                infowindow3.open(map, marker3);
            	map.setCenter(latLng); // 검색된 좌표로 지도 이동
            }
          });
        var infowindow3 = new naver.maps.InfoWindow({
            content: '<h4> [다음 개발자센터3]</h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
        });
        
        
        /* var latLng = [];
        var marker = [];
        var infowindow = [];
        
    
        for(var i in restaurant_Lat) {
        	//var latLng = new naver.maps.LatLng(arr[i].Lat, arr[i].Lng);
			latLng[i] = new naver.maps.LatLng(restaurant_Lat[i], restaurant_Lng[i]);
			
        	marker[i] = new naver.maps.Marker({
        		position: latLng[i],
        		map: map
        	});
        	
        	
        	new naver.maps.Event.addListener(marker[i], "click", function(e) {
                if (infowindow[i].getMap()) {
                    infowindow[i].close();
                } else {
                    infowindow[i].open(map, marker[i]);
                	//map.setCenter(latLng); // 검색된 좌표로 지도 이동
                }
              });
            infowindow[i] = new naver.maps.InfoWindow({
                content: '<h4> ㅏㅏ <div id="name"></div></h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
            });

            function nameCallback() {
                document.getElementById('name').innerHtml = "입력";
            }
            
            
            console.log("infowindow : " + infowindow[i]);
        }; */

        
        var allmountain = <%=resultJSON %>;
    	
    	
    	var markers = [];		// 데이터 배열화(다중 정보창에 활용)
    	var infoWindows = [];	// 데이터 배열화(다중 정보창에 활용)
    	var allmountaintotal = allmountain.length - 1;
    	alert("total : " + allmountaintotal);
    	for(i = 0; i <= allmountaintotal; i++) {
    		var markerOptions = {
    			title: allmountain[i].name,
    			position: new naver.maps.LatLng(allmountain[i].Lat, allmountain[i].Lng),
    			map: map,
    			icon: {
    				url: 'http://cfs.tistory.com/custom/blog/19/191630/skin/images/flag_red48.png',
    				size: new naver.maps.Size(48, 48),
    				origin: new naver.maps.Point(0, 0),
    				anchor: new naver.maps.Point(0, 0)
    			}
    		};
    		var marker = new naver.maps.Marker(markerOptions);

    		// for문에 이어서 다중 마커의 정보창 설정
    			// 마커의 정보창 내용과 디자인 시작
    			var contentString = [
    			'<div class="iw_inner">',
    			'	<img src="http://cfs.tistory.com/custom/blog/19/191630/skin/images/mount icon.png" width="290" alt="산 아이콘" class="thumb" /><br />',
    			'	<h3 style="text-align: center;">' + allmountain[i].name + '</h3>',
    			'	<p style="text-align: center;">( ' + allmountain[i].height + ' )</p>',
    			'	<p>인증샷 이미지 삽입 예정<br />',
    			'	정상좌표 : ' + allmountain[i].Lat + ', ' +allmountain[i].Lng + '<br />',
    			'	산행년도 : ' + allmountain[i].day + '<br />',
    			'	<a href="http://gunzok.blog.me" target="_blank"><img src="http://cfs.tistory.com/custom/blog/19/191630/skin/images/gunzok mark.png" width="120" alt="마크" class="thumb" /></a>',
    			'	</p>',
    			'</div>'
    			].join('');
    			var infoWindow = new naver.maps.InfoWindow({
    				content: contentString,
    				maxWidth: 300,
    				backgroundColor: "#eee",
    				borderColor: "#000000",
    				borderWidth: 3,
    				anchorSize: new naver.maps.Size(8, 8),
    				anchorSkew: false,
    				anchorColor: "#eee",
    				pixelOffset: new naver.maps.Point(0, 0)
    			});
    			// 마커의 정보창 내용과 디자인 끝

    			markers.push(marker);			// markers 배열의 마지막에 마커의 요소를 추가
    			infoWindows.push(infoWindow);	// infoWindows 배열의 마지막에 정보창 요소를 추가
    	}
    	// 다중 마커의 정보창 설정(이어서)
    		// 정보창 호출과 닫기 기능 시작
    		// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환
    		function getClickHandler(seq) {
    			return function(e) {
    				var marker = markers[seq],
    					infoWindow = infoWindows[seq];

    				if(infoWindow.getMap()) {
    					infoWindow.close();
    				} else {
    					infoWindow.open(map, marker);
    				}
    			}
    		}
    		for(var i = 0, ii = markers.length; i < ii; i++) {
    			naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
    		}
    		// 정보창 호출과 닫기 기능 끝
    	// 다중 마커의 정보창 설정 끝
        

      });
		
      </script>
      
      
      
<!-- weather.java 예제 -->
<script type="text/javascript">

// AJAX 전송용 데이터
var json_data = { "address": "<%=address %>" };

	$.ajax({        
	    url: 'location.do',
	    type: 'get',
	    // 전송할 데이터
	    data:json_data,
	    dataType: 'xml',
	    success: function(msg){
	    	
	    	alert("AJAX 호출 성공");
	    	
	    	$(msg).find('item').each(function() {
	    		console.log($(this).find('category').text());
		        console.log($(this).find('fcstValue').text());
	    	});
	    	
	        var POP;	// 강수확률
	        var PTY;	// 강수형태
	        var REH;	// 습도
	        var SKY;	// 하늘상태
	        var TMN;	// 아침 최저기온
	        var TMX;	// 낮 최고기온
	        
	        $(msg).find('item').each(function() {
	        	if($(this).find('category').text() == 'POP') {
	        		POP = $(this).find('fcstValue').text();
	        	}
	        	if($(this).find('category').text() == 'PTY') {
	        		PTY = $(this).find('fcstValue').text();
	        	}
	        	if($(this).find('category').text() == 'REH') {
	        		REH = $(this).find('fcstValue').text();
	        	}
	        	if($(this).find('category').text() == 'SKY') {
	        		SKY = $(this).find('fcstValue').text();
	        	}
	        	if($(this).find('category').text() == 'TMN') {
	        		TMN = $(this).find('fcstValue').text();
	        	}
	        	if($(this).find('category').text() == 'TMX') {
	        		TMX = $(this).find('fcstValue').text();
	        	}
	        });
	        
	        var show = '';
	        
	        show += '<tr><td>강수확률 : ' + POP + '%<td><tr>';
	        show += '<tr><td>강수형태 : ' + PTY + ' / 0:없음, 1:비, 2:비/눈, 3:눈<td><tr>';
	        show += '<tr><td>습도 : ' + REH + '%<td><tr>';
	        show += '<tr><td>하늘상태 : ' + SKY + ' / 1:맑음, 2:구름조금, 3:구름많음, 4:흐림<td><tr>';
	        show += '<tr><td>아침 최저기온 : ' + TMN + '도<td><tr>';
	        show += '<tr><td>낮 최고기온 : ' + TMX + '도<td><tr>';
	        
	        $(".weather").append(show);
	    },
	    error: function(msg) {
	    	alert("AJAX 오류 : " + msg);
	    }
	});
	
</script>

<!-- <table class="weather2"></table> -->
<!-- weather.java 예제 끝 -->





<jsp:include page="footer.jsp"/>

</body>
</html>