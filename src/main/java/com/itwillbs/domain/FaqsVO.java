package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqsVO {
    private int id;
    private String question;
    private String answer;
    private LocalDateTime createdAt;
}
