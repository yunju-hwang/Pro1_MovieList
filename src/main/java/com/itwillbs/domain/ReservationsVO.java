package com.itwillbs.domain;

import java.time.LocalDateTime;


import com.fasterxml.jackson.annotation.JsonFormat;

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
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
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
