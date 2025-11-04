package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TheatersVO {
    private int theaterId;
    private String name;
    private String location;
    private LocalDateTime createdAt;
}
