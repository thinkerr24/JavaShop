package com.rr.javashop.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.rr.javashop.bean.Category;
import com.rr.javashop.bean.Order;
import com.rr.javashop.bean.PageBean;
import com.rr.javashop.bean.Product;
import com.rr.javashop.bean.User;
import com.rr.javashop.dao.ProductDao;
import com.rr.javashop.utils.DataSourceUtils;

public class ProductService {
	private static ProductDao dao = new ProductDao();
	public List<Category> getCategoryList(){
		List<Category> list = null;
		try {
			list =  dao.getCategoryList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	public List<Product> gethotProductList() {
		List<Product> list = null;
		try {
			list =  dao.gethotProductList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Product> getnewProductList() {
		List<Product> list = null;
		try {
			list = dao.getnewProductList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Product getProductByPid(String pid) {
		
		Product product = null;
		try {
			product = dao.getProductByPid(pid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return product;
	}
	
	public PageBean getProductsByCid(String cid, int currentPage, int currentCount) {
		PageBean<Product> pageBean = new PageBean<>();
		pageBean.setCurrentPage(currentPage);
		pageBean.setCurrentPage(currentPage);
		
		int totalCount = 0;
		try {
			totalCount = dao.getTotalCount(cid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageBean.setTotalCount(totalCount);
		pageBean.setTotalPage((int)Math.ceil(1.0 * totalCount / currentCount));
		List<Product> products = null;
		try {
			products = dao.getProductsByPageNum(cid, (currentPage - 1) * currentCount, currentCount);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageBean.setList(products);
		return pageBean;
	}

	// 提交订单 将订单和订单项的数据提交到数据库中
	public void submitOrder(Order order) {
		
		try {
			// 1.开启事务
			DataSourceUtils.startTransaction();
			
			// 2.order入dao层
			dao.addOrder(order);
			
			// 3.orderitem入dao层
			dao.addOrderItem(order);
			
		} catch (SQLException e) {
			try {
				DataSourceUtils.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				DataSourceUtils.commitAndRelease();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void updateOrderAttr(Order order) {
		try {
			dao.updateOrderAttr(order);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	public List<Order> getAllOrders(String uid) {
		List<Order> orders = null;
		try {
			orders = dao.getAllOrders(uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}

	public List<Map<String, Object>> getAllOrderItemsByOid(String oid) {
		List<Map<String, Object>> mapList = null;
		try {
			mapList = dao.getAllOrderItemsByOid(oid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mapList;
	}




}
