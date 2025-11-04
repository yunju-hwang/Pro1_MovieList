package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class NoticesVO {
    private int id;
    private String title;
    private String content;
    private LocalDateTime createdAt;
}
