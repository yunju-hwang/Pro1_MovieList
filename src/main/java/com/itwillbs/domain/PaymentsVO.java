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
    private int id; // 결제 pk 
    private int reservationId; // 예약테이블 fk
    private int paymentMethodId; // 결제 수단(1. 카카오, 2. 카드 등 )
    private BigDecimal amount; // 결제 금액 
    private String impUid; // import id값 (결제 건마다 발급하는 고유 id)
    private String merchantUid; // 상점 주문번호 (결제 요청 시 샡성하는 주문번호)
    private String status; // // pending, paid, cancelled 
    private LocalDateTime paymentDate;
    
    
    
    
}
