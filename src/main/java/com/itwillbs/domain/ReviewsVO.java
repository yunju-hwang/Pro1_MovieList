package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewsVO {
    private int id;
    private int tmdbId;
    private String userId;
    private String content;
    private String sentiment;
    private int rating;
    private LocalDateTime createdAt;
    
    
    
    private String movieTitle;
    
    
}
