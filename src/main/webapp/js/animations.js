(function () {
    console.log("Animations script initialized.");

    function initAnimations() {
        console.log("Initializing IntersectionObserver...");
        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    // console.log("Revealing:", entry.target);
                    entry.target.classList.add('active');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        const revealedElements = document.querySelectorAll('.reveal');
        console.log("Found reveal elements:", revealedElements.length);
        revealedElements.forEach(el => observer.observe(el));
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAnimations);
    } else {
        initAnimations();
    }
})();
