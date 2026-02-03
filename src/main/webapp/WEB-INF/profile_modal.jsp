<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div id="profile-modal" class="profile-modal-overlay">
        <div class="profile-modal-content reveal-zoom">
            <button id="close-profile" class="close-modal-btn">&times;</button>

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

            <div class="logout-section"
                style="margin-top: 2rem; text-align: right; display: flex; flex-direction: column; align-items: flex-end; gap: 1rem;">
                <p style="margin: 0;">Logged in as: <strong>${user.email}</strong></p>
                <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-primary"
                    style="background: #e53e3e; border: none;">Log Out</a>
            </div>
        </div>
    </div>