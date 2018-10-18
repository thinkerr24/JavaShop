package com.rr.javashop.web.servlet;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Create on 2018/9/20 by rr
 * Extract servlets about user!
 * Using reflect
 */
@WebServlet("/baseServlet")
public class BaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		try {
		//1. ��������Method��������
		String methodName = request.getParameter("method");
		//2. ��õ�ǰ�����ʶ�����ֽ������
		Class clazz = getClass();
		//3. ��õ�ǰ�ֽ�������ָ������
		Method method = clazz.getMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
		//4.  ִ����Ӧ�ķ���
		method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
	}

}
