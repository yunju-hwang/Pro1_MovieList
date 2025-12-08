package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NaverUserVO {


    private Response response;

    @Getter
    @Setter
    @ToString
    public static class Response {
    	private String id;
        private String email;
        private String nickname;
        private String profileImage;
        private String mobile;
        
    }

    // 편하게 꺼내는 메서드
    public String getNaverId() {
    	if (response != null) {
            return response.getId();
        }
        return null;
    }

    public String getNickname() {
        if (response != null) {
            return response.getNickname();
        }
        return null;
    }

    public String getEmail() {
        if (response != null) {
            return response.getEmail();
        }
        return null;
    }

    public String getProfileImage() {
        if (response != null) {
            return response.getProfileImage();
        }
        return null;
    }
    
    public String getMobile() {
        if (response != null) {
            return response.getMobile();
        }
        return null;
    }
    
    
}
