package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

//단일 리뷰 VO
public class UserReviewVO {
	private String tmdbId;
    private String content;

    // getter, setter
    public String getTmdbId() { return tmdbId; }
    public void setTmdbId(String tmdbId) { this.tmdbId = tmdbId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
}
