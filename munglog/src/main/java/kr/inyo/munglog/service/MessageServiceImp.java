package kr.inyo.munglog.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public class MessageServiceImp implements MessageService {

	@Override
	public void message(HttpServletResponse response, String content, String redirectUrl) {
		if(response == null)
			return;
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		
		out.println("<script>alert('"+content+"'); location.href='"+redirectUrl+"'</script>");
		out.flush();
	}



}
