<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>BlogNest - Login</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary-color: #000000;
                    /* Black for BlogNest */
                    --primary-dark: #1a1a1a;
                    --secondary-color: #38b2ac;
                    /* Original teal for accents */
                    --text-color: #2d3748;
                    --text-light: #718096;
                    --bg-light: #f7fafc;
                    --white: #ffffff;
                    --shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    --header-bg: transparent;
                }

                .dark-theme {
                    --primary-color: #ffffff;
                    /* White for BlogNest */
                    --primary-dark: #f0f0f0;
                    --secondary-color: #4fd1c5;
                    --text-color: #f7fafc;
                    --text-light: #cbd5e0;
                    --bg-light: #1a202c;
                    --white: #2d3748;
                    --shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                input,
                button,
                textarea,
                select {
                    font-family: inherit;
                }

                body {
                    font-family: 'Outfit', 'Jost', sans-serif;
                    background: var(--bg-light);
                    color: var(--text-color);
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    transition: background-color 0.5s ease, color 0.5s ease;
                }

                /* Navbar */
                .navbar {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 2.5rem 5%;
                    width: 100%;
                    z-index: 10;
                }

                .logo-text {
                    font-size: 1.8rem;
                    font-weight: 700;
                    color: var(--primary-dark);
                    letter-spacing: -0.5px;
                }

                .header-actions {
                    display: flex;
                    gap: 1.5rem;
                    align-items: center;
                }

                .btn-icon {
                    background: var(--white);
                    border: none;
                    color: var(--text-color);
                    width: 45px;
                    height: 45px;
                    border-radius: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    box-shadow: var(--shadow);
                    transition: var(--transition);
                }

                .btn-icon:hover {
                    transform: translateY(-2px);
                    color: var(--primary-color);
                }

                /* Main Container */
                .container {
                    flex: 1;
                    display: flex;
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 2rem 5%;
                    align-items: center;
                    gap: 4rem;
                }

                /* Login Section */
                .login-section {
                    flex: 1;
                    max-width: 450px;
                }

                .header-tabs {
                    display: flex;
                    gap: 2rem;
                    margin-bottom: 3rem;
                }

                .tab {
                    background: none;
                    border: none;
                    font-size: 1.8rem;
                    font-weight: 600;
                    color: #e2e8f0;
                    cursor: pointer;
                    position: relative;
                    padding-bottom: 0.5rem;
                    transition: var(--transition);
                }

                .tab.active {
                    color: var(--secondary-color);
                }

                .tab.active::after {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    width: 60%;
                    height: 4px;
                    background-color: var(--secondary-color);
                    border-radius: 2px;
                }

                .auth-form {
                    display: flex;
                    flex-direction: column;
                    gap: 1.5rem;
                }

                .auth-form.hidden {
                    display: none;
                }

                .input-group {
                    position: relative;
                    display: flex;
                    align-items: center;
                }

                .input-group .icon {
                    position: absolute;
                    left: 1.2rem;
                    color: var(--secondary-color);
                    opacity: 0.7;
                }

                .input-group input {
                    width: 100%;
                    padding: 1rem 1.2rem 1rem 3.5rem;
                    border: 1px solid #edf2f7;
                    border-radius: 100px;
                    background: var(--white);
                    font-size: 1rem;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.02);
                    transition: var(--transition);
                    outline: none;
                    color: var(--text-color);
                }

                .input-group input::placeholder {
                    color: #cbd5e0;
                }

                .input-group input:focus {
                    border-color: var(--secondary-color);
                    box-shadow: 0 4px 15px rgba(56, 178, 172, 0.1);
                }

                .form-footer {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 1.5rem;
                    margin-top: 2rem;
                    width: 100%;
                }

                .forgot-link {
                    font-size: 0.95rem;
                    color: var(--text-light);
                    text-decoration: none;
                    transition: var(--transition);
                    order: 1;
                }

                .btn-login {
                    background: var(--secondary-color);
                    color: white;
                    border: none;
                    padding: 0.9rem 4rem;
                    border-radius: 100px;
                    font-size: 1.1rem;
                    font-weight: 500;
                    cursor: pointer;
                    transition: var(--transition);
                    box-shadow: 0 4px 15px rgba(56, 178, 172, 0.3);
                    order: 2;
                    min-width: 180px;
                }

                .btn-login:hover {
                    background: var(--primary-dark);
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(56, 178, 172, 0.4);
                }

                /* Illustration Section */
                .illustration-section {
                    flex: 1.2;
                    position: relative;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .blob-bg {
                    position: absolute;
                    width: 600px;
                    height: 600px;
                    background: radial-gradient(circle, rgba(56, 178, 172, 0.2) 0%, rgba(56, 178, 172, 0.7) 100%);
                    border-radius: 40% 60% 70% 30% / 40% 50% 60% 50%;
                    z-index: -1;
                    right: -100px;
                    top: -100px;
                    filter: blur(20px);
                    animation: blobMorph 15s infinite alternate ease-in-out;
                    transition: background 0.5s ease;
                }

                .dark-theme .blob-bg {
                    background: radial-gradient(circle, rgba(79, 209, 197, 0.1) 0%, rgba(79, 209, 197, 0.4) 100%);
                }

                .hero-img {
                    max-width: 100%;
                    height: auto;
                    filter: drop-shadow(0 10px 30px rgba(0, 0, 0, 0.1));
                }

                @keyframes blobMorph {
                    0% {
                        border-radius: 40% 60% 70% 30% / 40% 50% 60% 50%;
                    }

                    100% {
                        border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%;
                    }
                }

                /* Responsive Design */
                @media (max-width: 992px) {
                    .container {
                        flex-direction: column-reverse;
                        gap: 3rem;
                        text-align: center;
                    }

                    .login-section {
                        max-width: 100%;
                        width: 100%;
                    }

                    .header-tabs {
                        justify-content: center;
                    }

                    .blob-bg {
                        width: 100%;
                        height: 100%;
                        right: 0;
                    }
                }

                /* Reveal Animations */
                .reveal {
                    opacity: 0;
                    transition: all 0.8s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .reveal-up {
                    transform: translateY(30px);
                }

                .reveal-left {
                    transform: translateX(-30px);
                }

                .reveal-right {
                    transform: translateX(30px);
                }

                .reveal.active {
                    opacity: 1;
                    transform: translate(0, 0);
                }

                .delay-100 {
                    transition-delay: 100ms;
                }

                .delay-200 {
                    transition-delay: 200ms;
                }

                /* Alerts */
                .alert {
                    padding: 1rem 1.5rem;
                    border-radius: 12px;
                    margin-bottom: 2rem;
                    font-size: 0.95rem;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    animation: slideInDown 0.4s ease;
                }

                .alert-error {
                    background: #fff5f5;
                    color: #c53030;
                    border: 1px solid #feb2b2;
                }

                .alert-success {
                    background: #f0fff4;
                    color: #276749;
                    border: 1px solid #9ae6b4;
                }

                @keyframes slideInDown {
                    from {
                        transform: translateY(-10px);
                        opacity: 0;
                    }

                    to {
                        transform: translateY(0);
                        opacity: 1;
                    }
                }
            </style>
        </head>

        <body>
            <header class="navbar">
                <div class="logo">
                    <span class="logo-text"><a href="${pageContext.request.contextPath}/blog"
                            style="text-decoration: none;   color: inherit; ">BlogNest</a></span>
                </div>
                <div class="header-actions">
                    <button id="theme-toggle" class="btn-icon">
                        <svg id="moon-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                        </svg>
                        <svg id="sun-icon" style="display:none;" width="24" height="24" viewBox="0 0 24 24" fill="none"
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
                    </button>
                </div>
            </header>

            <main class="container">
                <div class="login-section reveal reveal-left">
                    <div class="header-tabs">
                        <button class="tab active" id="tab-login">Login</button>
                        <button class="tab" id="tab-signup">Sign up</button>
                    </div>

                    <!-- Alerts -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                            </svg>
                            <c:out value="${error}" />
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                <polyline points="22 4 12 14.01 9 11.01"></polyline>
                            </svg>
                            <c:out value="${success}" />
                        </div>
                    </c:if>

                    <!-- Login Form -->
                    <form id="login-form" class="auth-form reveal reveal-up delay-100" action="auth" method="post">
                        <div class="input-group">
                            <span class="icon">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path
                                        d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                                    </path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                            </span>
                            <input type="email" name="email" placeholder="Email Address" required>
                        </div>

                        <div class="input-group">
                            <span class="icon">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                            </span>
                            <input type="password" name="password" placeholder="Password" required>
                        </div>

                        <div class="form-footer">
                            <a href="#" class="forgot-pass" style="text-decoration: none; color: transparent">Forgot
                                Password?</a>
                            <button type="submit" name="action" value="login" class="btn-login">Login</button>
                        </div>
                    </form>

                    <!-- Signup Form -->
                    <form id="signup-form" class="auth-form hidden reveal reveal-up delay-100" action="auth"
                        method="post">
                        <div class="input-group">
                            <span class="icon">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </span>
                            <input type="text" name="name" placeholder="Full Name" required>
                        </div>

                        <div class="input-group">
                            <span class="icon">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path
                                        d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                                    </path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                            </span>
                            <input type="email" name="email" placeholder="Email Address" required>
                        </div>

                        <div class="input-group">
                            <span class="icon">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                            </span>
                            <input type="password" name="password" placeholder="Password" required>
                        </div>

                        <div class="form-footer">
                            <button type="submit" name="action" value="register" class="btn-login">Sign up</button>
                        </div>
                    </form>
                </div>

                <div class="illustration-section reveal reveal-right delay-200">
                    <div class="blob-bg"></div>
                    <img src="images/Signup.png" alt="Login Illustration" class="hero-img">
                </div>
            </main>

            <script src="${pageContext.request.contextPath}/js/theme.js"></script>
            <script src="${pageContext.request.contextPath}/js/animations.js"></script>
            <script>
                const tabs = document.querySelectorAll('.tab');
                const loginForm = document.getElementById('login-form');
                const signupForm = document.getElementById('signup-form');

                tabs.forEach(tab => {
                    tab.addEventListener('click', () => {
                        const isLogin = tab.id === 'tab-login';
                        setActiveTab(isLogin);
                    });
                });

                function setActiveTab(isLogin) {
                    tabs.forEach(t => t.classList.remove('active'));
                    if (isLogin) {
                        document.getElementById('tab-login').classList.add('active');
                        loginForm.classList.remove('hidden');
                        signupForm.classList.add('hidden');
                        setTimeout(() => loginForm.classList.add('active'), 10);
                    } else {
                        document.getElementById('tab-signup').classList.add('active');
                        loginForm.classList.add('hidden');
                        signupForm.classList.remove('hidden');
                        setTimeout(() => signupForm.classList.add('active'), 10);
                    }
                }

                // Handle server-side redirection to tab
                <c:if test="${isSignup}">
                    setActiveTab(false);
                </c:if>
            </script>
        </body>

        </html>