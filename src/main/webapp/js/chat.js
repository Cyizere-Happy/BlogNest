(function () {
    let socket = null;
    let username = window.chatUser || 'Guest';
    if (username === 'Guest') return; // Extra safety

    const widget = document.createElement('div');
    widget.className = 'chat-widget-container';
    widget.innerHTML = `
        <div class="chat-bubble-toggle" id="chatToggle">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
        </div>
        <div class="chat-window" id="chatWindow">
            <div class="chat-header">
                <div class="admin-info">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=38b2ac&color=fff" class="admin-avatar">
                    <div class="admin-name-status">
                        <h4>Admin</h4>
                        <span>Online</span>
                    </div>
                </div>
                <div class="close-chat" id="closeChat">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </div>
            </div>
            <div class="chat-tabs">
                <div class="chat-tab">FAQs</div>
                <div class="chat-tab active">Messages</div>
            </div>
            <div class="chat-body" id="chatBody">
                <div class="message-bubble admin">Hi there! How can I help you today?</div>
            </div>
            <div class="chat-footer">
                <input type="text" class="chat-input" id="chatInput" placeholder="Type a message...">
                <button class="send-btn" id="sendBtn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                </button>
            </div>
        </div>
    `;
    document.body.appendChild(widget);

    const toggle = document.getElementById('chatToggle');
    const windowEl = document.getElementById('chatWindow');
    const closeBtn = document.getElementById('closeChat');
    const input = document.getElementById('chatInput');
    const sendBtn = document.getElementById('sendBtn');
    const body = document.getElementById('chatBody');

    toggle.onclick = () => {
        windowEl.classList.add('active');
        connectWS();
    };
    closeBtn.onclick = () => windowEl.classList.remove('active');

    function connectWS() {
        if (socket && socket.readyState === WebSocket.OPEN) return;

        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const context = window.contextPath || '';
        socket = new WebSocket(`${protocol}//${window.location.host}${context}/chat/${encodeURIComponent(username)}`);

        socket.onopen = () => {
            console.log("Chat connected as " + username);
            appendMsg("You are now connected.", "system");
        };

        socket.onclose = () => {
            appendMsg("Chat disconnected.", "system");
            socket = null;
        };

        socket.onmessage = (event) => {
            console.log("Chat message received:", event.data);
            const msg = JSON.parse(event.data);
            if (msg.type === 'CHAT') {
                // Determine if it's from Admin or me (history can send my own messages back)
                const type = msg.sender === username ? 'user' : 'admin';
                appendMsg(msg.content, type);
            }
        };
    }

    function sendMessage() {
        const text = input.value.trim();
        if (!text) return;

        if (!socket || socket.readyState !== WebSocket.OPEN) {
            appendMsg("Connection lost. Reconnecting...", "system");
            connectWS();
            setTimeout(() => {
                if (socket && socket.readyState === WebSocket.OPEN) sendMessage();
            }, 1000);
            return;
        }

        const msg = {
            sender: username,
            recipient: 'Admin',
            content: text,
            type: 'CHAT'
        };

        socket.send(JSON.stringify(msg));
        appendMsg(text, 'user');
        input.value = '';
    }

    function appendMsg(text, sender) {
        // Clear the hardcoded welcome message if it's the first actual message
        if (body.children.length === 1 && body.firstElementChild.classList.contains('admin') && body.firstElementChild.innerText.includes('Hi there!')) {
            body.innerHTML = '';
        }

        const div = document.createElement('div');
        div.className = `message-bubble ${sender}`;
        if (sender === 'system') {
            div.style.alignSelf = 'center';
            div.style.fontSize = '0.75rem';
            div.style.background = '#f1f5f9';
            div.style.color = '#64748b';
            div.style.padding = '4px 10px';
            div.style.borderRadius = '20px';
            div.style.margin = '10px 0';
        }
        div.innerText = text;
        body.appendChild(div);
        body.scrollTop = body.scrollHeight;
    }

    sendBtn.onclick = sendMessage;
    input.onkeypress = (e) => { if (e.key === 'Enter') sendMessage(); };
})();
