document.addEventListener('DOMContentLoaded', () => {
    const profileTriggers = document.querySelectorAll('.profile-trigger');
    const profileModal = document.getElementById('profile-modal');
    const closeBtn = document.getElementById('close-profile');

    if (profileModal) {
        // Open Modal
        profileTriggers.forEach(trigger => {
            trigger.addEventListener('click', (e) => {
                e.preventDefault();
                const isLoggedIn = trigger.getAttribute('data-logged-in') === 'true';

                if (isLoggedIn) {
                    profileModal.classList.add('active');
                } else {
                    window.location.href = 'auth';
                }
            });
        });

        // Close Modal via Button
        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                profileModal.classList.remove('active');
            });
        }

        // Close Modal via Click Outside
        profileModal.addEventListener('click', (e) => {
            if (e.target === profileModal) {
                profileModal.classList.remove('active');
            }
        });

        // Close on Escape Key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && profileModal.classList.contains('active')) {
                profileModal.classList.remove('active');
            }
        });
    }
});
