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
	 
	 // 영화 db 저장용 장르
	 private List<Integer> genreIds; // DB 저장용
	 
	 // 영화 찜 여부
	 private boolean isFavorite;

	 private Double rating;             
	 private String genres2;
}
