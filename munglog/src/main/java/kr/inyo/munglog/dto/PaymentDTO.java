package kr.inyo.munglog.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class PaymentDTO {
	//받아야할 변수
	private int mbNum;
	private int pointAmount;
	private int payAmount;
	private String imp_uid;
	private String orCode;
	private String email;
	private ArrayList<OrderDTO> orderList;
	private int adNum;
	private String recipient;
	private String phone;
	private String postcode;
	private String address;
	private String detail;
	private String request;
}
