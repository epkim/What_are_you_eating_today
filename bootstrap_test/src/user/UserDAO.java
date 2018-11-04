package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			// String dbURL = "jdbc:mysql://localhost:3306/project";
			String dbURL = "jdbc:mysql://localhost/project";
			String dbID = "root";
			String dbPassword ="root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 占싸깍옙占쏙옙 占쏙옙占쏙옙
				}
				else
					return 0; // 占쏙옙橘占싫� 占쏙옙占쏙옙치
			}
			return -1; // 占쏙옙占싱듸옙 占쏙옙占쏙옙
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
}
