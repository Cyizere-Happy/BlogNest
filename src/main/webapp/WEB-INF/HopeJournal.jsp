<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlogNest - Journal of Hope</title>
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
                <a href="${pageContext.request.contextPath}/quotes" class="nav-item">Daily Quote</a>
                <a href="${pageContext.request.contextPath}/hope" class="nav-item active">Hope Journal</a>
            </div>
            <div class="nav-profile">
                <!-- Keep profile icon for consistency -->
                 <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </div>
        </div>
    </nav>

    <main>
        <div class="hope-hero reveal reveal-up">
            <span class="hope-badge">The Sanctuary</span>
            <h1>A living timeline of faith.</h1>
            <p>Release your hopes into this digital journal. It marks the moment you chose to believe in something better.</p>
            
            <div class="hope-actions">
                <button class="btn-release" onclick="toggleModal('release-modal')">Release a Hope</button>
                <button class="btn btn-outline" style="border-radius: 30px; font-weight: 700; padding: 12px 30px;" onclick="toggleModal('revisit-modal')">Revisit Yours</button>
            </div>
        </div>

        <section class="hope-stream">
            <c:forEach var="hope" items="${publicHopes}" varStatus="status">
                <div class="hope-card reveal reveal-scale" 
                     onclick="viewHope('${fn:escapeXml(hope.content)}', '${hope.timestamp.toLocalDate()}', '${hope.id}')">
                    <div class="card-index">Hope 0${status.index + 1}</div>
                    <h3 style="font-size: 1rem;">${fn:substring(hope.content, 0, 15)}...</h3>
                    <p style="font-size: 0.8rem;">"${fn:substring(hope.content, 0, 80)}${fn:length(hope.content) > 80 ? '...' : ''}"</p>
                    <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #f1f5f9; padding-top: 10px;">
                        <span style="font-size: 0.7rem; color: var(--hope-accent); font-weight: 700;">${hope.timestamp.toLocalDate()}</span>
                        <span style="font-size: 0.65rem; color: var(--hope-text-light); text-decoration: underline;">Read more</span>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${fn:length(publicHopes) >= currentLimit}">
                <button class="btn-see-more" onclick="location.href='hope?limit=${currentLimit + 10}'">See More Interactions</button>
            </c:if>
        </section>
    </main>

    <!-- Release Modal -->
    <div id="release-modal" class="hope-modal">
        <div class="modal-content">
            <button style="position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 1.5rem;" onclick="toggleModal('release-modal')">×</button>
            <h2>Release your wish.</h2>
            <form action="hope" method="post">
                <input type="hidden" name="action" value="release">
                <textarea name="content" class="form-control" style="min-height: 200px;" placeholder="What do you hope for today?" required></textarea>
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 2rem;">
                    <input type="checkbox" name="isPublic" id="isPublic" checked style="width: 20px; height: 20px;">
                    <label for="isPublic" style="font-size: 0.95rem; color: var(--hope-text-light);">Share anonymously with the collective stream</label>
                </div>
                <button type="submit" class="btn-release">Seal My Hope</button>
            </form>
        </div>
    </div>

    <!-- Revisit Modal -->
    <div id="revisit-modal" class="hope-modal">
        <div class="modal-content" style="text-align: center;">
            <button style="position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 1.5rem;" onclick="toggleModal('revisit-modal')">×</button>
            <h2>Return to your journal.</h2>
            <p style="margin-bottom: 2rem;">Enter your 8-character secret key to unlock your dedicated journey page.</p>
            <form action="hope/journey" method="get">
                <input type="text" name="key" class="form-control" placeholder="e.g. A1B2C3D4" style="text-align: center; letter-spacing: 5px; font-weight: 800; text-transform: uppercase;" required>
                <button type="submit" class="btn-release">Unlock Journey</button>
            </form>
        </div>
    </div>

    <!-- Detail View Modal -->
    <div id="view-modal" class="hope-modal">
        <div class="modal-content" style="text-align: center;">
            <button style="position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 1.5rem;" onclick="toggleModal('view-modal')">×</button>
            <span class="hope-badge" id="view-date">Date</span>
            <h2 id="view-content" style="font-size: 1.8rem; line-height: 1.4; margin-bottom: 2rem;">Content</h2>
            <p style="color: var(--hope-text-light); font-family: 'Jost';">This is a shared moment of hope from the collective stream.</p>
            <button class="btn btn-outline" style="margin-top: 2rem; border-radius: 30px;" onclick="toggleModal('view-modal')">Close Sanctuary</button>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/animations.js"></script>
    <script>
        function toggleModal(id) {
            document.getElementById(id).classList.toggle('active');
        }

        function viewHope(content, date, id) {
            document.getElementById('view-content').innerText = "\"" + content + "\"";
            document.getElementById('view-date').innerText = "Released " + date;
            toggleModal('view-modal');
        }

        // Handle the Key Display after submission
        <c:if test="${not empty newHopeKey}">
            (function() {
                var hopeKey = '<c:out value="${newHopeKey}" />';
                document.addEventListener('DOMContentLoaded', function() {
                    alert("Your Hope has been sealed. IMPORTANT: Save this key to revisit your journal later: " + hopeKey);
                });
            })();
        </c:if>
    </script>
    <jsp:include page="toast_component.jsp" />
</body>
</html>
