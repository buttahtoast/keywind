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

  /**
   * Beautify user avatar + name in masthead.
   * - Replaces ugly/default avatars (when no real profile picture) with clean initials.
   * - Keeps real user pictures.
   * - Improves appearance of First/LastName display area.
   */
  function beautifyUserProfile() {
    var masthead = document.querySelector('.pf-v5-c-masthead');
    if (!masthead) return;

    var toggles = masthead.querySelectorAll(
      '.pf-v5-c-dropdown__toggle, .pf-v5-c-menu-toggle, .pf-v5-c-toolbar__group:last-of-type button, .pf-v5-c-toolbar__item:last-of-type button, [id*="OUIA-Generated-MenuToggle"], [data-ouia-component-id*="MenuToggle"]'
    );

    toggles.forEach(function (toggle) {
      if (!toggle || toggle.dataset.kwStyled === '1') return;

      // Extract name (prefer direct child spans or visible text)
      var nameSpan = toggle.querySelector('span');
      var nameText = (nameSpan ? nameSpan.textContent : toggle.textContent || '').trim();

      if (!nameText || nameText.length < 2 || /keycloak/i.test(nameText)) return;

      // Compute nice initials from First Last name
      var parts = nameText.split(/\s+/).filter(function (p) { return p.length > 0; });
      var initials = '';
      if (parts.length >= 2) {
        initials = (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
      } else {
        initials = nameText.substring(0, 2).toUpperCase();
      }

      // Find avatar candidates
      var avatars = toggle.querySelectorAll('img, svg, .pf-v5-c-avatar, [class*="avatar"], [class*="pf-c-avatar"]');

      var hasRealAvatar = false;

      avatars.forEach(function (av) {
        var isImg = av.tagName === 'IMG';
        var src = isImg ? (av.getAttribute('src') || '') : '';

        // Heuristic: treat as "real picture" if it has a decent external-looking src
        var looksLikeRealPic = isImg && src.length > 10 &&
          !/^(data:|blob:)?$/.test(src) &&
          !/keycloak|default|placeholder|silhouette|user\.svg|gravatar.*(d=404|d=mp)/i.test(src);

        if (looksLikeRealPic) {
          hasRealAvatar = true;
          // Still ensure nice styling (CSS handles most)
          av.style.borderRadius = '9999px';
          av.style.objectFit = 'cover';
        } else {
          // Hide the ugly default avatar / icon
          av.style.display = 'none';

          // Inject a clean initials avatar (only once)
          if (!toggle.querySelector('.kw-user-initials')) {
            var init = document.createElement('div');
            init.className = 'kw-user-initials';
            init.textContent = initials;
            init.setAttribute('aria-hidden', 'true');
            init.style.cssText = [
              'display:flex',
              'align-items:center',
              'justify-content:center',
              'width:28px',
              'height:28px',
              'min-width:28px',
              'min-height:28px',
              'border-radius:9999px',
              'background:var(--kw-primary-600)',
              'color:#fff',
              'font-size:11.5px',
              'font-weight:600',
              'letter-spacing:0.5px',
              'flex-shrink:0',
              'border:1px solid var(--kw-border-strong)',
              'box-shadow:0 1px 2px rgb(0 0 0 / 0.1)'
            ].join(';') + ';';
            // Insert at the beginning of the toggle (before name)
            if (toggle.firstChild) {
              toggle.insertBefore(init, toggle.firstChild);
            } else {
              toggle.appendChild(init);
            }
          }
        }
      });

      // If no avatars at all (or all hidden), still ensure we have a nice initials one
      if (!hasRealAvatar && !toggle.querySelector('.kw-user-initials') && nameText) {
        var init = document.createElement('div');
        init.className = 'kw-user-initials';
        init.textContent = initials;
        init.setAttribute('aria-hidden', 'true');
        init.style.cssText = [
          'display:flex',
          'align-items:center',
          'justify-content:center',
          'width:28px',
          'height:28px',
          'min-width:28px',
          'min-height:28px',
          'border-radius:9999px',
          'background:var(--kw-primary-600)',
          'color:#fff',
          'font-size:11.5px',
          'font-weight:600',
          'letter-spacing:0.5px',
          'flex-shrink:0',
          'border:1px solid var(--kw-border-strong)',
          'box-shadow:0 1px 2px rgb(0 0 0 / 0.1)'
        ].join(';') + ';';
        toggle.insertBefore(init, toggle.firstChild || null);
      }

      // Remove any remaining dropdown caret / last icon elements inside the user toggle (we hide via CSS too)
      toggle.querySelectorAll('.pf-v5-c-dropdown__toggle-icon, [class*="caret"], [class*="toggle-icon"], .pf-v5-c-menu-toggle__toggle-icon').forEach(function (ic) {
        if (ic && ic.parentNode) ic.parentNode.removeChild(ic);
      });

      toggle.dataset.kwStyled = '1';
    });
  }

  // Run beautify multiple times (SPA renders in waves)
  function scheduleBeautify() {
    beautifyUserProfile();
    setTimeout(beautifyUserProfile, 650);
    setTimeout(beautifyUserProfile, 1400);
    setTimeout(beautifyUserProfile, 2400);
  }

  // Initial + after load
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scheduleBeautify);
  } else {
    scheduleBeautify();
  }

  // Observe masthead for SPA re-renders / user data loading
  var mastObserver = new MutationObserver(function () {
    beautifyUserProfile();
  });

  // Start observing when masthead appears
  var mastCheck = setInterval(function () {
    var mast = document.querySelector('.pf-v5-c-masthead');
    if (mast) {
      clearInterval(mastCheck);
      mastObserver.observe(mast, { childList: true, subtree: true });
      beautifyUserProfile();
    }
  }, 300);

  // Final safety net
  setTimeout(beautifyUserProfile, 3500);
})();
