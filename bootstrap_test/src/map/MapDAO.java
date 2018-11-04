package map;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class MapDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MapDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/project";
			String dbID = "root";
			String dbPassword ="root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("DB접속 성공");
		} catch(Exception e) {
			System.out.println("DB접속 실패");
			e.printStackTrace();
		}
	}
	
	public ArrayList<Map> mapList() {
		
		ArrayList<Map> list = new ArrayList<Map>();
		String SQL = "select * from restaurant";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map map = new Map();
				map.setName(rs.getString("Name"));
				map.setAddress(rs.getString("Address"));
				map.setPhone(rs.getString("Phone"));
				map.setWeather(rs.getString("Weather"));
				map.setFood(rs.getString("Food"));
				map.setLat(rs.getString("Lat"));
				map.setLng(rs.getString("Lng"));
				
				list.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("DB정보 오류");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {rs.close();}
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
			
			try {
				if(pstmt != null) {pstmt.close();}
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
			
			try {
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		
		return list;
	}

}
