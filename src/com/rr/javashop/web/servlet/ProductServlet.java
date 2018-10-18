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
	
	// ��ҳͷ��Ajax��������Ʒ����
	public void categoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		List<Category> cateList = service.getCategoryList();
	
		String json = new Gson().toJson(cateList);
		response.getWriter().write(json);
	}
	
	// ������ҳʱ��ȡ���ź�������Ʒ�б�
	public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Product> hotProducts = service.gethotProductList();
		List<Product> newProducts = service.getnewProductList();

		request.setAttribute("hotProducts", hotProducts);
		request.setAttribute("newProducts", newProducts);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	// �����Ʒ����
	public void productInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pid = request.getParameter("pid");
		Product product = service.getProductByPid(pid);
		request.setAttribute("product", product);
		request.getRequestDispatcher("product_info.jsp").forward(request, response);
	}
	
	// ��÷�ҳ��Ʒ����
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
	
	// �����Ʒ�����ﳵ
	public void addProductToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// ��Ҫ�Ž����ﳵ����Ʒpid�Լ�����
		int buyNum = 0;
	    buyNum = Integer.parseInt(request.getParameter("buyNum"));
		String pid = request.getParameter("pid");
		
		// ���product����
		Product product = service.getProductByPid(pid);
	
		// ����С�� 
		double subtotal = 0;
		if (product != null) {
			 subtotal = product.getPrice() * buyNum;
		} 
		
		// ��װCartItem
		CartItem item = new CartItem();
		item.setBuyNum(buyNum);
		item.setProduct(product);
		item.setSubtotal(subtotal);
		
		// ��ù��ﳵ���ж��Ƿ���session���Ѵ��ڹ��ﳵ
		Cart cart = (Cart)session.getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
		}
		
		// ��������Ž���(Map)��, ����keyΪpid
		// ���жϹ��ﳵ���Ƿ��Ѿ���������Ʒ----ͨ���ж�key�Ƿ����
		// ������ڣ����������
		Map<String, CartItem> cartItems = cart.getCartItems();
		double newSubTotal = buyNum * product.getPrice();
		
		if (cartItems.containsKey(pid)) {
			// ȡ��ԭ����Ʒ����
			CartItem cartItem = cartItems.get(pid);
			int oldBuyNum = cartItem.getBuyNum();
			oldBuyNum += buyNum;
			cartItem.setBuyNum(oldBuyNum);
			cart.setCartItems(cartItems);
			
			// �޸�С��
			double oldSubTotal = cartItem.getSubtotal();
			oldSubTotal += subtotal;
			cartItem.setSubtotal(oldSubTotal);
			
		
		} else {
			// ���û�и���Ʒ
			cart.getCartItems().put(product.getPid(), item);
			
		}
		// �����ܼ�
		cart.setTotal(cart.getTotal() + newSubTotal);
		// �����ٴη���session��
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}
	
	// ɾ��������
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
	
	// ��չ��ﳵ
	public void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("cart");
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}
	
	// �ύ������
	public void submitOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			// û�е�¼
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return ;
		}
		// ��װorder���󲢽��䴫�ݵ�service��
		Order order = new Order();
		
		String oid = CommonsUtils.getUUID();
		order.setOid(oid);
		order.setOrdertime(new Date());
		
		// ��session�л�ù��ﳵ
		Cart cart = (Cart) session.getAttribute("cart");
		
		double total = cart.getTotal();
		order.setTotal(total);
		order.setState(0);
		order.setUser(user);
		
		// �������ж��ٶ�����? ��ù��ﳵ�еĹ�����map
		Map<String, CartItem> cartItems = cart.getCartItems();
		for (Map.Entry<String, CartItem> entry : cartItems.entrySet()) {
			CartItem cartItem = entry.getValue();
			OrderItem item = new OrderItem();
			item.setItemid(CommonsUtils.getUUID());
			item.setNum(cartItem.getBuyNum());
			item.setOrder(order);
			item.setSubtotal(cartItem.getSubtotal());
			item.setProduct(cartItem.getProduct());
			
			// ���ö�����ӵ������Ķ��������
			order.getOrderItems().add(item);
		}
		
		// Order�����װ��ϣ����䴫�ݵ�service��
		service.submitOrder(order);
		session.setAttribute("order", order);
		// ҳ����ת
		response.sendRedirect(request.getContextPath() + "/order_info.jsp");
	}
	
	// �������Ķ���(�ջ���, �ջ���ַ, �ջ��绰)
	public void confirmOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String[]> parameterMap = request.getParameterMap();
		// �����ջ�����Ϣ, ��װorder����
		Order order = new Order();
		try {
			BeanUtils.populate(order, parameterMap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		service.updateOrderAttr(order);
		response.sendRedirect(request.getContextPath() + "/product?method=myOrders");
	}
	
	// �鿴�ҵĶ���
	public void myOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return ;
		}
		// �õ���ǰ
		List<Order> orders = service.getAllOrders(user.getUid());
		// ѭ�����еĶ��� Ϊÿһ��������䶩�������Ϣ
		if (orders != null) {
			for (Order order : orders) {
				// ���ÿһ��������oid
				String oid = order.getOid();
				// ���ݲ�ѯ�ö��������ж�����
				List<Map<String, Object>> mapList = service.getAllOrderItemsByOid(oid);
				for (Map<String, Object> map : mapList) {
					try {
					// ��map��ȡ�����ݣ���װ��orderItem��
					OrderItem item = new OrderItem();
					BeanUtils.populate(item, map);
					// �ֶβ�ͳһ(�����������н�count, ���ж���Ϊnum)��ֻ���ֶ�����
					item.setNum((int)map.get("count"));
					// ��map��ȡ�����ݣ���װ��product��
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
		// OrderList��װ����
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("/order_list.jsp").forward(request, response);

	}
}
