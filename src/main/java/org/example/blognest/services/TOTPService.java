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

    public static String generateSecret() {
        byte[] buffer = new byte[20]; // 160 bits is recommended for modern HMAC-SHA1 TOTP
        new SecureRandom().nextBytes(buffer);
        // Use Base32 as required by most 2FA apps (Google Authenticator, etc.)
        return Base32.encode(buffer);
    }

    public static boolean verifyCode(String secret, String codeStr) {
        if (secret == null || codeStr == null || codeStr.length() != 6) return false;
        try {
            int code = Integer.parseInt(codeStr);
            long currentInterval = System.currentTimeMillis() / 1000 / 30; // 30-second window
            
            // Check current, previous, and next interval for clock drift
            for (int i = -1; i <= 1; i++) {
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
    
    public static String getQRBarcodeURL(String user, String host, String secret) {
        // Simple URI format for manual entry if user can't scan
        // otpauth://totp/BlogNest:user@email.com?secret=xyz&issuer=BlogNest
        return String.format("otpauth://totp/%s:%s?secret=%s&issuer=%s", host, user, secret, host);
    }
}
