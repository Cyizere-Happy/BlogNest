<%-- Created by IntelliJ IDEA. User: user Date: 02/02/2026 Time: 21:35 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>BlogNest - Admin Dashboard</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap"
                        rel="stylesheet">
                    <!-- Using a simple icon library assumption or SVGs -->
                </head>

                <body class="admin-body">

                    <!-- Sidebar -->
                    <aside class="admin-sidebar">
                        <div class="sidebar-header">
                            <div class="sidebar-logo">BlogNest <span class="admin-badge">Admin</span></div>
                        </div>
                        <nav class="sidebar-nav">
                            <a href="#" class="sidebar-link active" data-section="dashboard">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                </svg>
                                Dashboard
                            </a>
                            <a href="#" class="sidebar-link" data-section="manage-posts">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                    <polyline points="14 2 14 8 20 8"></polyline>
                                    <line x1="16" y1="13" x2="8" y2="13"></line>
                                    <line x1="16" y1="17" x2="8" y2="17"></line>
                                    <polyline points="10 9 9 9 8 9"></polyline>
                                </svg>
                                Manage Posts
                            </a>
                            <a href="#" class="sidebar-link" data-section="post-editor">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="12" y1="5" x2="12" y2="19"></line>
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                </svg>
                                Create Post
                            </a>
                            <a href="#" class="sidebar-link" data-section="users">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                                Users
                            </a>
                            <a href="#" class="sidebar-link" data-section="comments">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                </svg>
                                Comments
                            </a>
                            <a href="#" class="sidebar-link" data-section="analytics">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                                </svg>
                                Analytics
                            </a>
                            <a href="#" class="sidebar-link" data-section="settings">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="3"></circle>
                                    <path
                                        d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
                                    </path>
                                </svg>
                                Settings
                            </a>
                        </nav>
                        <div class="sidebar-footer">
                            <a href="auth?action=logout" class="sidebar-link logout">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                                Sign out
                            </a>
                        </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="admin-main">
                        <!-- Topbar -->
                        <header class="admin-topbar">
                            <div class="toggle-menu">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="3" y1="12" x2="21" y2="12"></line>
                                    <line x1="3" y1="6" x2="21" y2="6"></line>
                                    <line x1="3" y1="18" x2="21" y2="18"></line>
                                </svg>
                            </div>
                            <div class="welcome-text">
                                Home / Dashboard
                            </div>
                            <div class="topbar-actions">
                                <div class="action-icon">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="11" cy="11" r="8"></circle>
                                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                    </svg>
                                </div>
                                <div class="action-icon">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                                    </svg>
                                </div>
                                <div class="user-avatar">
                                    <img src="https://ui-avatars.com/api/?name=Cyizere&background=38b2ac&color=fff"
                                        alt="Admin">
                                </div>
                            </div>
                        </header>

                        <div class="admin-content-container">
                            <h1 class="admin-welcome-title reveal reveal-up">Welcome back, Cyizere.</h1>

                            <div class="admin-grid">
                                <!-- Search/Manage Card -->
                                <div class="admin-card reveal reveal-up delay-100">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                            <polyline points="14 2 14 8 20 8"></polyline>
                                            <line x1="16" y1="13" x2="8" y2="13"></line>
                                            <line x1="16" y1="17" x2="8" y2="17"></line>
                                            <polyline points="10 9 9 9 8 9"></polyline>
                                        </svg>
                                    </div>
                                    <h3>Manage Posts</h3>
                                    <p>Create, edit, or delete your blog stories and drafts.</p>
                                    <div class="card-action-overlay">
                                        <button class="view-btn" onclick="switchView('manage-posts')">View
                                            Posts</button>
                                        <button class="view-btn" onclick="switchView('post-editor')"
                                            style="margin-top: 10px; background-color: var(--primary-dark);">Create
                                            Post</button>
                                    </div>
                                </div>

                                <!-- Analytics Card -->
                                <div class="admin-card reveal reveal-up delay-200">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <rect x="3" y="3" width="7" height="9"></rect>
                                            <rect x="14" y="3" width="7" height="5"></rect>
                                            <rect x="14" y="12" width="7" height="9"></rect>
                                            <rect x="3" y="16" width="7" height="5"></rect>
                                        </svg>
                                    </div>
                                    <h3>Data & Reports</h3>
                                    <p>View your readership analytics and visitor insights.</p>
                                    <div class="card-action-overlay">
                                        <button class="view-btn" onclick="switchView('analytics')">View Data</button>
                                    </div>
                                </div>

                                <!-- Users Card -->
                                <div class="admin-card reveal reveal-up delay-300">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="9" cy="7" r="4"></circle>
                                        </svg>
                                    </div>
                                    <h3>Users</h3>
                                    <p>Manage your community and user permissions.</p>
                                    <div class="card-action-overlay">
                                        <button class="view-btn" onclick="switchView('users')">View Users</button>
                                    </div>
                                </div>

                                <!-- Comments Card -->
                                <div class="admin-card reveal reveal-up delay-100">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z">
                                            </path>
                                        </svg>
                                    </div>
                                    <h3>Comments</h3>
                                    <p>Moderate discussions and interact with your readers.</p>
                                    <div class="card-action-overlay">
                                        <button class="view-btn" onclick="switchView('comments')">View Comments</button>
                                    </div>
                                </div>

                                <!-- Resources Card -->
                                <div class="admin-card reveal reveal-up delay-200">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z">
                                            </path>
                                        </svg>
                                    </div>
                                    <h3>Resources</h3>
                                    <p>Access help guides and documentation for BlogNest.</p>
                                    <div class="card-action-overlay">
                                        <button class="view-btn">View Guides</button>
                                    </div>
                                </div>

                                <!-- Help Card (Large) -->
                                <div class="admin-card large-card reveal reveal-up delay-300">
                                    <div class="card-icon">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="var(--secondary-color)" stroke-width="1.5" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <circle cx="12" cy="12" r="10"></circle>
                                            <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                                            <line x1="12" y1="17" x2="12.01" y2="17"></line>
                                        </svg>
                                    </div>
                                    <h3>BlogNest Help</h3>
                                    <p>A fun and easy way to educate yourself in the ways of blogging.</p>
                                    <button class="view-btn static">View</button>
                                </div>
                            </div>

                            <!-- Manage Posts Section -->
                            <div id="manage-posts" class="admin-section" style="display: none;">
                                <div class="section-header">
                                    <h2 class="section-title">Story Management <span class="admin-badge"
                                            style="background: var(--text-dim);">${fn:length(posts)}</span></h2>
                                    <button class="btn btn-primary" onclick="prepareNewPost()">+ New
                                        Post</button>
                                </div>
                                <div class="post-cards-grid">
                                    <c:forEach var="post" items="${posts}">
                                        <div class="admin-post-card">
                                            <div class="post-card-visual">
                                                <span class="post-card-badge">${post.category}</span>
                                                <img src="${not empty post.thumbnail_url ? post.thumbnail_url : 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&q=80&w=800'}"
                                                    alt="${post.title}">
                                            </div>
                                            <div class="post-card-content">
                                                <div class="post-card-meta">
                                                    <span>${post.createdAt.toLocalDate()}</span>
                                                    <span class="dot"></span>
                                                    <span>5 MIN READ</span>
                                                </div>
                                                <h3 class="post-card-title">
                                                    <c:out value="${post.title}" />
                                                </h3>
                                                <p class="post-card-excerpt">
                                                    <c:out value="${post.description}" />
                                                </p>
                                                <div class="post-card-actions">
                                                    <a href="javascript:void(0)" class="edit-link"
                                                        onclick="editPost('${post.id}', this)"
                                                        data-title="${post.title}" data-desc="${post.description}"
                                                        data-content="<c:out value='${post.content}'/>"
                                                        data-category="${post.category}"
                                                        data-thumb="${post.thumbnail_url}">
                                                        Edit Blog <svg width="16" height="16" viewBox="0 0 24 24"
                                                            fill="none" stroke="currentColor" stroke-width="2.5"
                                                            stroke-linecap="round" stroke-linejoin="round">
                                                            <line x1="5" y1="12" x2="19" y2="12"></line>
                                                            <polyline points="12 5 19 12 12 19"></polyline>
                                                        </svg>
                                                    </a>
                                                    <form action="admin" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="deletePost">
                                                        <input type="hidden" name="postId" value="${post.id}">
                                                        <button type="submit" class="delete-btn-minimal"
                                                            onclick="return confirm('Delete this post?')">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <polyline points="3 6 5 6 21 6"></polyline>
                                                                <path
                                                                    d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                                </path>
                                                                <line x1="10" y1="11" x2="10" y2="17"></line>
                                                                <line x1="14" y1="11" x2="14" y2="17"></line>
                                                            </svg>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Users Section -->
                            <div id="users" class="admin-section" style="display: none;">
                                <div class="section-header">
                                    <h2 class="section-title">Platform Users <span class="admin-badge"
                                            style="background: var(--text-dim);">${fn:length(users)}</span></h2>
                                </div>
                                <div class="table-container">
                                    <table class="admin-table">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Joined</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty users}">
                                                    <c:forEach var="u" items="${users}">
                                                        <tr>
                                                            <td class="user-cell"><img
                                                                    src="https://ui-avatars.com/api/?name=<c:out value="${u.name}"/>"
                                                                    alt="">
                                                                <c:out value="${u.name}"/>
                                                                <c:if test="${u.id == sessionScope.user.id}">
                                                                    <span class="status-badge published"
                                                                        style="font-size: 10px; margin-left: 5px;">You</span>
                                                                </c:if>
                                                            </td>
                                                            <td><c:out value="${u.email}"/></td>
                                                            <td><c:out value="${u.role}"/></td>
                                                            <td>Joined</td>
                                                            <td>
                                                                <c:if test="${u.id != sessionScope.user.id}">
                                                                    <form action="admin" method="post"
                                                                        style="display:inline;">
                                                                        <input type="hidden" name="action"
                                                                            value="deleteUser">
                                                                        <input type="hidden" name="userId"
                                                                            value="${u.id}">
                                                                        <button type="submit" class="action-btn danger"
                                                                            onclick="return confirm('Delete this user? This will also delete all their posts and comments.')">Disable</button>
                                                                    </form>
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="5" style="text-align:center; padding: 20px;">No
                                                            users found.</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Comments Section -->
                            <div id="comments" class="admin-section" style="display: none;">
                                <div class="section-header">
                                    <h2 class="section-title">Latest Comments</h2>
                                </div>
                                <div class="table-container">
                                    <table class="admin-table">
                                        <thead>
                                            <tr>
                                                <th>Reader</th>
                                                <th>Comment</th>
                                                <th>Post</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="comment" items="${comments}">
                                                <tr>
                                                    <td><c:out value="${comment.user.name}"/></td>
                                                    <td>"<c:out value="${comment.content}"/>"</td>
                                                    <td><c:out value="${comment.post.title}"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${comment.approved}">
                                                                <span class="status-badge published">Approved</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge pending">Pending</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:if test="${!comment.approved}">
                                                            <form action="admin" method="post" style="display:inline;">
                                                                <input type="hidden" name="action"
                                                                    value="approveComment">
                                                                <input type="hidden" name="commentId"
                                                                    value="${comment.id}">
                                                                <button type="submit"
                                                                    class="action-btn success">Approve</button>
                                                            </form>
                                                        </c:if>
                                                        <form action="admin" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="deleteComment">
                                                            <input type="hidden" name="commentId" value="${comment.id}">
                                                            <button type="submit"
                                                                class="action-btn danger">Delete</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Analytics Section -->
                            <div id="analytics" class="admin-section" style="display: none;">
                                <div class="section-header">
                                    <h2 class="section-title">Analytics Overview</h2>
                                </div>
                                <div class="analytics-grid">
                                    <div class="analytics-card">
                                        <h4>Total Views</h4>
                                        <div class="stat-value">${totalViews}</div>
                                        <div class="stat-change positive">+${totalViews} total</div>
                                    </div>
                                    <div class="analytics-card">
                                        <h4>Total Posts</h4>
                                        <div class="stat-value">${totalPosts}</div>
                                        <div class="stat-change positive">${totalPosts} active stories</div>
                                    </div>
                                </div>
                                <div class="visual-report">
                                    <!-- Simple SVG Chart Mock -->
                                    <svg viewBox="0 0 100 40" class="mock-chart">
                                        <polyline fill="none" stroke="var(--secondary-color)" stroke-width="0.5"
                                            points="0,40 10,35 20,38 30,25 40,28 50,15 60,18 70,5 80,8 90,2 100,6" />
                                    </svg>
                                </div>
                            </div>

                            <!-- Post Editor Section (Hidden by default) -->
                            <div id="post-editor" class="admin-section" style="display: none;">
                                <form action="admin" method="post">
                                    <input type="hidden" name="action" id="editor-action" value="createPost">
                                    <input type="hidden" name="postId" id="editor-post-id" value="">
                                    <div class="editor-header">
                                        <h2 class="editor-title" id="editor-title-h2">Create New Story</h2>
                                        <div class="editor-actions">
                                            <button type="button" class="btn btn-outline"
                                                id="cancel-edit">Cancel</button>
                                            <button type="submit" class="btn btn-primary" id="publish-post">Publish
                                                Post</button>
                                        </div>
                                    </div>

                                    <div class="editor-grid">
                                        <div class="editor-main-canvas">
                                            <div class="form-group">
                                                <label for="post-title">Post Title</label>
                                                <input type="text" id="post-title" name="title"
                                                    placeholder="Enter a catchy title..."
                                                    class="form-control title-input" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="post-content">Story Content</label>
                                                <textarea id="post-content" name="content"
                                                    placeholder="Write your masterpiece here..."
                                                    class="form-control content-area" required></textarea>
                                            </div>
                                        </div>

                                        <div class="editor-sidebar-canvas">
                                            <div class="form-group">
                                                <label for="post-category">Category</label>
                                                <select id="post-category" name="category" class="form-control">
                                                    <option value="">Select Category</option>
                                                    <option value="lifestyle">Lifestyle</option>
                                                    <option value="tech">Technology</option>
                                                    <option value="travel">Travel</option>
                                                    <option value="creative">Creative Writing</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="post-image">Featured Image URL</label>
                                                <input type="text" id="post-image" name="thumbnail_url"
                                                    placeholder="https://example.com/image.jpg" class="form-control">
                                            </div>

                                            <div class="form-group">
                                                <label for="post-excerpt">Excerpt</label>
                                                <textarea id="post-excerpt" name="description"
                                                    placeholder="A short summary for previews..."
                                                    class="form-control excerpt-area"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </main>

                    <script>
                        // View Management
                        const sections = ['dashboard', 'manage-posts', 'post-editor', 'users', 'comments', 'analytics'];
                        const sidebarLinks = document.querySelectorAll('.sidebar-link[data-section]');
                        const adminWelcomeTitle = document.querySelector('.admin-welcome-title');
                        const adminGrid = document.querySelector('.admin-grid');

                        function switchView(viewName) {
                            // Hide all specialized sections
                            document.querySelectorAll('.admin-section').forEach(section => {
                                section.style.display = 'none';
                            });

                            // Handle Dashboard special case
                            if (viewName === 'dashboard') {
                                adminWelcomeTitle.style.display = 'block';
                                adminGrid.style.display = 'grid';
                            } else {
                                adminWelcomeTitle.style.display = 'none';
                                adminGrid.style.display = 'none';
                                const target = document.getElementById(viewName);
                                if (target) target.style.display = 'block';
                            }

                            // Update Sidebar UI
                            sidebarLinks.forEach(link => {
                                link.classList.remove('active');
                                if (link.getAttribute('data-section') === viewName) {
                                    link.classList.add('active');
                                }
                            });
                        }

                        function editPost(postId, btn) {
                            // Logic to switch to editor and load data from data attributes
                            document.getElementById('editor-title-h2').innerText = "Edit Story";
                            document.getElementById('editor-action').value = "updatePost";
                            document.getElementById('editor-post-id').value = postId;
                            document.getElementById('publish-post').innerText = "Update Post";

                            // Fill fields
                            document.getElementById('post-title').value = btn.getAttribute('data-title');
                            document.getElementById('post-excerpt').value = btn.getAttribute('data-desc');
                            document.getElementById('post-content').value = btn.getAttribute('data-content');
                            document.getElementById('post-category').value = btn.getAttribute('data-category');
                            document.getElementById('post-image').value = btn.getAttribute('data-thumb');

                            switchView('post-editor');
                        }

                        // Reset form for New Post
                        function prepareNewPost() {
                            document.getElementById('editor-title-h2').innerText = "Create New Story";
                            document.getElementById('editor-action').value = "createPost";
                            document.getElementById('editor-post-id').value = "";
                            document.getElementById('publish-post').innerText = "Publish Post";

                            document.getElementById('post-title').value = "";
                            document.getElementById('post-excerpt').value = "";
                            document.getElementById('post-content').value = "";
                            document.getElementById('post-category').value = "";
                            document.getElementById('post-image').value = "";

                            switchView('post-editor');
                        }

                        // Sidebar Navigation Listeners
                        sidebarLinks.forEach(link => {
                            link.addEventListener('click', (e) => {
                                e.preventDefault();
                                const section = link.getAttribute('data-section');
                                switchView(section);
                            });
                        });

                        // Specific Editor Actions
                        const cancelEdit = document.getElementById('cancel-edit');

                        cancelEdit.addEventListener('click', () => {
                            switchView('dashboard');
                        });

                        // Simple script to toggle active state on cards for demo
                        document.querySelectorAll('.admin-post-card').forEach(card => {
                            card.addEventListener('click', () => {
                                // demo effect
                            });
                        });

                        // Check for pre-loaded editPost (from cross-page edit)
                        <c:if test="${not empty editPost}">
                            window.addEventListener('DOMContentLoaded', () => {
                                // Need to simulate a button or just fill directly
                                document.getElementById('editor-title-h2').innerText = "Edit Story";
                            document.getElementById('editor-action').value = "updatePost";
                            document.getElementById('editor-post-id').value = "${editPost.id}";
                            document.getElementById('publish-post').innerText = "Update Post";

                            document.getElementById('post-title').value = `<c:out value="${editPost.title}" />`;
                            document.getElementById('post-excerpt').value = `<c:out value="${editPost.description}" />`;
                            document.getElementById('post-content').value = `<c:out value="${editPost.content}" />`;
                            document.getElementById('post-category').value = `<c:out value="${editPost.category}" />`;
                            document.getElementById('post-image').value = `<c:out value="${editPost.thumbnail_url}" />`;

                                switchView('post-editor');
                            });
                        </c:if>

                        // Check for section parameter in URL
                        window.addEventListener('DOMContentLoaded', () => {
                            const urlParams = new URLSearchParams(window.location.search);
                            const section = urlParams.get('section');
                            if (section) {
                                switchView(section);
                            }
                        });
                    </script>
                    <script src="${pageContext.request.contextPath}/js/animations.js"></script>
                </body>

                </html>