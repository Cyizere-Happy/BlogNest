package org.example.blognest.util;

import org.example.blognest.services.TOTPService;

public class VerifyTOTP {
    public static void main(String[] args) {
        String secret = TOTPService.generateSecret();
        System.out.println("Generated Secret: " + secret);
        
        // This is hard to test without a real-time clock and a TOTP generator
        // but we can check if it's a valid Base32 string
        try {
            byte[] decoded = Base32.decode(secret);
            System.out.println("Decoded length: " + decoded.length + " bytes");
            if (decoded.length == 20) {
                System.out.println("SUCCESS: Secret length is correct (20 bytes).");
            } else {
                System.out.println("FAILURE: Secret length is incorrect: " + decoded.length);
            }
        } catch (Exception e) {
            System.out.println("FAILURE: Decoding failed: " + e.getMessage());
        }
    }
}
