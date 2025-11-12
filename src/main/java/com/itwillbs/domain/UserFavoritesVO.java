package com.itwillbs.domain;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserFavoritesVO {
	private int id;
    private String userId;
    private int tmdbId;
    
    private String movie_title;   
    private String poster_path;
    private String release_date;
    private String overview;      
    private int runtime;          
    private double popularity;    
}
