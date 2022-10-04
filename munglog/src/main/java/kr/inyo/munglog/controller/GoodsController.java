package kr.inyo.munglog.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.GoodsService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.GoodsVO;

@Controller
public class GoodsController {
	
	@Autowired
	GoodsService goodsService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ***************************************************************/
	/* 굿즈 ---------------------------------------------------------------*/
	@RequestMapping(value = "/goods", method = RequestMethod.GET)
	public ModelAndView goodsGet(ModelAndView mv) {
		mv.setViewName("/goods/goodsList");
		return mv;
	}
	
/* ajax **************************************************************************************************************** */
	/* 굿즈 리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/goodsList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getGoodsList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		//굿즈 리스트 가져오기
		ArrayList<GoodsVO> goodsList = goodsService.getGoodsList(cri);
		int totalCount = goodsService.getGoodsTotalCount(cri);
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		
		map.put("pm",pm);
		map.put("goodsList", goodsList);
		return map;
	}
}
