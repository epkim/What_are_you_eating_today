package com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Servlet implementation class location
 */
@WebServlet("/location.do")
public class location extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public location() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		// map.jsp에서 전달받은 주소
		String address = request.getParameter("address");
		System.out.println(address);
		
		// 주소를 받아서 지역 및 위경도로 분할하는 API
		String sido = "";
		String sigugun = "";
		String[] sigugunArray = new String[] {};
		
		String clientId = "gkj3RmtL051U7oUW9uA7";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "dWPH3VhJD9";//애플리케이션 클라이언트 시크릿값";
        try {
            String addr = URLEncoder.encode(address, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/map/geocode?encoding=UTF-8&query=" + addr; //json
            //String apiURL = "https://openapi.naver.com/v1/map/geocode.xml?query=" + addr; // xml
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response2 = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response2.append(inputLine);
            }
            //br.close();
            System.out.println(response2.toString());
            
            System.out.println(br);
            System.out.println(inputLine);
            System.out.println(response2);
            inputLine = response2.toString();
            System.out.println(inputLine);
            // 주소를 받아서 지역 및 위경도로 분할하는 API 끝
            
            // json 데이터를 jsonObject로 만듬
            try {
            	JSONParser jsonParser = new JSONParser();
            	
            	// json 데이터를 넣어 jsonObject로 만들어 준다.
            	JSONObject jsonObject = (JSONObject) jsonParser.parse(inputLine);
            	
            	// items 배열 안에 있는 것도 JSON 형식이기 때문에 JSON Object로 추출
            	JSONObject itemsObject = new JSONObject();
            	JSONObject result = new JSONObject();
            	JSONObject addrdetail = new JSONObject();
            	
            	result = (JSONObject)jsonObject.get("result");
            	// items 배열을 추출
            	JSONArray itemsArray = (JSONArray) result.get("items");
            	System.out.println(itemsArray);
            	for(int i = 0; i < itemsArray.size(); i++) {
            		// items 배열 안에 있는 것도 JSON 형식이기 때문에 JSON Object로 추출
            		itemsObject = (JSONObject) itemsArray.get(i);
            		
            		addrdetail = (JSONObject) itemsObject.get("addrdetail");
            		sido = (String) addrdetail.get("sido");
            		sigugun = (String) addrdetail.get("sigugun");
            	}
            } catch (Exception e) {
            	e.printStackTrace();
			}
            System.out.println(sido);
            System.out.println(sigugun);
            
            sigugunArray = sigugun.split(" ");
            if(sido.equals("경기도")) {
            	sigugunArray[sigugunArray.length-1] = sigugunArray[0]+sigugunArray[1];
            }
            System.out.println(sigugunArray.length);
            System.out.println(sigugunArray[0]);
            System.out.println(sigugunArray[sigugunArray.length-1]);
            // json 데이터를 jsonObject로 만듬 끝
        } catch (Exception e) {
            System.out.println(e);
        }
        // 주소를 받아서 지역 및 위경도로 분할하는 API 끝
        
        // 주소(구)를 받아서 격자 X,Y로 변환하는 API
        int Nx = 0, Ny = 0;
        
        try {
        	Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/project";
            String id = "root";
            String pass = "root";
        	
        	Connection conn = DriverManager.getConnection(url, id, pass);
        	PreparedStatement pstmt = conn.prepareStatement("SELECT Nx, Ny FROM location WHERE sigugun = ?;");
        	pstmt.setString(1, sigugunArray[sigugunArray.length-1]);
        	ResultSet rs = pstmt.executeQuery();
        	
        	while(rs.next()) {
        		Nx = rs.getInt(1);
        		Ny = rs.getInt(2);
        	}
        	System.out.println(sigugunArray[sigugunArray.length-1] + "의 격자 X,Y는 " + Nx + " " + Ny + "입니다.");
        } catch(SQLException e) {
        	e.printStackTrace();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // 주소(구)를 받아서 격자 X,Y로 변환하는 API 끝
        
        // weather.java
        // 격자 X,Y를 이용하여 공공API에서 데이터를 파싱해 json형식으로 뿌려줌
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String today = sdf.format(date);
        System.out.println(today);
         
        String addr = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?ServiceKey=";
        String serviceKey = "fGlyTeBdElC%2B2b2e4M89h%2Bo4DSk4DVhodzDTwaJMYiAACAHNIM6h%2BLSvcQ15V4n%2FdDXGI7EbDNywehz2kkLK%2Fg%3D%3D";
        String parameter = "";
//        serviceKey = URLEncoder.encode(serviceKey,"utf-8");
        PrintWriter out = response.getWriter();
        parameter = parameter + "&" + "base_date=" + today;
        parameter = parameter + "&" + "base_time=0200";
        parameter = parameter + "&" + "nx=" + Nx;
        parameter = parameter + "&" + "ny=" + Ny;
         
         
        addr = addr + serviceKey + parameter;
        System.out.println(addr);
        URL url = new URL(addr);
         
        InputStream in = url.openStream(); 
        CachedOutputStream bos = new CachedOutputStream();
        IOUtils.copy(in, bos);
        in.close();
        bos.close();
         
//      out.println(addr);
         
        String data = bos.getOut().toString();      
        out.println(data);
         
        JSONObject json = new JSONObject();
        json.put("data", data);
        // weather.java 끝
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
