package com.rr.javashop.bean;

public class OrderItem {
	private String itemid; //订单项的ID
	private int num; // 订单项内商品数量
	private double subtotal; // 订单项小计
	private Product product; // 订单商品
	private Order order; // 本订单项属于哪个订单
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
}
