<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>404 - Page Not Found | BlogNest</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #38b2ac;
                --bg: #ffffff;
                --text: #1a202c;
                --wall: #f1f5f9;
                --wall-shadow: rgba(0, 0, 0, 0.05);
                --num-color: rgba(56, 178, 172, 0.15);
                --floor: #f8fafc;
                --hole-bg: #cbd5e0;
            }

            .dark-theme {
                --bg: #000000;
                --text: #ffffff;
                --wall: #121212;
                --wall-shadow: rgba(255, 255, 255, 0.03);
                --num-color: rgba(56, 178, 172, 0.3);
                --floor: #050505;
                --hole-bg: #111111;
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
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                perspective: 2000px;
                transition: background-color 0.5s ease;
            }

            .scene {
                position: relative;
                width: 100%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                transform-style: preserve-3d;
            }

            .room {
                position: relative;
                width: 1000px;
                height: 800px;
                transform-style: preserve-3d;
                transform: rotateX(-15deg) rotateY(-20deg);
                animation: room-float 8s ease-in-out infinite;
            }

            /* Walls */
            .wall {
                position: absolute;
                background: var(--wall);
                border: 1px solid var(--wall-shadow);
                display: flex;
                align-items: center;
                justify-content: center;
                backface-visibility: visible;
            }

            .wall-left {
                width: 600px;
                height: 800px;
                left: 0;
                transform: rotateY(45deg) translateZ(-300px) translateX(-150px);
                background: linear-gradient(135deg, var(--wall) 0%, var(--bg) 100%);
                pointer-events: none;
            }

            .wall-back {
                width: 800px;
                height: 800px;
                left: 100px;
                transform: translateZ(-400px);
                background: linear-gradient(to bottom, var(--wall), var(--bg));
                pointer-events: none;
            }

            .wall-right {
                width: 600px;
                height: 800px;
                right: 0;
                transform: rotateY(-45deg) translateZ(-300px) translateX(150px);
                background: linear-gradient(-135deg, var(--wall) 0%, var(--bg) 100%);
                pointer-events: none;
            }

            .floor {
                width: 1200px;
                height: 1000px;
                background: var(--floor);
                transform: rotateX(90deg) translateZ(-400px) translateX(-100px);
                background: radial-gradient(circle at center, var(--wall) 0%, var(--floor) 80%);
                pointer-events: none;
            }

            /* 3D Text */
            .number-404 {
                position: absolute;
                font-size: 350px;
                font-weight: 900;
                color: var(--num-color);
                pointer-events: none;
                text-shadow: 0 0 40px rgba(56, 178, 172, 0.1);
                user-select: none;
            }

            .num-1 {
                transform: rotateY(0deg) translateZ(1px);
            }

            .num-2 {
                transform: rotateY(0deg) translateZ(1px);
                font-size: 450px;
            }

            .num-3 {
                transform: rotateY(0deg) translateZ(1px);
            }

            /* Hole */
            .hole {
                position: absolute;
                width: 250px;
                height: 250px;
                background: var(--hole-bg);
                border-radius: 50%;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                box-shadow: inset 0 0 80px rgba(0, 0, 0, 0.6);
            }

            .ladder {
                position: absolute;
                width: 50px;
                height: 300px;
                border-left: 5px solid #4a5568;
                border-right: 5px solid #4a5568;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -30%) rotateX(-15deg);
            }

            .ladder::after {
                content: '';
                position: absolute;
                width: 100%;
                height: 100%;
                background: repeating-linear-gradient(transparent, transparent 40px, #4a5568 40px, #4a5568 45px);
            }

            /* Content */
            .content {
                position: absolute;
                z-index: 500;
                text-align: center;
                width: 100%;
                top: 30%;
                transform: translateZ(200px);
                pointer-events: auto;
            }

            .oops {
                font-size: 5rem;
                font-weight: 800;
                letter-spacing: 1.5rem;
                margin-bottom: 1rem;
                filter: drop-shadow(0 10px 20px rgba(0, 0, 0, 0.2));
            }

            .oops span {
                color: var(--primary);
            }

            .message {
                font-size: 1.4rem;
                color: var(--text);
                opacity: 0.8;
                margin-bottom: 3rem;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.6;
            }

            .actions {
                display: flex;
                gap: 2rem;
                justify-content: center;
            }

            .btn {
                padding: 1rem 2.5rem;
                border-radius: 100px;
                text-decoration: none;
                font-weight: 700;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                text-transform: uppercase;
                font-size: 0.9rem;
                letter-spacing: 0.2rem;
            }

            .btn-primary {
                background: var(--primary);
                color: #fff;
                box-shadow: 0 10px 20px rgba(56, 178, 172, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-5px) scale(1.05);
                box-shadow: 0 15px 30px rgba(56, 178, 172, 0.4);
            }

            .btn-outline {
                border: 2px solid var(--primary);
                color: var(--primary);
                background: transparent;
            }

            .btn-outline:hover {
                background: var(--primary);
                color: #fff;
                transform: translateY(-5px) scale(1.05);
            }

            @keyframes room-float {

                0%,
                100% {
                    transform: rotateX(-15deg) rotateY(-20deg) translateY(0);
                }

                50% {
                    transform: rotateX(-12deg) rotateY(-25deg) translateY(-30px);
                }
            }

            @media (max-width: 768px) {
                .room {
                    transform: scale(0.5) rotateX(-15deg) rotateY(-20deg);
                }

                .oops {
                    font-size: 3rem;
                    letter-spacing: 0.5rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="scene">
            <div class="room">
                <!-- Left Wall with '4' -->
                <div class="wall wall-left">
                    <div class="number-404 num-1">4</div>
                </div>

                <!-- Back Wall with '0' -->
                <div class="wall wall-back">
                    <div class="number-404 num-2">0</div>
                </div>

                <!-- Right Wall with '4' -->
                <div class="wall wall-right">
                    <div class="number-404 num-3">4</div>
                </div>

                <!-- Floor -->
                <div class="wall floor">
                    <div class="hole"></div>
                    <div class="ladder"></div>
                </div>

                <!-- Content -->
                <div class="content">
                    <h1 class="oops">OO<span>PS!</span></h1>
                    <p class="message">The page you're searching for seems to have fallen through a crack in the
                        internet.</p>
                    <div class="actions">
                        <a href="${pageContext.request.contextPath}/blog" class="btn btn-primary">Back to Home</a>
                        <a href="${pageContext.request.contextPath}/stories" class="btn btn-outline">Explore Stories</a>
                    </div>
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
            setInterval(applyTheme, 1000); // Poll for changes
        </script>
    </body>

    </html>