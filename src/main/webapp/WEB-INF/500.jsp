<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>500 - Internal Server Error | BlogNest</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #f56565;
                --secondary: #38b2ac;
                --bg: #ffffff;
                --text: #1a202c;
                --card-bg: #f8fafc;
                --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }

            .dark-theme {
                --bg: #000000;
                --text: #ffffff;
                --card-bg: #121212;
                --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 10px 10px -5px rgba(0, 0, 0, 0.3);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: var(--bg);
                color: var(--text);
                font-family: 'Outfit', sans-serif;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.5s ease;
                padding: 20px;
            }

            .error-container {
                max-width: 600px;
                width: 100%;
                text-align: center;
                padding: 40px;
                background: var(--card-bg);
                border-radius: 24px;
                box-shadow: var(--shadow);
                position: relative;
                overflow: hidden;
            }

            .error-code {
                font-size: 8rem;
                font-weight: 800;
                color: var(--primary);
                opacity: 0.1;
                position: absolute;
                top: -20px;
                left: 50%;
                transform: translateX(-50%);
                z-index: 0;
                letter-spacing: 1rem;
            }

            .mascot-img {
                width: 200px;
                height: auto;
                margin-bottom: 2rem;
                position: relative;
                z-index: 1;
                filter: drop-shadow(0 10px 15px rgba(0, 0, 0, 0.1));
                animation: float 4s ease-in-out infinite;
            }

            .content {
                position: relative;
                z-index: 1;
            }

            h1 {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 1rem;
                color: var(--text);
            }

            h1 span {
                color: var(--primary);
            }

            p {
                font-size: 1.1rem;
                color: var(--text);
                opacity: 0.7;
                line-height: 1.6;
                margin-bottom: 2.5rem;
            }

            .actions {
                display: flex;
                gap: 1.5rem;
                justify-content: center;
            }

            .btn {
                padding: 0.8rem 2rem;
                border-radius: 100px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                font-size: 0.95rem;
            }

            .btn-primary {
                background: var(--secondary);
                color: #fff;
                box-shadow: 0 4px 12px rgba(56, 178, 172, 0.25);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                background: #319795;
                box-shadow: 0 6px 15px rgba(56, 178, 172, 0.35);
            }

            @keyframes float {
                0%, 100% { transform: translateY(0); }
                50% { transform: translateY(-15px); }
            }

            @media (max-width: 480px) {
                .error-container { padding: 30px 20px; }
                h1 { font-size: 2rem; }
                .error-code { font-size: 6rem; }
                .mascot-img { width: 150px; }
            }
        </style>
    </head>

    <body>
        <div class="error-container">
            <div class="error-code">500</div>
            
            <img src="${pageContext.request.contextPath}/images/Mascot3.png" alt="Mascot" class="mascot-img">

            <div class="content">
                <h1>Server <span>Error!</span></h1>
                <p>Wait! Our mascot is looking into it. Something went wrong on our side, but we'll have it fixed in a jiffy.</p>
                
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/blog" class="btn btn-primary">Back to Home</a>
                </div>
            </div>
        </div>

        <script>
            function getCookie(name) {
                const nameEQ = name + "=";
                const ca = document.cookie.split(';');
                for (let i = 0; i < ca.length; i++) {
                    let c = ca[i];
                    while (c.charAt(0) === ' ') c = c.substring(1, c.length);
                    if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
                }
                return null;
            }

            function applyTheme() {
                const theme = getCookie('theme');
                if (theme === 'dark') {
                    document.body.classList.add('dark-theme');
                } else {
                    document.body.classList.remove('dark-theme');
                }
            }

            applyTheme();
            setInterval(applyTheme, 1000);
        </script>
    </body>

    </html>
