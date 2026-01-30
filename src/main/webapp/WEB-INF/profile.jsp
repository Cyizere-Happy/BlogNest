<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile | BlogNest</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
    </head>

    <body>
        <!-- Navbar -->
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
                <div class="nav-profile">
                    <a href="${pageContext.request.contextPath}/profile" class="active-profile">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </a>
                </div>
            </div>
        </nav>

        <main class="profile-container">
            <div class="profile-card reveal reveal-zoom">
                <div class="profile-header-section">
                    <h1>Good Evening, ${user != null ? user.name : 'Guest'}.</h1>
                    <p>Start supporting your customers in no time, by completing the tasks below.</p>
                </div>

                <div class="progress-section">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 22%;"></div>
                    </div>
                    <div class="progress-badge">22%</div>
                </div>

                <div class="setup-group">
                    <div class="setup-card active">
                        <div class="setup-icon-check">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                        </div>
                        <div class="setup-content">
                            <h3>Learn BlogNest</h3>
                            <div class="setup-body">
                                <div class="setup-illustration">
                                    <img src="images/Profile.gif" alt="Profile Logic" class="profile-gif">
                                </div>
                                <div class="setup-text">
                                    <p>Take a quick video tour for an introduction to BlogNest's effortless, personal
                                        blogging experience.</p>
                                    <a href="#" class="btn-link">Complete</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="setup-list">
                        <div class="setup-item">
                            <div class="step-number">2</div>
                            <div class="step-details">
                                <h4>Quick Start</h4>
                                <div class="step-actions">
                                    <div class="action-row">
                                        <span>Start receiving emails</span>
                                        <span class="status-complete">Complete</span>
                                    </div>
                                    <div class="action-row">
                                        <span>Link your social accounts</span>
                                        <div class="action-links">
                                            <a href="#">Explore</a>
                                            <span class="status-complete">Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="logout-section" style="margin-top: 2rem; text-align: right;">
                    <p>Logged in as: <strong>${user.email}</strong></p>
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-primary"
                        style="background: #e53e3e; border: none;">Log Out</a>
                </div>
            </div>
        </main>

        <script src="${pageContext.request.contextPath}/js/theme.js"></script>
        <script src="${pageContext.request.contextPath}/js/animations.js"></script>
    </body>

    </html>