<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlogNest - Stories</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/blogs.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
</head>

<body class="blog-body">
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
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
        </div>
    </div>
</nav>

<main class="blog-container">
    <section class="discovery-header">
        <span class="discovery-label">EXCLUSIVE DISCOVERY</span>
        <h1 class="discovery-title">Discovery</h1>
    </section>

    <section class="marquee-section">
        <div class="marquee-container">
            <div class="marquee-track">
                <!-- Original Set of Cards -->
                <!-- Card 1 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #f7fafc;"></div>
                        <div class="thumb-img" style="background-color: #cbd5e0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Designing for Humans</h3>
                        <p>Exploring the intersection of aesthetics and usability in digital products.</p>
                        <a href="${pageContext.request.contextPath}/ReadBlog" style="text-decoration: none;   color: inherit;" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #edf2f7;"></div>
                        <div class="thumb-img" style="background-color: #a0aec0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>The Code Chronicles</h3>
                        <p>My journey through full-stack development and the lessons learned along the way.</p>
                        <a href="${pageContext.request.contextPath}/ReadBlog" style="text-decoration: none;   color: inherit;" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #e2e8f0;"></div>
                        <div class="thumb-img" style="background-color: #718096;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Visual Storytelling</h3>
                        <p>How to craft immersive narratives through visual design and creative direction.</p>
                        <a href="${pageContext.request.contextPath}/ReadBlog" style="text-decoration: none;   color: inherit;" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 4 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #f7fafc;"></div>
                        <div class="thumb-img" style="background-color: #cbd5e0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Life in Techno-Color</h3>
                        <p>Reflections on creativity, technology, and the future of digital art.</p>
                        <a href="${pageContext.request.contextPath}/ReadBlog" style="text-decoration: none;   color: inherit;" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Duplicate Set for Infinite Loop (smooth scroll) -->
                <!-- Card 1 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #f7fafc;"></div>
                        <div class="thumb-img" style="background-color: #cbd5e0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Designing for Humans</h3>
                        <p>Exploring the intersection of aesthetics and usability in digital products.</p>
                        <a href="#" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #edf2f7;"></div>
                        <div class="thumb-img" style="background-color: #a0aec0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>The Code Chronicles</h3>
                        <p>My journey through full-stack development and the lessons learned along the way.</p>
                        <a href="#" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #e2e8f0;"></div>
                        <div class="thumb-img" style="background-color: #718096;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Visual Storytelling</h3>
                        <p>How to craft immersive narratives through visual design and creative direction.</p>
                        <a href="#" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>

                <!-- Card 4 -->
                <div class="discovery-card">
                    <div class="card-visuals">
                        <div class="main-img" style="background-color: #f7fafc;"></div>
                        <div class="thumb-img" style="background-color: #cbd5e0;"></div>
                    </div>
                    <div class="card-info">
                        <h3>Life in Techno-Color</h3>
                        <p>Reflections on creativity, technology, and the future of digital art.</p>
                        <a href="#" class="read-more">Read Story &rarr;</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about-section">
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

<script>
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