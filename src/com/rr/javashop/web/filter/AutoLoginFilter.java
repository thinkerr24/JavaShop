package com.rr.javashop.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.rr.javashop.bean.User;
import com.rr.javashop.service.UserService;

/**
 * Servlet Filter implementation class AutoLoginFilter
 */
@WebFilter("/*")
public class AutoLoginFilter implements Filter {


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	
		HttpServletRequest req = (HttpServletRequest) request;
		User currentUser = (User) req.getSession().getAttribute("currentUser");
		
		if(currentUser==null){
			String cookie_username = null;
			String cookie_password = null;
			//��ȡЯ���û���������cookie
			Cookie[] cookies = req.getCookies();
			if(cookies!=null){
				for(Cookie cookie:cookies){
					//�����Ҫ��cookie
					if("cookie_username".equals(cookie.getName())){
						cookie_username = cookie.getValue();
					}
					if("cookie_password".equals(cookie.getName())){
						cookie_password = cookie.getValue();
					}
				}
			}
		
			if(cookie_username!=null&&cookie_password!=null){
				//ȥ���ݿ�У����û����������Ƿ���ȷ
				UserService service = new UserService();
				currentUser = service.login(cookie_username,cookie_password);
				
				//����Զ���¼ 
				req.getSession().setAttribute("currentUser", currentUser);
				
			}
		}
	
		chain.doFilter(request, response);
	}

    public AutoLoginFilter() {
      
    }


	public void destroy() {
		
	}

	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
