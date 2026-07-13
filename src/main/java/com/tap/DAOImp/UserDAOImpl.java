package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOImpl implements UserDAO {
	private static final String insert_query="insert into users(userName,password,email,address,role,createdDate,lastLoginDate) values (?,?,?,?,?,?,?)";
	private static final String update_query="update users set userName=?,password=?,email=?,address=?,lastLoginDate=? where userId=?";
	private static final String select_query="select * from users where userId=?";
	private static final String delete_query="delete from users where userId=?";
	private static final String all_query="Select * from users";
	private static final String get_user="select * from users where email=?";
	
	@Override
	public int addUser(User user) {
		
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(insert_query);
			pstmt.setString(1,user.getUserName());
			pstmt.setString(2,user.getPassword());
			pstmt.setString(3,user.getEmail());
			pstmt.setString(4,user.getAddress());
			pstmt.setString(5,user.getRole());
			pstmt.setTimestamp(6,new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(7,new Timestamp(System.currentTimeMillis()));
			int i=pstmt.executeUpdate();
			return i;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public User getUser(int userId) {
		Connection con=DBConnection.getConnection();
		User u=null;
		try {
			PreparedStatement pstmt=con.prepareStatement(select_query);
			pstmt.setInt(1, userId);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int userID1=result.getInt("userID");
				String userName=result.getString("userName");
				String password=result.getString("password");
				String email=result.getString("email");
				String address=result.getString("address");
				String role=result.getString("role");
				Timestamp createdDate=result.getTimestamp("createdDate");
				Timestamp lastLoginDate=result.getTimestamp("lastLoginDate");
				 u=new User(userID1, userName, password, email, address, role, createdDate, lastLoginDate);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return u;
	}

	@Override
	public void updateUser(User user) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(update_query);
			pstmt.setString(1,user.getUserName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3,user.getEmail());
			pstmt.setString(4,user.getAddress());
			pstmt.setTimestamp(5,new Timestamp(System.currentTimeMillis()));
			pstmt.setInt(6, user.getUserID());
			int i=pstmt.executeUpdate();
			System.out.print(i);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteUser(int userId) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(delete_query);
			pstmt.setInt(1, userId);
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUsers() {
		List<User> list=new ArrayList<User>();
		User u=null;
		Connection con=DBConnection.getConnection();
		try {
			Statement stmt=con.createStatement();
			ResultSet result=stmt.executeQuery(all_query);
			while(result.next()) {
				int userId=result.getInt("userId");
				String userName=result.getString("userName");
				String password=result.getString("password");
				String email=result.getString("email");
				String address=result.getString("address");
				String role=result.getString("role");
				Timestamp createdDate=result.getTimestamp("createdDate");
				Timestamp lastLoginDate=result.getTimestamp("lastLoginDate");
				 u=new User(userId, userName, password, email, address, role, createdDate, lastLoginDate);
				 list.add(u);
			}

		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public User getUserByEmail(String email) {
		Connection con=DBConnection.getConnection();
		User u=null;
		try {
			PreparedStatement pstmt=con.prepareStatement(get_user);
			pstmt.setString(1, email);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int userID1=result.getInt("userID");
				String userName=result.getString("userName");
				String password=result.getString("password");
				String email1=result.getString("email");
				String address=result.getString("address");
				String role=result.getString("role");
				Timestamp createdDate=result.getTimestamp("createdDate");
				Timestamp lastLoginDate=result.getTimestamp("lastLoginDate");
				 u=new User(userID1, userName, password, email1, address, role, createdDate, lastLoginDate);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return u;
	}

}
