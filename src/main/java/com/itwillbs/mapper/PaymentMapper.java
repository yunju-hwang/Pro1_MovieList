package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.PaymentsVO;
import com.itwillbs.domain.ReservationsVO;

@Mapper
public interface PaymentMapper {
	
	// 1) 결제 정보 insert
	void insertPayment(PaymentsVO payment);
	
	// 2) 예약 정보 insert
	void insertReservation(ReservationsVO reservation);
	
}
