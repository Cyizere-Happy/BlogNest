<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>BlogNest - Message of the Day</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quotes.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">
        </head>

        <body class="blog-body">
            <nav class="floating-navbar">
                <div class="pill-nav">
                    <div class="nav-logo"><a href="${pageContext.request.contextPath}/blog"
                            style="text-decoration: none; color: inherit;">BlogNest</a></div>
                    <div class="nav-theme-toggle" id="theme-toggle">
                        <svg id="moon-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                        </svg>
                        <svg id="sun-icon" style="display:none;" width="20" height="20" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="5"></circle>
                            <line x1="12" y1="1" x2="12" y2="3"></line>
                            <line x1="12" y1="21" x2="12" y2="23"></line>
                            <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                            <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                            <line x1="1" y1="12" x2="3" y2="12"></line>
                            <line x1="21" y1="12" x2="23" y2="12"></line>
                            <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                            <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                        </svg>
                    </div>
                    <div class="nav-links">
                        <a href="${pageContext.request.contextPath}/quotes" class="nav-item active">Daily Quote</a>
                        <a href="${pageContext.request.contextPath}/hope" class="nav-item">Hope Journal</a>
                    </div>
                    <div class="nav-profile">
                        <a href="javascript:void(0)" class="active-profile profile-trigger"
                            data-logged-in="${user != null}" style="color: inherit;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                        </a>
                    </div>
                </div>
            </nav>

            <main class="quotes-container reveal reveal-up">
                <c:choose>
                    <c:when test="${not empty dailyMessage}">
                        <div class="header-marker">
                            <c:out value="${dailyMessage.formattedDay}" />
                        </div>
                        <header class="quotes-header">
                            <c:if test="${isHistorical}">
                                <div style="display: flex; justify-content: center; margin-bottom: 10px;">
                                    <span class="status-badge" style="background: var(--secondary-color); color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: 700;">PREVIOUS INSIGHT</span>
                                </div>
                            </c:if>
                            <h1>
                                <c:out value="${dailyMessage.title}" />
                            </h1>
                            <div class="header-content">
                                <div class="red-bar"></div> <!-- Keeping class name but it's teal -->
                                <p>
                                    <c:out value="${dailyMessage.mainMessage}" />
                                </p>
                            </div>
                            
                            <div class="like-container" data-quote-id="${dailyMessage.id}" onclick="handleLike(this, event)">
                                <button class="heart-button" id="main-heart">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l8.78-8.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                    </svg>
                                </button>
                                <span class="likes-count">${dailyMessage.likes}</span>
                            </div>
                            <c:if test="${isHistorical}">
                                <div style="margin-top: 20px;">
                                    <a href="quotes" class="btn btn-outline" style="padding: 8px 20px; font-size: 0.8rem; border-color: var(--secondary-color); color: var(--secondary-color); text-decoration: none; border-radius: 30px; font-weight: 600;">Back to Present</a>
                                </div>
                            </c:if>
                        </header>

                        <section class="timeline-system">
                            <div class="main-line">
                                <div class="line-dot">
                                    <span class="dot-label">DISCOVERY</span>
                                </div>
                                <div class="line-dot" style="left: -15%;">
                                    <span class="dot-label">INSIGHT</span>
                                </div>
                                <div class="line-dot">
                                    <span class="dot-label">ACTION</span>
                                </div>
                            </div>

                            <div class="stickers-area">
                                <c:forEach var="takeaway" items="${dailyMessage.takeaways}" varStatus="status">
                                    <div class="sticker-card" data-index="${status.index}">
                                        <c:out value="${takeaway}" />
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 100px 20px;">
                            <h1
                                style="font-family: 'Outfit'; font-size: 3rem; margin-bottom: 20px; color: var(--text-color);">
                                No daily message for today</h1>
                            <p style="font-family: 'Jost'; color: #64748b;">The writer hasn't shared a new insight just
                                yet. Check back soon or browse the history below!</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Quote History Section -->
                <div style="margin-top: 100px; padding: 40px 0; border-top: 1px solid #e2e8f0;">
                    <h2
                        style="font-family: 'Outfit'; margin-bottom: 40px; text-align: center; color: var(--text-color);">
                        Previous Insights
                    </h2>
                    <c:choose>
                        <c:when test="${not empty quoteHistory}">
                            <div class="history-list"
                                style="display: flex; flex-direction: column; gap: 30px; max-width: 800px; margin: 0 auto;">
                                <c:forEach var="historyMsg" items="${quoteHistory}" varStatus="status">
                                    <a href="?viewIndex=${status.index}" class="history-item-link" style="text-decoration: none; display: block;">
                                        <div class="history-item"
                                            style="padding: 24px; background: rgba(255,255,255,0.05); border-radius: 16px; border: 1px solid #e2e8f0; transition: transform 0.3s ease;">
                                            <div
                                                style="font-size: 0.75rem; color: var(--secondary-color); font-weight: 700; margin-bottom: 10px;">
                                                <c:out value="${historyMsg.relativeTime}" />
                                            </div>
                                            <h3
                                                style="font-family: 'Outfit'; margin-bottom: 8px; color: var(--text-color);">
                                                <c:out value="${historyMsg.title}" />
                                            </h3>
                                            <p
                                                style="font-family: 'Jost'; color: #64748b; font-size: 0.9rem; line-height: 1.6;">
                                                <c:out value="${historyMsg.mainMessage}" />
                                            </p>
                                            
                                            <div class="like-container" data-quote-id="${historyMsg.id}" onclick="handleLike(this, event)">
                                                <button class="heart-button">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l8.78-8.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                                    </svg>
                                                </button>
                                                <span class="likes-count">${historyMsg.likes}</span>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #64748b; font-family: 'Jost';">No previous insights
                                yet. Stay tuned!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="profile_modal.jsp" />
            <script src="${pageContext.request.contextPath}/js/theme.js"></script>
            <script src="${pageContext.request.contextPath}/js/animations.js"></script>
            <script src="${pageContext.request.contextPath}/js/profile.js"></script>
            <script>
                window.chatUser = "${not empty user ? user.name : 'Guest'}";
                window.contextPath = "${pageContext.request.contextPath}";

                function handleLike(container, event) {
                    if (event) event.preventDefault();
                    if (event) event.stopPropagation();
                    
                    const quoteId = container.getAttribute('data-quote-id');
                    const heartBtn = container.querySelector('.heart-button');
                    const countSpan = container.querySelector('.likes-count');
                    
                    // Check local storage to prevent multiple likes
                    const likedQuotes = JSON.parse(localStorage.getItem('likedQuotes') || '[]');
                    if (likedQuotes.includes(quoteId)) {
                        return; // Already liked
                    }

                    // Optimistic update
                    heartBtn.classList.add('liked');
                    const currentCount = parseInt(countSpan.textContent);
                    countSpan.textContent = currentCount + 1;
                    
                    // Save to local storage
                    likedQuotes.push(quoteId);
                    localStorage.setItem('likedQuotes', JSON.stringify(likedQuotes));

                    // Server update
                    fetch(window.contextPath + '/quotes', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'id=' + quoteId
                    })
                    .then(response => response.text())
                    .then(newCount => {
                        countSpan.textContent = newCount;
                    })
                    .catch(err => {
                        console.error('Failed to like:', err);
                        // Rollback on error if needed
                    });
                }

                // Initial state check
                document.addEventListener('DOMContentLoaded', () => {
                    const likedQuotes = JSON.parse(localStorage.getItem('likedQuotes') || '[]');
                    document.querySelectorAll('.like-container').forEach(container => {
                        const quoteId = container.getAttribute('data-quote-id');
                        if (likedQuotes.includes(quoteId)) {
                            container.querySelector('.heart-button').classList.add('liked');
                        }
                    });
                });
            </script>
            <script src="${pageContext.request.contextPath}/js/chat.js?v=1.2"></script>
            <jsp:include page="toast_component.jsp" />
        </body>

        </html>