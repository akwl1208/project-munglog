package kr.inyo.munglog.service;

import javax.servlet.http.HttpServletResponse;

public interface MessageService {
	
	void message(HttpServletResponse response, String content, String redirectUrl);
}
