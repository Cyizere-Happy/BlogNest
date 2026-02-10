package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.MessageOfTheDay;
import org.example.blognest.services.QuoteService;
import java.io.IOException;

@WebServlet("/quotes")
public class QuotesController extends HttpServlet {
    private final QuoteService quoteService = QuoteService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MessageOfTheDay dailyMessage = quoteService.getDailyMessage();
        req.setAttribute("dailyMessage", dailyMessage);
        req.getRequestDispatcher("/WEB-INF/DailyQuotes.jsp").forward(req, resp);
    }
}
