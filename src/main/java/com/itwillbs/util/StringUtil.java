package com.itwillbs.util;

public class StringUtil {
    public static String truncateText(String text, int maxLength) {
        if (text == null) {
            return "";
        }
        if (text.length() > maxLength) {
            return text.substring(0, maxLength) + "...";
        }
        return text;
    }
}