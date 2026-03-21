package org.example.blognest.services;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.example.blognest.util.Base32;
import java.nio.ByteBuffer;
import java.security.GeneralSecurityException;
import java.security.SecureRandom;

/**
 * Basic TOTP (Time-based One-Time Password) implementation.
 */
public class TOTPService {
    private static final int DEFAULT_INTERVAL = 30;

    public static String generateSecret() {
        byte[] buffer = new byte[10]; // 80 bits is enough for most apps
        new SecureRandom().nextBytes(buffer);
        return Base32.encode(buffer);
    }

    public static boolean verifyCode(String secret, String codeStr) {
        return verifyCode(secret, codeStr, DEFAULT_INTERVAL); // Default 30s window
    }

    public static boolean verifyCode(String secret, String codeStr, int windowSeconds) {
        if (secret == null || codeStr == null || codeStr.length() != 6) return false;
        try {
            int code = Integer.parseInt(codeStr);
            long currentInterval = System.currentTimeMillis() / 1000 / DEFAULT_INTERVAL;
            
            // Calculate how many steps to check based on windowSeconds
            int steps = windowSeconds / DEFAULT_INTERVAL;
            
            // Check range of intervals for clock drift and delay
            for (int i = -steps; i <= steps; i++) {
                if (generateTOTP(secret, currentInterval + i) == code) {
                    return true;
                }
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    private static int generateTOTP(String base32Secret, long interval) throws GeneralSecurityException {
        byte[] key = Base32.decode(base32Secret);
        byte[] data = ByteBuffer.allocate(8).putLong(interval).array();

        SecretKeySpec signKey = new SecretKeySpec(key, "HmacSHA1");
        Mac mac = Mac.getInstance("HmacSHA1");
        mac.init(signKey);
        byte[] hash = mac.doFinal(data);

        int offset = hash[hash.length - 1] & 0xf;
        int binary = ((hash[offset] & 0x7f) << 24) |
                ((hash[offset + 1] & 0xff) << 16) |
                ((hash[offset + 2] & 0xff) << 8) |
                (hash[offset + 3] & 0xff);

        return binary % 1000000;
    }

    public static String generateCode(String secret) {
        return generateCode(secret, DEFAULT_INTERVAL);
    }

    public static String generateCode(String secret, int ignoredWindowSeconds) {
        try {
            long currentInterval = System.currentTimeMillis() / 1000 / DEFAULT_INTERVAL;
            int code = generateTOTP(secret, currentInterval);
            return String.format("%06d", code);
        } catch (Exception e) {
            return null;
        }
    }
    
    public static String getQRBarcodeURL(String user, String host, String secret) {
        // Simple URI format for manual entry if user can't scan
        // otpauth://totp/BlogNest:user@email.com?secret=xyz&issuer=BlogNest
        return String.format("otpauth://totp/%s:%s?secret=%s&issuer=%s", host, user, secret, host);
    }
}
