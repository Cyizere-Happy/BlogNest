package org.example.blognest.services;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

public class OAuthService {
    private static final String CLIENT_ID = ConfigService.get("GOOGLE_CLIENT_ID");
    private static final GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
            .setAudience(Collections.singletonList(CLIENT_ID))
            .build();

    public static GoogleIdToken.Payload verifyToken(String idTokenString) {
        try {
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                return idToken.getPayload();
            }
        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
