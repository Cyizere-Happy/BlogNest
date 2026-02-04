<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Designing for Humans - BlogNest</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/blogs.css">
            <!-- For shared blog-body split background -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/read_blog.css">
            <!-- Specific Layout Styles -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">
        </head>

        <body class="blog-body">
            <!-- Shared Floating Navbar -->
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

            <div class="read-blog-container">
                <!-- Column 1: Main Hero Image -->
                <div class="hero-column reveal reveal-right">
                    <div class="article-hero-img">
                        <c:if test="${not empty post.thumbnail_url}">
                            <img src="${post.thumbnail_url}" alt="${post.title}"
                                style="width: 100%; height: 100%; object-fit: cover;">
                        </c:if>
                        <c:if test="${empty post.thumbnail_url}">
                            <div style="width: 100%; height: 100%; background: var(--secondary-color); opacity: 0.1;">
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Column 2: Main Content -->
                <main class="article-content reveal reveal-up delay-100">
                    <article>
                        <header class="article-header">
                            <!-- Category Tag -->
                            <div class="article-category">
                                <c:out value="${not empty post.category ? post.category : 'General Stories'}" />
                            </div>
                            <h1 class="article-title">
                                <c:out value="${post.title}" />
                            </h1>
                            <div class="article-meta"
                                style="display: flex; gap: 1.5rem; color: var(--text-light); border-top: 1px solid rgba(0,0,0,0.05); padding-top: 1.5rem;">
                                <span>By <strong>
                                        <c:out
                                            value="${not empty post.author.name ? post.author.name : 'BlogNest Author'}" />
                                    </strong></span>
                                <span class="meta-separator">•</span>
                                <span>${not empty post.createdAt ? post.createdAt.toLocalDate() : 'Just now'}</span>
                                <c:if test="${user.role == 'ADMIN'}">
                                    <span class="meta-separator">•</span>
                                    <a href="${pageContext.request.contextPath}/admin?editId=${post.id}"
                                        class="edit-story-btn"
                                        style="color: var(--secondary-color); text-decoration: none; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px;">
                                        Edit Story
                                    </a>
                                </c:if>
                            </div>
                        </header>

                        <div class="article-body">
                            <c:choose>
                                <c:when test="${not empty post.content}">
                                    <c:out value="${post.content}" />
                                </c:when>
                                <c:otherwise>
                                    <p>No content available.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </article>

                    <!-- Comments Section -->
                    <section class="comments-section">
                        <h3 class="comments-title">Join the Conversation</h3>

                        <!-- Comment Form -->
                        <c:choose>
                            <c:when test="${not empty user}">
                                <form class="comment-form" action="read_blog" method="post">
                                    <input type="hidden" name="postId" value="${post.id}">
                                    <textarea name="content" placeholder="Share your thoughts..." required></textarea>
                                    <button type="submit" class="btn btn-primary">Post Comment</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="login-prompt"
                                    style="padding: 2rem; background: var(--white); border-radius: 12px; text-align: center; border: 1px dashed var(--secondary-color);">
                                    <p style="margin-bottom: 1rem;">Please <a href="auth"
                                            style="color: var(--secondary-color); font-weight: 600;">log in</a>
                                        to join the conversation.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- Comments List -->
                        <div class="comments-list" style="margin-top: 2rem;">
                            <c:if test="${not empty post.comments}">
                                <c:forEach var="comment" items="${post.comments}">
                                    <div class="comment-item"
                                        style="margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid #eee;">
                                        <div class="comment-header"
                                            style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                            <strong>
                                                <c:out value="${comment.user.name}" />
                                            </strong>
                                            <span
                                                style="font-size: 0.8rem; color: #888;">${comment.createdAt.toLocalDate()}</span>
                                        </div>
                                        <p>
                                            <c:out value="${comment.content}" />
                                        </p>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty post.comments}">
                                <p style="color: #888; font-style: italic;">No comments yet. Be the first to
                                    share!</p>
                            </c:if>
                        </div>
                    </section>
                </main>

                <!-- Column 3: Right Sidebar (Bookshelf) -->
                <aside class="blog-sidebar reveal reveal-left delay-200">
                    <span class="sidebar-label">More Stories</span>
                    <div class="sidebar-list">
                        <c:forEach var="other" items="${otherPosts}">
                            <a href="read_blog?id=${other.id}" class="sidebar-item"
                                style="text-decoration: none; color: inherit; display: block; margin-bottom: 2rem;">
                                <div class="sidebar-thumb"
                                    style="background: url('${other.thumbnail_url}') center/cover; background-color: var(--secondary-color);">
                                </div>
                                <div class="sidebar-title">${other.title}</div>
                            </a>
                        </c:forEach>
                        <c:if test="${empty otherPosts}">
                            <p style="color: #888; font-style: italic; font-size: 0.8rem;">No other stories yet.</p>
                        </c:if>
                    </div>
                </aside>
            </div>

            <jsp:include page="profile_modal.jsp" />
            <script src="${pageContext.request.contextPath}/js/theme.js"></script>
            <script src="${pageContext.request.contextPath}/js/animations.js"></script>
            <script src="${pageContext.request.contextPath}/js/profile.js"></script>
        </body>

        </html>