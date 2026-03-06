package org.example.blognest.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import jakarta.websocket.EndpointConfig;
import org.example.blognest.websocket.model.ChatMessage;
import org.example.blognest.model.ChatHistory;
import org.example.blognest.services.ChatHistoryService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.servlet.http.HttpSession;
import org.example.blognest.model.User;

@ServerEndpoint(value = "/chat/{username}", configurator = HttpSessionConfigurator.class)
public class ChatServer {
    private static final Map<String, Session> sessions = new ConcurrentHashMap<>();
    private static final ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config, @PathParam("username") String username) {
        try {
            String decodedUsername = java.net.URLDecoder.decode(username, "UTF-8");

            HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
            User loggedInUser = (httpSession != null) ? (User) httpSession.getAttribute("user") : null;

            boolean isAuthorized = false;
            if (loggedInUser != null) {
                if ("Admin".equalsIgnoreCase(decodedUsername)) {
                    isAuthorized = "ADMIN".equalsIgnoreCase(loggedInUser.getRole());
                } else {
                    isAuthorized = decodedUsername.equals(loggedInUser.getName());
                }
            }

            if (!isAuthorized) {
                System.err.println("Unauthorized WebSocket connection attempt: " + decodedUsername + " (Logged in as: " + (loggedInUser != null ? loggedInUser.getName() : "None") + ")");
                session.close(new CloseReason(CloseReason.CloseCodes.CANNOT_ACCEPT, "Authentication required or invalid identity."));
                return;
            }

            sessions.put(decodedUsername, session);
            System.out.println("WebSocket secured and opened: " + decodedUsername + " (Session: " + session.getId() + ")");
            broadcastSystemMessage(decodedUsername, ChatMessage.MessageType.JOIN);

            if (!"Admin".equals(decodedUsername)) {
                sendHistory(decodedUsername, "Admin", session);
            }
        } catch (Exception e) {
            System.err.println("Error in onOpen for " + username + ": " + e.getMessage());
            e.printStackTrace();
            try {
                session.close(new CloseReason(CloseReason.CloseCodes.UNEXPECTED_CONDITION, e.getMessage()));
            } catch (IOException ie) {
                ie.printStackTrace();
            }
        }
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("username") String username) throws IOException {
        String decodedSender = java.net.URLDecoder.decode(username, "UTF-8");
        ChatMessage chatMessage = objectMapper.readValue(message, ChatMessage.class);
        chatMessage.setSender(decodedSender);
        chatMessage.setTimestamp(LocalDateTime.now());

        // Handle History Requests (from Admin)
        if ("GET_HISTORY".equals(chatMessage.getContent())) {
            System.out.println("Admin requested history for user: " + chatMessage.getRecipient());
            sendHistory(chatMessage.getRecipient(), "Admin", session);
            return;
        }

        // Persist message
        if (chatMessage.getType() == ChatMessage.MessageType.CHAT) {
            String recipient = chatMessage.getRecipient();
            if (recipient == null || recipient.isEmpty()) {
                recipient = "Admin";
                chatMessage.setRecipient(recipient);
            }

            ChatHistory history = ChatHistory.builder()
                    .sender(chatMessage.getSender())
                    .recipient(recipient)
                    .content(chatMessage.getContent())
                    .timestamp(chatMessage.getTimestamp())
                    .build();
            ChatHistoryService.getInstance().saveMessage(history);
        }

        // Routing logic
        String target = chatMessage.getRecipient();
        System.out.println("Routing message from " + username + " to " + target + ". Sessions available: " + sessions.keySet());
        
        if (target != null && sessions.containsKey(target)) {
            // Send to intended recipient
            sessions.get(target).getBasicRemote().sendText(objectMapper.writeValueAsString(chatMessage));
            System.out.println("Message delivered to " + target);
        } else if (!"Admin".equals(username)) {
            // If sender is not Admin and recipient is missing/offline, try sending to Admin
            if (sessions.containsKey("Admin")) {
                sessions.get("Admin").getBasicRemote().sendText(objectMapper.writeValueAsString(chatMessage));
                System.out.println("Reader message routed to Admin (recipient " + target + " was offline)");
            }
        } else {
            System.err.println("Failed to route message: target " + target + " is offline or sessions map mismatch.");
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("username") String username) {
        try {
            String decodedUsername = java.net.URLDecoder.decode(username, "UTF-8");
            sessions.remove(decodedUsername);
            broadcastSystemMessage(decodedUsername, ChatMessage.MessageType.LEAVE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void broadcastMessage(ChatMessage message) throws IOException {
        String msgStr = objectMapper.writeValueAsString(message);
        for (Session session : sessions.values()) {
            if (session.isOpen()) {
                session.getBasicRemote().sendText(msgStr);
            }
        }
    }

    private void broadcastSystemMessage(String username, ChatMessage.MessageType type) {
        try {
            ChatMessage systemMsg = ChatMessage.builder()
                    .sender("System")
                    .content(username + (type == ChatMessage.MessageType.JOIN ? " joined the chat" : " left the chat"))
                    .timestamp(LocalDateTime.now())
                    .type(type)
                    .build();
            broadcastMessage(systemMsg);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sendHistory(String user1, String user2, Session session) {
        List<ChatHistory> historyList = ChatHistoryService.getInstance().getHistory(user1, user2);
        for (ChatHistory h : historyList) {
            try {
                ChatMessage msg = ChatMessage.builder()
                        .sender(h.getSender())
                        .recipient(h.getRecipient())
                        .content(h.getContent())
                        .timestamp(h.getTimestamp())
                        .type(ChatMessage.MessageType.CHAT)
                        .build();
                session.getBasicRemote().sendText(objectMapper.writeValueAsString(msg));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
