package com.itwillbs.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentsVO {
    private int id;
    private int reservationId;
    private String userId;
    private int paymentMethodId;
    private BigDecimal amount;
    private String method;
    private String status;
    private LocalDateTime paymentDate;
    
    
    
    
}
