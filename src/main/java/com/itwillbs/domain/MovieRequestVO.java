package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieRequestVO {
    private int id;
    private String userId;
    private int tmdbId;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime processedAt;
}
