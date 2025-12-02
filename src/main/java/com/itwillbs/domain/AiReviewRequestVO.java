package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

//AI 리뷰 요청 VO (리스트)
public class AiReviewRequestVO {
	private String userId; // 프론트에서 session으로 받은 userId
    // getter, setter
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

}
