package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.MessageOfTheDay;
import org.example.blognest.services.QuoteService;
import java.io.IOException;
import java.util.List;

@WebServlet("/quotes")
public class QuotesController extends HttpServlet {
    private final QuoteService quoteService = QuoteService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MessageOfTheDay dailyMessage = quoteService.getDailyMessage();
        List<MessageOfTheDay> history = quoteService.getMessageHistory();
        
        String viewIndexStr = req.getParameter("viewIndex");
        if (viewIndexStr != null) {
            try {
                int index = Integer.parseInt(viewIndexStr);
                if (index >= 0 && index < history.size()) {
                    req.setAttribute("dailyMessage", history.get(index));
                    req.setAttribute("isHistorical", true);
                }
            } catch (NumberFormatException ignored) {}
        } else {
            req.setAttribute("dailyMessage", dailyMessage);
            // If we have a current message, hide it from the "Previous" list to avoid redundancy
            if (dailyMessage != null && !history.isEmpty()) {
                history.remove(0);
            }
        }
        
        req.setAttribute("quoteHistory", history);
        req.getRequestDispatcher("/WEB-INF/DailyQuotes.jsp").forward(req, resp);
    }
}
