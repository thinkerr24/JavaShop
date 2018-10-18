package com.rr.javashop.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;
import com.rr.javashop.bean.Cart;
import com.rr.javashop.bean.CartItem;
import com.rr.javashop.bean.Category;
import com.rr.javashop.bean.Order;
import com.rr.javashop.bean.OrderItem;
import com.rr.javashop.bean.PageBean;
import com.rr.javashop.bean.Product;
import com.rr.javashop.bean.User;
import com.rr.javashop.service.ProductService;
import com.rr.javashop.utils.CommonsUtils;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/product")
public class ProductServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private static ProductService service = new ProductService();
	
	// 首页头部Ajax请求获得商品分类
	public void categoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		List<Category> cateList = service.getCategoryList();
	
		String json = new Gson().toJson(cateList);
		response.getWriter().write(json);
	}
	
	// 访问首页时获取热门和最新商品列表
	public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Product> hotProducts = service.gethotProductList();
		List<Product> newProducts = service.getnewProductList();

		request.setAttribute("hotProducts", hotProducts);
		request.setAttribute("newProducts", newProducts);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	// 获得商品详情
	public void productInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pid = request.getParameter("pid");
		Product product = service.getProductByPid(pid);
		request.setAttribute("product", product);
		request.getRequestDispatcher("product_info.jsp").forward(request, response);
	}
	
	// 获得分页商品数据
	public void productsByCid(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		int currentPage = 0;
		int currentCount = 12;
		String currentPageStr = request.getParameter("currentPage");
		if (currentPageStr == null) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(currentPageStr);
		}
		PageBean pageBean = service.getProductsByCid(cid, currentPage, currentCount);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("cid", cid);
		request.getRequestDispatcher("product_list.jsp").forward(request, response);
	}
	
	// 添加商品到购物车
	public void addProductToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 将要放进购物车的商品pid以及数量
		int buyNum = 0;
	    buyNum = Integer.parseInt(request.getParameter("buyNum"));
		String pid = request.getParameter("pid");
		
		// 获得product对象
		Product product = service.getProductByPid(pid);
	
		// 计算小计 
		double subtotal = 0;
		if (product != null) {
			 subtotal = product.getPrice() * buyNum;
		} 
		
		// 封装CartItem
		CartItem item = new CartItem();
		item.setBuyNum(buyNum);
		item.setProduct(product);
		item.setSubtotal(subtotal);
		
		// 获得购物车并判断是否在session中已存在购物车
		Cart cart = (Cart)session.getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
		}
		
		// 将购物项放进车(Map)中, 其中key为pid
		// 先判断购物车中是否已经包含此商品----通过判断key是否存在
		// 如果存在，将数量相加
		Map<String, CartItem> cartItems = cart.getCartItems();
		double newSubTotal = buyNum * product.getPrice();
		
		if (cartItems.containsKey(pid)) {
			// 取出原有商品数量
			CartItem cartItem = cartItems.get(pid);
			int oldBuyNum = cartItem.getBuyNum();
			oldBuyNum += buyNum;
			cartItem.setBuyNum(oldBuyNum);
			cart.setCartItems(cartItems);
			
			// 修改小计
			double oldSubTotal = cartItem.getSubtotal();
			oldSubTotal += subtotal;
			cartItem.setSubtotal(oldSubTotal);
			
		
		} else {
			// 如果没有该商品
			cart.getCartItems().put(product.getPid(), item);
			
		}
		// 计算总计
		cart.setTotal(cart.getTotal() + newSubTotal);
		// 将车再次放入session中
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}
	
	// 删除购物项
	public void delProFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart != null) {
			Map<String, CartItem> cartItems = cart.getCartItems();
			cart.setTotal(cart.getTotal() - cartItems.get(pid).getSubtotal());
			cartItems.remove(pid);
			cart.setCartItems(cartItems);
		}
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}
	
	// 清空购物车
	public void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("cart");
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}
	
	// 提交订单项
	public void submitOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			// 没有登录
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return ;
		}
		// 封装order对象并将其传递到service层
		Order order = new Order();
		
		String oid = CommonsUtils.getUUID();
		order.setOid(oid);
		order.setOrdertime(new Date());
		
		// 从session中获得购物车
		Cart cart = (Cart) session.getAttribute("cart");
		
		double total = cart.getTotal();
		order.setTotal(total);
		order.setState(0);
		order.setUser(user);
		
		// 订单中有多少订单项? 获得购物车中的购物项map
		Map<String, CartItem> cartItems = cart.getCartItems();
		for (Map.Entry<String, CartItem> entry : cartItems.entrySet()) {
			CartItem cartItem = entry.getValue();
			OrderItem item = new OrderItem();
			item.setItemid(CommonsUtils.getUUID());
			item.setNum(cartItem.getBuyNum());
			item.setOrder(order);
			item.setSubtotal(cartItem.getSubtotal());
			item.setProduct(cartItem.getProduct());
			
			// 将该订单添加到订单的订单项集合中
			order.getOrderItems().add(item);
		}
		
		// Order对象封装完毕，将其传递到service层
		service.submitOrder(order);
		session.setAttribute("order", order);
		// 页面跳转
		response.sendRedirect(request.getContextPath() + "/order_info.jsp");
	}
	
	// 更新最后的订单(收货人, 收货地址, 收货电话)
	public void confirmOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String[]> parameterMap = request.getParameterMap();
		// 更新收货人信息, 封装order对象
		Order order = new Order();
		try {
			BeanUtils.populate(order, parameterMap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		service.updateOrderAttr(order);
		response.sendRedirect(request.getContextPath() + "/product?method=myOrders");
	}
	
	// 查看我的订单
	public void myOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return ;
		}
		// 得到当前
		List<Order> orders = service.getAllOrders(user.getUid());
		// 循环所有的订单 为每一个订单填充订单项集合信息
		if (orders != null) {
			for (Order order : orders) {
				// 获得每一个订单的oid
				String oid = order.getOid();
				// 根据查询该订单的所有订单项
				List<Map<String, Object>> mapList = service.getAllOrderItemsByOid(oid);
				for (Map<String, Object> map : mapList) {
					try {
					// 从map中取出数据，封装到orderItem中
					OrderItem item = new OrderItem();
					BeanUtils.populate(item, map);
					// 字段不统一(购买数量表中叫count, 类中定义为num)，只能手动设置
					item.setNum((int)map.get("count"));
					// 从map中取出数据，封装到product中
					Product product = new Product();
					BeanUtils.populate(product, map);
					
					item.setProduct(product);
					order.getOrderItems().add(item);
					} catch (IllegalAccessException | InvocationTargetException e) {
						e.printStackTrace();
					}
				}
			}
		}
		// OrderList封装完整
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("/order_list.jsp").forward(request, response);

	}
}
