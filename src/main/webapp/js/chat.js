(function () {
    let socket = null;

    function checkGuest() {
        const u = window.chatUser || 'Guest';
        return u === 'Guest' || !window.chatUser;
    }

    const username = window.chatUser || 'Guest';
    const isGuest = checkGuest();
    console.log("Chat initialized. User:", username, "isGuest:", isGuest);

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
                <button class="emoji-btn" id="emojiBtn" style="background: none; border: none; font-size: 1.2rem; cursor: pointer; padding: 5px;">😊</button>
                <input type="text" class="chat-input" id="chatInput" placeholder="Type a message...">
                <button class="send-btn" id="sendBtn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                </button>
            </div>
            <div id="emojiPickerContainer" style="position: absolute; bottom: 80px; right: 20px; z-index: 1000; display: none;"></div>
        </div>
    `;

    // Load Picmo Emoji Picker from CDN
    const script = document.createElement('script');
    script.src = "https://cdn.jsdelivr.net/npm/picmo@latest/dist/umd/index.js";
    document.head.appendChild(script);

    const script2 = document.createElement('script');
    script2.src = "https://cdn.jsdelivr.net/npm/@picmo/renderer-native@latest/dist/umd/index.js";
    document.head.appendChild(script2);
    document.body.appendChild(widget);

    const toggle = document.getElementById('chatToggle');
    const windowEl = document.getElementById('chatWindow');
    const closeBtn = document.getElementById('closeChat');
    const input = document.getElementById('chatInput');
    const sendBtn = document.getElementById('sendBtn');
    const body = document.getElementById('chatBody');
    const emojiBtn = document.getElementById('emojiBtn');
    const pickerContainer = document.getElementById('emojiPickerContainer');
    let picker = null;

    if (isGuest) {
        console.log("Disabling chat for guest access.");
        input.disabled = true;
        input.placeholder = "Login to join the chat...";
        sendBtn.disabled = true;
        sendBtn.style.opacity = '0.5';
        sendBtn.style.cursor = 'not-allowed';
        emojiBtn.style.pointerEvents = 'none';
        emojiBtn.style.opacity = '0.5';
    }

    emojiBtn.onclick = (e) => {
        if (checkGuest()) return;
        e.stopPropagation();
        if (!picker && window.picmo) {
            picker = picmo.createPicker({
                rootElement: pickerContainer,
                width: '280px',
                height: '350px'
            });
            picker.addEventListener('emoji:select', event => {
                input.value += event.emoji;
                pickerContainer.style.display = 'none';
            });
        }
        pickerContainer.style.display = pickerContainer.style.display === 'none' ? 'block' : 'none';
    };

    document.addEventListener('click', (e) => {
        if (pickerContainer && !pickerContainer.contains(e.target) && e.target !== emojiBtn) {
            pickerContainer.style.display = 'none';
        }
    });

    toggle.onclick = () => {
        if (checkGuest()) {
            if (!body.innerText.includes("Please login")) {
                appendMsg("Please login to chat with the writer.", "system");
                const loginBtn = document.createElement('a');
                loginBtn.href = (window.contextPath || '') + '/auth';
                loginBtn.className = 'btn btn-primary';
                loginBtn.style.fontSize = '0.8rem';
                loginBtn.style.padding = '5px 15px';
                loginBtn.style.display = 'block';
                loginBtn.style.marginTop = '10px';
                loginBtn.style.textAlign = 'center';
                loginBtn.innerText = "Go to Login";
                body.appendChild(loginBtn);
            }
            windowEl.classList.add('active');
            return;
        }
        windowEl.classList.add('active');
        connectWS();
    };
    closeBtn.onclick = () => windowEl.classList.remove('active');

    function connectWS() {
        if (checkGuest()) {
            console.warn("Aborting connectWS: User is a guest.");
            return;
        }
        if (socket && socket.readyState === WebSocket.OPEN) return;

        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const context = window.contextPath || '';
        const socketUsername = window.chatUser || 'Guest';

        console.log("Connecting to WebSocket as:", socketUsername);
        socket = new WebSocket(`${protocol}//${window.location.host}${context}/chat/${encodeURIComponent(socketUsername)}`);

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
        if (checkGuest()) {
            console.warn("Aborting sendMessage: User is a guest.");
            return;
        }
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
