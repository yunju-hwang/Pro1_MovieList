package com.itwillbs.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
	 private LocalDateTime createdAt;
	
}
