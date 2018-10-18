package com.rr.javashop.service;

import java.sql.SQLException;

import com.rr.javashop.bean.User;
import com.rr.javashop.dao.UserDao;

public class UserService {
	private UserDao dao = new UserDao();
	public User login(String username, String password) {
		User user = null;
		try {
			user = dao.login(username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	public boolean checkUsername(String username) {
		boolean canLogin = false;
		try {
			canLogin = dao.checkUsername(username);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return canLogin;
	}
	public boolean regist(User user) {
		int row = 0;
		try {
			row = dao.regist(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return row > 0;
	}
	public void active(String activeCode) {
		try {
			dao.active(activeCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	
}
