<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>BlogNest - Stories</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/blogs.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
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
                            style="text-decoration: none;   color: inherit;">BlogNest</a></div>
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
                        <a href="${pageContext.request.contextPath}/quotes" class="nav-item">Daily Quote</a>
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

            <main class="blog-container">
                <section class="discovery-header reveal reveal-up">
                    <span class="discovery-label">EXCLUSIVE DISCOVERY</span>
                    <h1 class="discovery-title">Discovery</h1>
                </section>

                <section class="marquee-section reveal reveal-up delay-100">
                    <div class="marquee-container">
                        <div class="marquee-track">
                            <!-- Dynamic Posts Loop -->
                            <c:choose>
                                <c:when test="${not empty posts}">
                                    <!-- First Loop -->
                                    <c:forEach var="post" items="${posts}">
                                        <div class="discovery-card">
                                            <div class="card-visuals">
                                                <div class="main-img"
                                                    style="background-color: ${post.category == 'Tech' ? '#cbd5e0' : '#f7fafc'}; background-image: url('${post.thumbnail_url}'); background-size: cover; background-position: center;">
                                                </div>
                                                <div class="thumb-img"
                                                    style="background-color: var(--secondary-color);"></div>
                                            </div>
                                            <div class="card-info">
                                                <h3>
                                                    <c:out value="${post.title}" />
                                                </h3>
                                                <p>
                                                    <c:out value="${post.description}" />
                                                </p>
                                                <a href="${pageContext.request.contextPath}/read_blog?id=${post.id}"
                                                    class="read-more">Read Story &rarr;</a>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <!-- Second Loop for Infinite Effect -->
                                    <c:forEach var="post" items="${posts}">
                                        <div class="discovery-card">
                                            <div class="card-visuals">
                                                <div class="main-img"
                                                    style="background-color: ${post.category == 'Tech' ? '#cbd5e0' : '#f7fafc'}; background-image: url('${post.thumbnail_url}'); background-size: cover; background-position: center;">
                                                </div>
                                                <div class="thumb-img"
                                                    style="background-color: var(--secondary-color);"></div>
                                            </div>
                                            <div class="card-info">
                                                <h3>
                                                    <c:out value="${post.title}" />
                                                </h3>
                                                <p>
                                                    <c:out value="${post.description}" />
                                                </p>
                                                <a href="${pageContext.request.contextPath}/read_blog?id=${post.id}"
                                                    class="read-more">Read Story &rarr;</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="discovery-card">
                                        <div class="card-info">
                                            <h3>No Posts Yet</h3>
                                            <p>Check back later for new stories.</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </section>

                <section class="about-section reveal reveal-up delay-200">
                    <div class="about-content">
                        <h2>About</h2>
                        <p>
                            I'm <strong>Cyizere</strong>, a curious designer, coder, and storyteller.
                            Currently exploring the limitless possibilities of creativity and technology.
                            <br><br>
                            "I thrive on transforming ideas into reality, whether it's crafting digital interfaces,
                            designing immersive visuals, or building websites that feel effortless to use."
                        </p>
                    </div>
                </section>
            </main>

            <jsp:include page="profile_modal.jsp" />
            <script src="${pageContext.request.contextPath}/js/theme.js"></script>
            <script src="${pageContext.request.contextPath}/js/animations.js"></script>
            <script src="${pageContext.request.contextPath}/js/profile.js"></script>
            <jsp:include page="toast_component.jsp" />
        </body>

        </html>