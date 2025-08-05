// ========== HAMBURGER MENU (Mobile Side Panel) ==========
const hamburgerBtn = document.getElementById("hamburgerBtn");
const sidePanel = document.getElementById("sidePanel");
const sidePanelCloseBtn = document.getElementById("sidePanelClose");

hamburgerBtn.addEventListener("click", () => {
    sidePanel.classList.toggle("active");
    sidePanel.setAttribute("aria-hidden", !sidePanel.classList.contains("active"));
});

sidePanelCloseBtn.addEventListener("click", () => {
    sidePanel.classList.remove("active");
    sidePanel.setAttribute("aria-hidden", "true");
});

// ========== CATEGORY DROPDOWN (Desktop) ==========
const catToggle = document.getElementById("categoryToggle");
const catDropdown = document.getElementById("categoryDropdown");
const catIcon = document.getElementById("cat-icon");

catToggle.addEventListener("click", (e) => {
    e.preventDefault();
    const isVisible = catDropdown.style.display === "block";
    catDropdown.style.display = isVisible ? "none" : "block";
    catIcon.name = isVisible ? "chevron-down-outline" : "chevron-up-outline";
    catToggle.setAttribute("aria-expanded", !isVisible);
});

// ========== CLOSE CATEGORY DROPDOWN IF CLICKED OUTSIDE ==========
document.addEventListener("click", (e) => {
    if (!catToggle.contains(e.target) && !catDropdown.contains(e.target)) {
        catDropdown.style.display = "none";
        catIcon.name = "chevron-down-outline";
        catToggle.setAttribute("aria-expanded", false);
    }
});

// ========== AUTO CLOSE SIDE PANEL ON DESKTOP WIDTH ==========
window.addEventListener("resize", () => {
    if (window.innerWidth > 940 && sidePanel.classList.contains("active")) {
        sidePanel.classList.remove("active");
        sidePanel.setAttribute("aria-hidden", "true");
    }
});


// ========== CATEGORY DROPDOWN (Side Panel) ==========
const sideCatToggle = document.getElementById("sideCategoryToggle");
const sideDropdown = document.getElementById("sideCategoryDropdown");
const sideCatIcon = document.getElementById("sideCatIcon");

sideCatToggle.addEventListener("click", (e) => {
  e.preventDefault();
  const isVisible = sideDropdown.style.display === "block";
  sideDropdown.style.display = isVisible ? "none" : "block";
  sideCatIcon.name = isVisible ? "chevron-down-outline" : "chevron-up-outline";
});


// ========== SEARCH INPUT (Basic Functionality) ==========
const searchInput = document.getElementById("searchInput");
searchInput.addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        e.preventDefault();
        const query = searchInput.value.trim();
        if (query.length > 0) {
            console.log("Searching for:", query);
            alert("Searching for: " + query);
        }
    }
});

// ========== USER DROPDOWN TOGGLE ==========
const userBtn = document.getElementById("userDropdownBtn");
const userMenu = userBtn.nextElementSibling;

userBtn.addEventListener("click", (e) => {
    e.preventDefault();
    const expanded = userBtn.getAttribute("aria-expanded") === "true";
    userBtn.setAttribute("aria-expanded", !expanded);
    if (userMenu.hasAttribute("hidden")) {
        userMenu.removeAttribute("hidden");
    } else {
        userMenu.setAttribute("hidden", "");
    }
});

// ========== CLOSE USER DROPDOWN IF CLICKED OUTSIDE ==========
document.addEventListener("click", (e) => {
    if (!userBtn.contains(e.target) && !userMenu.contains(e.target)) {
        userMenu.setAttribute("hidden", "");
        userBtn.setAttribute("aria-expanded", false);
    }
});

// ========== GOOGLE TRANSLATE LANGUAGE SELECTOR ==========
function googleTranslateElementInit() {
    new google.translate.TranslateElement({
        pageLanguage: 'en',
        includedLanguages: 'en,hi,mr',
        layout: google.translate.TranslateElement.InlineLayout.SIMPLE
    }, 'google_translate_element');
}

document.addEventListener('DOMContentLoaded', function () {
    const languageSelect = document.getElementById('languageSelect');

    languageSelect.addEventListener('change', function () {
        const selectedLang = languageSelect.value;

        const waitForGoogleDropdown = setInterval(() => {
            const googleDropdown = document.querySelector('.goog-te-combo');
            if (googleDropdown && googleDropdown.options.length > 1) {
                googleDropdown.value = selectedLang;
                googleDropdown.dispatchEvent(new Event('change'));
                clearInterval(waitForGoogleDropdown);
            }
        }, 500);
    });
});


document.addEventListener('DOMContentLoaded', function () {
    updateCartBadge(); // Initial load

    // ✅ Function to update cart count badge
    function updateCartBadge() {
        fetch('/cart-count/')
            .then(response => response.json())
            .then(data => {
                const badge = document.querySelector('.cart-badge');
                if (badge) {
                    badge.textContent = data.count;
                    badge.style.display = data.count > 0 ? 'inline-block' : 'none';
                }
            })
            .catch(error => console.error('Cart count fetch error:', error));
    }

    // 🔄 Reusable function for adding product to cart via fetch (AJAX)
    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', function () {
            const variantId = this.getAttribute('data-variant-id');
            const quantity = this.getAttribute('data-quantity') || 1;

            fetch('/save-to-cart/', {
                method: 'POST',
                body: JSON.stringify({
                    id: variantId,
                    quantity: quantity
                }),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCSRFToken()
                }
            })
            .then(res => res.json())
            .then(data => {
                alert(data.message);
                updateCartBadge();  // ✅ Update badge after cart add
            })
            .catch(err => {
                console.error('Add to cart error:', err);
            });
        });
    });

    // 🔐 Helper function to get CSRF token
    function getCSRFToken() {
        const name = 'csrftoken';
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            let cookie = cookies[i].trim();
            if (cookie.startsWith(name + '=')) {
                return decodeURIComponent(cookie.substring(name.length + 1));
            }
        }
        return '';
    }

    // ⬆ Expose badge update globally (optional)
    window.updateCartBadge = updateCartBadge;
});

