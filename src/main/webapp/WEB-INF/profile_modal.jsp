<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <div id="profile-modal" class="profile-modal-overlay">
            <div class="profile-modal-content reveal-zoom">
                <button id="close-profile" class="close-modal-btn">&times;</button>

                <div class="profile-header-section">
                    <h1>Good Evening,
                        <c:out value="${not empty sessionScope.user.name ? sessionScope.user.name : 'Guest'}" />.
                    </h1>
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

                <c:if test="${not empty sessionScope.user}">
                    <div class="logout-section"
                        style="margin-top: 1.5rem; text-align: right; display: flex; flex-direction: column; align-items: flex-end; gap: 0.5rem;">
                        <p style="margin: 0; font-size: 0.9rem;">Logged in as: <strong>
                                <c:out value="${sessionScope.user.email}" />
                            </strong></p>

                        <div class="security-settings"
                            style="width: 100%; border-top: 1px solid #edf2f7; padding-top: 0.75rem; margin-top: 0.75rem; text-align: left;">
                            <h4 style="margin-bottom: 0.5rem; font-size: 1rem; color: var(--text-color);">Security & 2FA
                            </h4>
                            <div
                                style="display: flex; flex-direction: column; gap: 1rem; background: #f8fafc; padding: 1.5rem; border-radius: 16px; border: 1px solid #e2e8f0;">

                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <p style="margin: 0; font-weight: 600; font-size: 0.9rem;">Two-Factor
                                            Authentication</p>
                                        <p style="margin: 0; font-size: 0.8rem; color: var(--text-light);">
                                            Status: ${sessionScope.user.twoFactorEnabled ? '<span
                                                style="color: #48bb78; font-weight: 700;">Enabled</span>' :
                                            '<span style="color: #e53e3e; font-weight: 700;">Disabled</span>'}
                                        </p>
                                    </div>
                                    <c:choose>
                                        <c:when test="${sessionScope.user.twoFactorEnabled}">
                                            <form action="${pageContext.request.contextPath}/auth" method="post"
                                                style="margin: 0;">
                                                <input type="hidden" name="action" value="toggle2FA">
                                                <input type="hidden" name="enable" value="false">
                                                <button type="submit" class="btn"
                                                    style="padding: 0.5rem 1rem; font-size: 0.8rem; border-radius: 100px; background: #fee2e2; color: #b91c1c; border: none; cursor: pointer; font-weight: 600; transition: all 0.2s;">
                                                    Disable 2FA
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/auth" method="post"
                                                style="margin: 0;">
                                                <input type="hidden" name="action" value="toggle2FA">
                                                <input type="hidden" name="enable" value="true">
                                                <button type="submit" class="btn"
                                                    style="padding: 0.5rem 1rem; font-size: 0.8rem; border-radius: 100px; background: var(--secondary-color); color: white; border: none; cursor: pointer; font-weight: 600; transition: all 0.2s;">
                                                    ${not empty sessionScope.user.twoFactorSecret ? 'Reset Secret' :
                                                    'Setup
                                                    2FA'}
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <c:if
                                    test="${not sessionScope.user.twoFactorEnabled and not empty sessionScope.user.twoFactorSecret}">
                                    <div
                                        style="margin-top: 0.5rem; padding: 0.75rem; background: white; border-radius: 12px; border: 1px dashed var(--secondary-color);">
                                        <p style="margin-bottom: 0.5rem; font-size: 0.8rem; color: var(--text-color);">
                                            1. Add this secret to your authenticator app (e.g. Google Authenticator):
                                        </p>
                                        <div
                                            style="display: flex; align-items: center; justify-content: center; gap: 10px; margin-bottom: 0.75rem;">
                                            <code
                                                style="background: #f1f5f9; padding: 0.4rem 0.75rem; border-radius: 8px; font-weight: 700; font-size: 1rem; letter-spacing: 1px; color: var(--primary-dark); border: 1px solid #e2e8f0;">
                                            ${sessionScope.user.twoFactorSecret}
                                        </code>
                                        </div>
                                        <p style="margin-bottom: 0.5rem; font-size: 0.8rem; color: var(--text-color);">
                                            2. Enter the 6-digit code to verify and enable:
                                        </p>
                                        <form action="${pageContext.request.contextPath}/auth" method="post"
                                            style="display: flex; gap: 8px;">
                                            <input type="hidden" name="action" value="verifyAndEnable2FA">
                                            <input type="text" name="code" placeholder="000000" maxlength="6" required
                                                style="flex: 1; padding: 0.5rem; border-radius: 8px; border: 1px solid #e2e8f0; font-family: monospace; font-size: 0.9rem; text-align: center; letter-spacing: 2px;">
                                            <button type="submit" class="btn"
                                                style="padding: 0.5rem 1rem; background: var(--primary-dark); color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 0.85rem;">
                                                Verify & Enable
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                            <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-primary"
                                style="background: #e53e3e; border: none; padding: 0.6rem 1.2rem; border-radius: 100px; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600;">Log
                                Out</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>