<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlogNest - Your Hope Journey</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hope.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body class="hope-body">
    <nav class="floating-navbar">
        <div class="pill-nav">
            <div class="nav-logo"><a href="${pageContext.request.contextPath}/blog" style="text-decoration: none; color: inherit;">BlogNest</a></div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/hope" class="nav-item">Back to Sanctuary</a>
            </div>
            <div class="nav-profile">
                 <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </div>
        </div>
    </nav>

    <main>
        <header class="journey-header reveal reveal-up">
            <span class="hope-badge">Private Sanctuary</span>
            <h1 style="font-size: 2.5rem; margin-bottom: 1rem;">"${myHope.content}"</h1>
            <p style="color: var(--hope-accent); font-weight: 700; margin-bottom: 1.5rem;">
                Sealed on <c:choose><c:when test="${not empty myHope.timestamp}">${myHope.timestamp.toLocalDate()}</c:when><c:otherwise>today</c:otherwise></c:choose>
            </p>
            
            <div class="reaction-strip" style="opacity: 0.9; transform: scale(0.9);">
                <div class="btn-react" style="cursor: default;"><small>Comfort</small> ${myHope.comfortCount}</div>
                <div class="btn-react" style="cursor: default;"><small>Strength</small> ${myHope.supportCount}</div>
                <div class="btn-react" style="cursor: default;"><small>Care</small> ${myHope.hugCount}</div>
            </div>
        </header>

        <section class="journey-container reveal reveal-up delay-200">
            <div class="hope-timeline">
                <div class="timeline-event">
                    <div class="event-date">INITIAL RELEASE</div>
                    <div class="event-content">You released this hope into the sanctuary. The journey began.</div>
                </div>
                <c:forEach var="update" items="${myHope.updates}">
                    <div class="timeline-event">
                        <div class="event-date">
                            <c:choose><c:when test="${not empty update.timestamp}">${update.timestamp.toLocalDate()}</c:when><c:otherwise>Recent</c:otherwise></c:choose>
                        </div>
                        <div class="event-content">${update.content}</div>
                    </div>
                </c:forEach>
                
                <div style="margin-top: 60px; padding: 2.5rem; background: white; border-radius: 20px; box-shadow: var(--hope-shadow);">
                    <h3 style="margin-bottom: 1.5rem; font-weight: 800;">Share your testimony</h3>
                    <form action="${pageContext.request.contextPath}/hope" method="post">
                        <input type="hidden" name="action" value="evolve">
                        <input type="hidden" name="hopeId" value="${myHope.id}">
                        <input type="hidden" name="revisitKey" value="${myHope.secretKey}">
                        <textarea name="updateContent" class="form-control" placeholder="How has God moved in your life? What has changed since you first released this hope?" 
                                  style="min-height: 150px;" required></textarea>
                        <button type="submit" class="btn-release">Add to My Story</button>
                    </form>
                </div>
            </div>

            <div style="text-align: center; margin-top: 4rem; opacity: 0.6;">
                <p style="font-size: 0.8rem;">Only those with your unique key can see this journal.</p>
                <p style="font-size: 0.9rem; font-weight: 700; margin-top: 10px;">Your Key: ${myHope.secretKey}</p>
            </div>
        </section>
    </main>

    <script src="${pageContext.request.contextPath}/js/animations.js"></script>
    <jsp:include page="toast_component.jsp" />
</body>
</html>
