package com.itwillbs.domain;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoUserVO {

    private Long id; // 카카오 고유 ID

    @SerializedName("kakao_account")
    private KakaoAccount kakaoAccount;

    @Getter
    @Setter
    @ToString
    public static class KakaoAccount {
        private Profile profile;
        private String email;
    }

    @Getter
    @Setter
    @ToString
    public static class Profile {
        private String nickname;
        @SerializedName("profile_image_url")
        private String profileImageUrl;
    }

    // 편하게 꺼내는 메서드
    public Long getKakaoId() {
        return id;
    }

    public String getNickname() {
        if (kakaoAccount != null && kakaoAccount.getProfile() != null) {
            return kakaoAccount.getProfile().getNickname();
        }
        return null;
    }

    public String getEmail() {
        if (kakaoAccount != null) {
            return kakaoAccount.getEmail();
        }
        return null;
    }

    public String getProfileImageUrl() {
        if (kakaoAccount != null && kakaoAccount.getProfile() != null) {
            return kakaoAccount.getProfile().getProfileImageUrl();
        }
        return null;
    }
}
