package com.rr.javashop.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.rr.javashop.bean.Category;
import com.rr.javashop.bean.Order;
import com.rr.javashop.bean.OrderItem;
import com.rr.javashop.bean.Product;
import com.rr.javashop.utils.DataSourceUtils;

public class ProductDao {
	private static QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
	public List<Category> getCategoryList() throws SQLException {
		String sql = "select * from category";
		return qr.query(sql, new BeanListHandler<Category>(Category.class));
	}
	public List<Product> gethotProductList() throws SQLException {
	    String sql = "select * from product where is_hot = ? limit ?, ?";
	    return qr.query(sql, new BeanListHandler<Product>(Product.class), 1, 0, 12);
	}
	public List<Product> getnewProductList() throws SQLException {
		String sql = "select * from product order by pdate desc limit 0, 12";
		return qr.query(sql, new BeanListHandler<Product>(Product.class));
	}
	public Product getProductByPid(String pid) throws SQLException {
		String sql = "select * from product where pid = ?";
		return qr.query(sql, new BeanHandler<Product>(Product.class), pid);
	}

	public int getTotalCount(String cid) throws SQLException {
		String sql = "select count(*) from product where cid = ?";
		Long num = (Long) qr.query(sql, new ScalarHandler(), cid);
		return num.intValue();
	}
	public List<Product> getProductsByPageNum(String cid, int index, int currentCount) throws SQLException {
		String sql = "select * from product where cid = ? limit ?, ?";
		return qr.query(sql, new BeanListHandler<Product>(Product.class), cid, index, currentCount);
	}
	public void addOrder(Order order) throws SQLException {
		String sql = "insert into orders values(?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = DataSourceUtils.getConnection();
		qr.update(conn, sql, order.getOid(), order.getOrdertime(), order.getTotal(), order.getState(),
				order.getAddress(), order.getName(), order.getTelephone(), order.getUser().getUid());
		
	}
	public void addOrderItem(Order order) throws SQLException {
		String sql = "insert into orderitem values(?, ?, ?, ?, ?)";
		Connection conn = DataSourceUtils.getConnection();
		List<OrderItem> orderItems = order.getOrderItems();
		for (OrderItem item : orderItems) {
			qr.update(conn, sql, item.getItemid(), item.getNum(), item.getSubtotal(), 
					item.getProduct().getPid(), item.getOrder().getOid());
		}
		
	}
	public void updateOrderAttr(Order order) throws SQLException {
		String sql = "update orders set address = ?, name = ?, telephone = ?, state = ? where oid = ?";
		qr.update(sql, order.getAddress(), order.getName(), order.getTelephone(), order.getState(), order.getOid());	
	}
	public List<Order> getAllOrders(String uid) throws SQLException {
		String sql = "select * from orders where uid = ?";
		return qr.query(sql, new BeanListHandler<Order>(Order.class), uid);
	}
	public List<Map<String, Object>> getAllOrderItemsByOid(String oid) throws SQLException {
		String sql = "select i.count, i.subtotal, p.pimage, p.pname, p.price from orderitem i join product p on i.pid = "
			+ "p.pid where oid = ?";
		return qr.query(sql, new MapListHandler(), oid);
	}
	

}
