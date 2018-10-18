package com.rr.javashop.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;

import com.rr.javashop.utils.CommonsUtils;
import com.rr.javashop.bean.User;
import com.rr.javashop.service.UserService;
import com.rr.javashop.utils.MailUtils;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/user")
public class UserServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserService();
	
	// ��¼
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User currentUser = service.login(username, password);
		if (currentUser == null) {
			
			request.setAttribute("loginFailMsg", "�û������������");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		} else if("0".equals(currentUser.getState())){
			request.setAttribute("loginFailMsg", "���û���δ����");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}else {

			String autoLogin = request.getParameter("autoLogin");
			if ("autoLogin".equals(autoLogin)) {
				Cookie cookie_username = new Cookie("cookie_username", currentUser.getUsername());
				cookie_username.setMaxAge(10 * 60);
				Cookie cookie_password = new Cookie("cookie_password", currentUser.getPassword());
				cookie_password.setMaxAge(10 * 60);
				
				response.addCookie(cookie_username);
				response.addCookie(cookie_password);
			}
			session.setAttribute("currentUser", currentUser);
			response.sendRedirect(request.getContextPath());
		}
		
	}
	
	// ע��
	public void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Map<String, String[]> properties = request.getParameterMap();
		User user = new User();
		try {
		ConvertUtils.register(new Converter() {
			
			@Override
			public Object convert(Class arg0, Object arg1) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date parse = null;
				try {
					parse = format.parse(arg1.toString());
				} catch (ParseException e) {
					e.printStackTrace();
				}
				return parse;
			}
		}, Date.class);
	
			BeanUtils.populate(user, properties);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
		// ��װʣ�µ��ֶ�
		user.setUid(CommonsUtils.getUUID());
		user.setTelephone(null);
		user.setState("0");
		String activeCode = CommonsUtils.getUUID();
		user.setCode(activeCode);
		
		UserService service = new UserService();
		boolean isRegisterSuccess = service.regist(user);
		
		  // �Ƿ�ע��ɹ�
		  if (isRegisterSuccess) {
			  
			  // ���ͼ����ʼ�
			  String emailMsg = "��ϲ��ע��ɹ����������ӽ����û�<a href='http://localhost:8080/JavaShop/user?method=active&activeCode="+ activeCode +"'>����</a>";
			 try {
				 MailUtils.sendMail(user.getEmail(), emailMsg);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			  // ע��ɹ� ��ת����¼ҳ��
			  response.sendRedirect(request.getContextPath() + "/registerSuccess.jsp");
		  } else {
			  // ��ת��ʧ�ܵ�ҳ��
			  request.setAttribute("regError", "ע��ʧ��");
			  request.getRequestDispatcher("register.jsp").forward(request, response);
		  }
	}
	// ������ע����û�
	public void active(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ��ü�����
		String activeCode = request.getParameter("activeCode");
		
		UserService service = new UserService();
		service.active(activeCode);
		
		// ��ת����¼ҳ��
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	
	// �ǳ�
	public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("currentUser");
		// ���洢�ڿͻ��˵�Cookieɾ����
		Cookie cookie_username = new Cookie("cookie_username", "");
		Cookie cookie_password = new Cookie("cookie_password", "");
		response.addCookie(cookie_username);
		response.addCookie(cookie_password);
		response.sendRedirect(request.getContextPath());
	}

	// ��֤�û����Ƿ���� 
	public void checkUsername(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		
		boolean isExist = service.checkUsername(username);
		String json = "{\"isExist\":" + isExist + "}";
		response.getWriter().write(json);
	}
}
