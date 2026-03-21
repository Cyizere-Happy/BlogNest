package org.example.blognest.util;

import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;

public class InputSanitizer {

    /**
     * Policy for plain text fields (no HTML allowed).
     * Used for titles, names, captions, etc.
     */
    private static final PolicyFactory PLAIN_POLICY = new org.owasp.html.HtmlPolicyBuilder().toFactory();

    /**
     * Policy for rich text fields (basic formatting allowed).
     * Used for blog content and comments.
     */
    private static final PolicyFactory RICH_POLICY = Sanitizers.FORMATTING
            .and(Sanitizers.LINKS)
            .and(Sanitizers.BLOCKS);

    /**
     * Sanitizes input to remove ALL HTML tags and returns raw text.
     */
    public static String sanitizePlain(String input) {
        if (input == null) return null;
        String sanitized = PLAIN_POLICY.sanitize(input);
        return org.apache.commons.text.StringEscapeUtils.unescapeHtml4(sanitized);
    }

    /**
     * Sanitizes input to allow basic formatting (bold, links, etc.) but removes dangerous tags.
     */
    public static String sanitizeRich(String input) {
        if (input == null) return null;
        return RICH_POLICY.sanitize(input);
    }
}
