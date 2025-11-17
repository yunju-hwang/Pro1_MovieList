package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationsVO {
    private int id;
    private String userId;
    private int tmdbId;
    private int theaterId;
    private LocalDateTime screeningTime;
    private LocalDateTime reservationDate;
    private String seat;
//    private int people; 삭제
    
    
    private String movieTitle;
    private int finalAmount;
    private String paymentDate;
    private String theaterName;
    private String status;
    
    private int adultPeople;
    private int childPeople;
}
