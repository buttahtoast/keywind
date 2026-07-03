/**
 * Keywind Account - Post-load de-branding script
 * Cleans up Keycloak references that can't be removed with CSS alone (e.g. <title>, injected text)
 */
(function () {
  'use strict';

  function cleanTitle() {
    if (!document.title) return;
    // Replace Keycloak mentions with a neutral title
    var newTitle = document.title
      .replace(/Keycloak\s*Account\s*Management/gi, 'Account')
      .replace(/\bKeycloak\b/gi, '')
      .replace(/\s+/g, ' ')
      .trim();

    if (!newTitle || newTitle.length < 3) {
      newTitle = 'Account';
    }

    if (document.title !== newTitle) {
      document.title = newTitle;
    }
  }

  // Run immediately
  cleanTitle();

  // Watch for SPA title changes (Keycloak account console is heavily JS-driven)
  var titleObserver = new MutationObserver(function () {
    cleanTitle();
  });

  // Observe <title> and head
  var titleEl = document.querySelector('title');
  if (titleEl) {
    titleObserver.observe(titleEl, { childList: true, characterData: true, subtree: true });
  } else {
    titleObserver.observe(document.head || document.documentElement, {
      childList: true,
      subtree: true
    });
  }

  // Fallback: also clean periodically for a short time after load (SPA hydration)
  var attempts = 0;
  var interval = setInterval(function () {
    cleanTitle();
    attempts++;
    if (attempts > 8) {
      clearInterval(interval);
    }
  }, 400);

  // Optional: clean any visible text nodes in header areas that might still say "Keycloak"
  function removeKeycloakText() {
    var nodes = document.querySelectorAll('.pf-v5-c-masthead *, .pf-v5-c-page__header *');
    nodes.forEach(function (node) {
      if (node.nodeType === Node.TEXT_NODE) {
        if (/keycloak/i.test(node.textContent)) {
          node.textContent = node.textContent.replace(/keycloak/gi, '').trim();
        }
      } else if (node.textContent && /keycloak/i.test(node.textContent) && node.children.length === 0) {
        if (node.tagName === 'SPAN' || node.tagName === 'DIV') {
          node.textContent = node.textContent.replace(/keycloak/gi, '').trim();
        }
      }
    });
  }

  // Run text cleanup after initial render
  setTimeout(removeKeycloakText, 800);
  setTimeout(removeKeycloakText, 1800);
})();
