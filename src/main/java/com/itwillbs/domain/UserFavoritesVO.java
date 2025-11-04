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
}
