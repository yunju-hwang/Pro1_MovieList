package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReservationPaymentVO {
	private PaymentsVO payment;
	private ReservationsVO reservation;
}
