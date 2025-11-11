package com.itwillbs.domain;

import java.time.LocalDate;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieVO {
	 private int tmdbId;
	 private String title;
	 private String posterPath;
	 private LocalDate releaseDate;
	 private String overview;
	 private Integer runtime; 
	 private Double popularity;
	 
	 // 영화가 가진 장르명 리스트
	 private List<String> genres;

	 private Double rating;             
	 private Integer positiveReviewCount; 
	 private Integer negativeReviewCount; 

}
