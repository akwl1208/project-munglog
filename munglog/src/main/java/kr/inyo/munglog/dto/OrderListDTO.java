package kr.inyo.munglog.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class OrderListDTO {
	ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
}
