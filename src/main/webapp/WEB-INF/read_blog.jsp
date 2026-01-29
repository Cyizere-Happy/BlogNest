<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Designing for Humans - BlogNest</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/blogs.css"> <!-- For shared blog-body split background -->
    <link rel="stylesheet" href="css/read_blog.css"> <!-- Specific Layout Styles -->
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
        <div class="nav-logo"><a href="${pageContext.request.contextPath}/blog" style="text-decoration: none;   color: inherit;">BlogNest</a></div>
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
            <!-- User Icon -->
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
        </div>
    </div>
</nav>

<div class="read-blog-container">
    <!-- Column 1: Main Hero Image -->
    <div class="hero-column">
        <div class="article-hero-img" style="background-color: #e2e8f0;">
            <!-- Placeholder for actual image -->
        </div>
    </div>

    <!-- Column 2: Main Content -->
    <main class="article-content">
        <header class="article-header">
            <span class="article-category">Design & Tech</span>
            <h1 class="article-title">Designing for Humans in a Digital World</h1>

            <!-- Metadata Grid -->
            <!-- Metadata Grid -->
            <div class="meta-grid">
                <div class="meta-item">
                    <h4>Published</h4>
                    <p>May 2026</p>
                </div>
                <div class="meta-item">
                    <h4>Written By</h4>
                    <p>Cyizere Happy</p>
                </div>
                <div class="meta-item">
                    <h4>Reading Time</h4>
                    <p>5 Minutes</p>
                </div>
            </div>
        </header>

        <!-- Article Body -->
        <article class="article-body">
            <p>Diminutive rooms, grand possibilities. Small Homes, Grand Living shows how to make use of a limited
                space and turn a small apartment into a design marvel.</p>

            <h3>The Essence of Less</h3>
            <p>Here anthropologist David Graeber presents a stunning reversal of conventional wisdom: he shows that
                before there was money, there was debt. For more than 5,000 years, since the beginnings of the first
                agrarian empires, humans have used elaborate credit systems to buy and sell goods—that is, long
                before the invention of coins or cash.</p>

            <p>Digital interfaces are no different. In a world clamoring for attention, the designs that respect our
                time and mental space are the ones that truly connect.</p>
        </article>

        <!-- Comments Section -->
        <section class="comments-section">
            <h3 class="comments-title">Join the Conversation</h3>
            <form class="comment-form">
                <textarea placeholder="Share your thoughts..."></textarea>
                <button type="submit" class="btn btn-primary">Post Comment</button>
            </form>
        </section>
    </main>

    <!-- Right Sidebar (Bookshelf) -->
    <aside class="blog-sidebar">
        <span class="sidebar-label">More Stories</span>
        <div class="sidebar-list">
            <div class="sidebar-item">
                <div class="sidebar-thumb" style="background-color: #38b2ac;"></div>
                <div class="sidebar-title">The Code Chronicles</div>
            </div>
            <div class="sidebar-item">
                <div class="sidebar-thumb" style="background-color: #2d3748;"></div>
                <div class="sidebar-title">Visual Storytelling</div>
            </div>
            <div class="sidebar-item">
                <div class="sidebar-thumb" style="background-color: #81e6d9;"></div>
                <div class="sidebar-title">Life in Techno-Color</div>
            </div>
        </div>
    </aside>
</div>

<script>
    // Shared Theme Script
    const themeToggle = document.getElementById('theme-toggle');
    const sunIcon = document.getElementById('sun-icon');
    const moonIcon = document.getElementById('moon-icon');

    themeToggle.addEventListener('click', () => {
        document.body.classList.toggle('dark-theme');
        if (document.body.classList.contains('dark-theme')) {
            sunIcon.style.display = 'block';
            moonIcon.style.display = 'none';
        } else {
            sunIcon.style.display = 'none';
            moonIcon.style.display = 'block';
        }
    });
</script>
</body>

</html>
