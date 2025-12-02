package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoUserVO {
    private Long kakaoId;
    private String email;
    private String nickname;

    public KakaoUserVO(Long kakaoId, String email, String nickname) {
        this.kakaoId = kakaoId;
        this.email = email;
        this.nickname = nickname;
    }

    public Long getKakaoId() {
        return kakaoId;
    }
    public String getEmail() {
        return email;
    }
    public String getNickname() {
        return nickname;
    }
}
