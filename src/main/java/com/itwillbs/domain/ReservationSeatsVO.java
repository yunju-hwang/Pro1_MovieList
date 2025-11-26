package com.itwillbs.domain;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class ReservationSeatsVO {
	private int id;
	private int reservationId;
	private String seatCode;
}
