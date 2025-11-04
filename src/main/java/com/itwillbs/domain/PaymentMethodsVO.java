package com.itwillbs.domain;

import java.time.LocalDate;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentMethodsVO {
    private int id;
    private String userId;
    private String method;
    private String cardNumber;
    private String cardHolder;
    private LocalDate expiryDate;

}
