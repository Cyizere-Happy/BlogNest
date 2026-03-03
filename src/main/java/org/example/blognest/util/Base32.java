package org.example.blognest.util;

public class Base32 {
    private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
    private static final int[] LOOKUP = new int[128];

    static {
        for (int i = 0; i < ALPHABET.length(); i++) {
            LOOKUP[ALPHABET.charAt(i)] = i;
        }
    }

    public static String encode(byte[] data) {
        StringBuilder result = new StringBuilder((data.length * 8 + 4) / 5);
        int buffer = 0;
        int bitsLeft = 0;
        for (byte b : data) {
            buffer = (buffer << 8) | (b & 0xFF);
            bitsLeft += 8;
            while (bitsLeft >= 5) {
                result.append(ALPHABET.charAt((buffer >> (bitsLeft - 5)) & 0x1F));
                bitsLeft -= 5;
            }
        }
        if (bitsLeft > 0) {
            result.append(ALPHABET.charAt((buffer << (5 - bitsLeft)) & 0x1F));
        }
        return result.toString();
    }

    public static byte[] decode(String data) {
        data = data.toUpperCase().replaceAll("[^A-Z2-7]", "");
        byte[] result = new byte[data.length() * 5 / 8];
        int buffer = 0;
        int bitsLeft = 0;
        int index = 0;
        for (int i = 0; i < data.length(); i++) {
            buffer = (buffer << 5) | LOOKUP[data.charAt(i)];
            bitsLeft += 5;
            if (bitsLeft >= 8) {
                result[index++] = (byte) ((buffer >> (bitsLeft - 8)) & 0xFF);
                bitsLeft -= 8;
            }
        }
        return result;
    }
}
