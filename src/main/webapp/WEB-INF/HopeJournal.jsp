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
                 <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </div>
        </div>
    </nav>

    <main>
        <div class="hope-hero reveal reveal-up">
            <span class="hope-badge">The Sanctuary</span>
            <h1>A living timeline of faith.</h1>
            <p>Leave a timestamp in time of what you want God to do, then return to share your testimony.</p>
            
            <div class="hope-actions">
                <button class="btn-release" onclick="toggleModal('release-modal')">Release a Hope</button>
                <button class="btn btn-outline" style="border-radius: 30px; font-weight: 700; padding: 12px 30px;" onclick="toggleModal('revisit-modal')">Revisit Yours</button>
            </div>
        </div>

        <section class="hope-stream">
            <c:forEach var="hope" items="${publicHopes}" varStatus="status">
                <div class="hope-card reveal reveal-scale card-${hope.emotion}" 
                     data-content="${fn:escapeXml(hope.content)}"
                     data-date="${hope.timestamp.toLocalDate()}"
                     data-id="${hope.id}"
                     data-emotion="${hope.emotion}"
                     data-comfort="${hope.comfortCount}"
                     data-support="${hope.supportCount}"
                     data-hug="${hope.hugCount}"
                     onclick="viewHope(this)">
                    <div class="card-index">Hope 0${status.index + 1}</div>
                    <h3 style="font-size: 1rem;">${fn:substring(hope.content, 0, 15)}...</h3>
                    <p style="font-size: 0.85rem;">"${fn:substring(hope.content, 0, 80)}${fn:length(hope.content) > 80 ? '...' : ''}"</p>
                    <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(0,0,0,0.05); padding-top: 10px;">
                        <span style="font-size: 0.7rem; color: var(--hope-text-light); font-weight: 700;">${hope.timestamp.toLocalDate()}</span>
                        <div style="display: flex; gap: 8px; font-size: 0.7rem; opacity: 0.7;">
                            <span>❤️ ${hope.comfortCount + hope.supportCount + hope.hugCount}</span>
                        </div>
                    </div>
                    <!-- Hidden testimonies for JS to pick up -->
                    <div class="hidden-updates" style="display: none;">
                        <c:forEach var="update" items="${hope.updates}">
                            <div class="update-item" data-date="${update.timestamp.toLocalDate()}" data-text="${fn:escapeXml(not empty update.testimony ? update.testimony : 'A silent testimony...')}"></div>
                        </c:forEach>
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
            <h2>How do you feel?</h2>
            <form action="${pageContext.request.contextPath}/hope" method="post">
                <input type="hidden" name="action" value="release">
                
                <div class="emotion-grid">
                    <label class="emotion-item">
                        <input type="radio" name="emotion" value="SAD">
                        <span class="emotion-icon"><small>Sadness</small></span>
                    </label>
                    <label class="emotion-item">
                        <input type="radio" name="emotion" value="ANGRY">
                        <span class="emotion-icon"><small>Anger</small></span>
                    </label>
                    <label class="emotion-item">
                        <input type="radio" name="emotion" value="SCARED">
                        <span class="emotion-icon"><small>Fear</small></span>
                    </label>
                    <label class="emotion-item">
                        <input type="radio" name="emotion" value="HOPEFUL" checked>
                        <span class="emotion-icon"><small>Hopeful</small></span>
                    </label>
                </div>

                <textarea name="content" class="form-control" style="min-height: 150px;" placeholder="What are you trusting God for today? Or what is on your heart?" required></textarea>
                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 2rem;">
                    <input type="checkbox" name="isPublic" id="isPublic" checked style="width: 20px; height: 20px;">
                    <label for="isPublic" style="font-size: 0.95rem; color: var(--hope-text-light);">Share anonymously to receive comfort</label>
                </div>
                <button type="submit" class="btn-release">Seal & Release</button>
            </form>
        </div>
    </div>

    <!-- Revisit Modal -->
    <div id="revisit-modal" class="hope-modal">
        <div class="modal-content" style="text-align: center;">
            <button style="position: absolute; top: 20px; right: 20px; background: none; border: none; font-size: 1.5rem;" onclick="toggleModal('revisit-modal')">×</button>
            <h2>Return to your journal.</h2>
            <p style="margin-bottom: 2rem;">Enter your 8-character secret key to unlock your dedicated journey page.</p>
            <form action="${pageContext.request.contextPath}/hope/journey" method="get">
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
            
            <div id="reaction-prompt" style="margin-top: 2rem; border-top: 1px solid #f1f5f9; padding-top: 2rem;">
                <p style="font-size: 0.9rem; color: var(--hope-text-light); margin-bottom: 1rem;">Offer a moment of comfort:</p>
                <div class="reaction-strip">
                    <form action="${pageContext.request.contextPath}/hope" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="react">
                        <input type="hidden" name="type" value="comfort">
                        <input type="hidden" name="id" id="view-id-comfort">
                        <button type="submit" class="btn-react"><small>Comfort</small> <span id="count-comfort"></span></button>
                    </form>
                    <form action="${pageContext.request.contextPath}/hope" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="react">
                        <input type="hidden" name="type" value="support">
                        <input type="hidden" name="id" id="view-id-support">
                        <button type="submit" class="btn-react"><small>Strength</small> <span id="count-support"></span></button>
                    </form>
                    <form action="${pageContext.request.contextPath}/hope" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="react">
                        <input type="hidden" name="type" value="hug">
                        <input type="hidden" name="id" id="view-id-hug">
                        <button type="submit" class="btn-react"><small>Care</small> <span id="count-hug"></span></button>
                    </form>
                </div>
            </div>

            <!-- Testimonies Section -->
            <div id="modal-testimonies" style="margin-top: 2rem; border-top: 1px solid #f1f5f9; padding-top: 2rem; text-align: left; display: none;">
                <h4 style="font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; color: var(--hope-accent); margin-bottom: 1.5rem;">The Testimony Timeline</h4>
                <div id="testimonies-list"></div>
            </div>
        </div>
    </div>

    <!-- Key Success Modal -->
    <div id="key-modal" class="hope-modal">
        <div class="key-master-popup reveal reveal-scale">
            <h2 style="color: white; margin-bottom: 1rem;">Hope Sealed.</h2>
            <p style="color: #a0aec0; font-size: 0.9rem;">Your journey has been preserved in the sanctuary. Use this key to return hand-in-hand with your past self.</p>
            <div class="key-display">
                <span id="final-key">XXXXXX</span>
                <button class="btn-copy" onclick="copyKey()">Copy</button>
            </div>
            <button class="btn-release" onclick="toggleModal('key-modal')" style="width: 100%;">Enter the Sanctuary</button>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/animations.js"></script>
    <script>
        function toggleModal(id) {
            document.getElementById(id).classList.toggle('active');
        }

        function viewHope(card) {
            const content = card.getAttribute('data-content');
            const date = card.getAttribute('data-date');
            const id = card.getAttribute('data-id');
            const emotion = card.getAttribute('data-emotion');
            const comfort = card.getAttribute('data-comfort');
            const support = card.getAttribute('data-support');
            const hug = card.getAttribute('data-hug');

            document.getElementById('view-content').innerText = "\"" + content + "\"";
            document.getElementById('view-date').innerText = "Released " + date + " • Feeling " + emotion;
            document.getElementById('view-id-comfort').value = id;
            document.getElementById('view-id-support').value = id;
            document.getElementById('view-id-hug').value = id;
            
            document.getElementById('count-comfort').innerText = comfort;
            document.getElementById('count-support').innerText = support;
            document.getElementById('count-hug').innerText = hug;

            // Handle Testimonies
            const updatesDiv = card.querySelector('.hidden-updates');
            const list = document.getElementById('testimonies-list');
            const section = document.getElementById('modal-testimonies');
            list.innerHTML = '';
            
            if (updatesDiv && updatesDiv.children.length > 0) {
                Array.from(updatesDiv.children).forEach(upd => {
                    const item = document.createElement('div');
                    item.className = 'modal-update-item';
                    item.innerHTML = `<span class="update-date">${upd.getAttribute('data-date')}</span><p>${upd.getAttribute('data-text')}</p>`;
                    list.appendChild(item);
                });
                section.style.display = 'block';
            } else {
                section.style.display = 'none';
            }
            
            toggleModal('view-modal');
        }

        function copyKey() {
            var keyText = document.getElementById('final-key').innerText;
            navigator.clipboard.writeText(keyText).then(function() {
                var btn = document.querySelector('.btn-copy');
                btn.innerText = "Copied!";
                setTimeout(function() { btn.innerText = "Copy"; }, 2000);
            });
        }

        // Handle the Key Display after submission
        var rawKey = '<c:out value="${newHopeKey}" />';
        if (rawKey && rawKey.trim() !== "") {
            window.addEventListener('load', function() {
                document.getElementById('final-key').innerText = rawKey;
                toggleModal('key-modal');
            });
        }
    </script>
    <% session.removeAttribute("newHopeKey"); %>
    <jsp:include page="toast_component.jsp" />
</body>
</html>
