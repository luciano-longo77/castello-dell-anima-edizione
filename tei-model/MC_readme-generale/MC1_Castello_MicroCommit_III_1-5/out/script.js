  
        // Scroll progress
        function updateProgress() {
            const scrollTop = window.scrollY;
            const docHeight = document.documentElement.scrollHeight - window.innerHeight;
            const progress = (scrollTop / docHeight) * 100;
            document.getElementById('progressFill').style.height = progress + '%';
        }

        // Nav bar scroll effect
        const navbar = document.getElementById('navbar');
        const scrollTopBtn = document.getElementById('scrollTopBtn');

        window.addEventListener('scroll', () => {
            updateProgress();
            navbar.classList.toggle('scrolled', window.scrollY > 100);
            scrollTopBtn.classList.toggle('visible', window.scrollY > 400);

            // Update active nav
            const chapters = document.querySelectorAll('.chapter-block');
            let current = 'proemio';
            chapters.forEach(ch => {
                const rect = ch.getBoundingClientRect();
                if (rect.top <= 200) {
                    current = ch.id;
                }
            });
            document.querySelectorAll('.nav-btn').forEach(btn => {
                btn.classList.toggle('active', btn.dataset.target === current);
            });
        });

        // Smooth nav scroll
        document.querySelectorAll('.nav-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const target = document.getElementById(btn.dataset.target);
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });

        // Chapter toggle
        function toggleChapter(header) {
            const block = header.closest('.chapter-block');
            block.classList.toggle('open');
            if (block.classList.contains('open')) {
                // Animate range bar
                setTimeout(() => {
                    const fills = block.querySelectorAll('.folio-range-fill');
                    fills.forEach(fill => {
                        const target = fill.dataset.target;
                        fill.style.width = target + '%';
                    });
                }, 200);
            } else {
                const fills = block.querySelectorAll('.folio-range-fill');
                fills.forEach(fill => {
                    fill.style.width = '0%';
                });
            }
        }

        // Expand / Collapse all
        let allExpanded = false;
        function toggleAll() {
            allExpanded = !allExpanded;
            const btn = document.getElementById('expandAllBtn');
            btn.classList.toggle('expanded', allExpanded);
            btn.childNodes[btn.childNodes.length - 1].textContent = allExpanded ? ' Comprimi tutto' : ' Espandi tutto';

            document.querySelectorAll('.chapter-block').forEach(block => {
                if (allExpanded) {
                    block.classList.add('open');
                    setTimeout(() => {
                        const fills = block.querySelectorAll('.folio-range-fill');
                        fills.forEach(fill => {
                            fill.style.width = fill.dataset.target + '%';
                        });
                    }, 200);
                } else {
                    block.classList.remove('open');
                    const fills = block.querySelectorAll('.folio-range-fill');
                    fills.forEach(fill => {
                        fill.style.width = '0%';
                    });
                }
            });
        }

        // View mode
        function setView(mode) {
            const container = document.getElementById('timeline');
            const detailBtn = document.getElementById('viewDetail');
            const compactBtn = document.getElementById('viewCompact');

            if (mode === 'compact') {
                container.classList.add('compact');
                compactBtn.classList.add('active');
                detailBtn.classList.remove('active');
            } else {
                container.classList.remove('compact');
                detailBtn.classList.add('active');
                compactBtn.classList.remove('active');
            }
        }

        // Intersection Observer for animations
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        document.querySelectorAll('.chapter-block').forEach(block => {
            observer.observe(block);
        });

        document.querySelectorAll('.chapter-divider').forEach(divider => {
            observer.observe(divider);
        });

        // Init
        updateProgress();