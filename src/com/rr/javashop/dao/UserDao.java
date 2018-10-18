package com.rr.javashop.dao;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.rr.javashop.bean.User;
import com.rr.javashop.utils.DataSourceUtils;

public class UserDao {
	private QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
	// ÓÃ»§µÇÂ¼
	public User login(String username, String password) throws SQLException {
		
		String sql = "select * from user where username = ? and password = ?";
		User user = qr.query(sql, new BeanHandler<User>(User.class), username, password);
		return user;
	}
	public boolean checkUsername(String username) throws SQLException {
		String sql = "select count(*) from user where username = ?";
		Long num = (Long) qr.query(sql, new ScalarHandler(), username);
		return num > 0;
	}
	public int regist(User user) throws SQLException {
		String sql = "insert into user values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		return qr.update(sql, user.getUid(), user.getUsername(), user.getPassword(), user.getName(),
					user.getEmail(), user.getTelephone(), user.getBirthday(), user.getSex(),
					user.getState(), user.getCode());
		
	}
	public void active(String activeCode) throws SQLException {
		String sql = "update user set state = '1' where code = ?";
		qr.update(sql, activeCode);
		
	}
	
}
