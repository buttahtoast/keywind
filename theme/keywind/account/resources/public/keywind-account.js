/**
 * Keywind Account Console SPA helpers
 * - Inject landscape background (matches login FreeMarker)
 * - De-brand Keycloak titles / leftover text
 * - Clean user avatar → initials when no real photo
 */
(function () {
  'use strict';

  /* ---------- Landscape background ---------- */

  var LANDSCAPE_SVG =
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 800" preserveAspectRatio="xMidYMid slice" aria-hidden="true">' +
    '<circle cx="1080" cy="165" r="68" class="sun-glow"/>' +
    '<circle cx="1080" cy="165" r="42" class="sun"/>' +
    '<g class="cloud cloud-slow" style="animation-delay:-25s">' +
    '<ellipse cx="180" cy="142" rx="68" ry="23"/>' +
    '<ellipse cx="245" cy="128" rx="52" ry="31"/>' +
    '<ellipse cx="295" cy="145" rx="58" ry="22"/>' +
    '<ellipse cx="155" cy="155" rx="32" ry="16"/>' +
    '</g>' +
    '<g class="cloud cloud-medium" style="animation-delay:-52s">' +
    '<ellipse cx="420" cy="98" rx="52" ry="18"/>' +
    '<ellipse cx="475" cy="86" rx="42" ry="25"/>' +
    '<ellipse cx="515" cy="102" rx="48" ry="17"/>' +
    '</g>' +
    '<g class="cloud cloud-slow" style="animation-delay:-8s">' +
    '<ellipse cx="720" cy="155" rx="75" ry="26"/>' +
    '<ellipse cx="800" cy="138" rx="58" ry="35"/>' +
    '<ellipse cx="860" cy="158" rx="62" ry="24"/>' +
    '<ellipse cx="680" cy="168" rx="35" ry="18"/>' +
    '</g>' +
    '<g class="cloud cloud-fast" style="animation-delay:-38s">' +
    '<ellipse cx="1020" cy="82" rx="45" ry="16"/>' +
    '<ellipse cx="1065" cy="72" rx="36" ry="22"/>' +
    '<ellipse cx="1100" cy="85" rx="40" ry="15"/>' +
    '</g>' +
    '<rect x="0" y="320" width="1440" height="480" class="mist"/>' +
    '<path d="M0,420 Q160,325 340,395 Q510,305 720,380 Q910,310 1090,370 Q1250,320 1440,385 L1440,800 L0,800 Z" class="hill-far"/>' +
    '<path d="M0,490 Q200,410 410,475 Q620,395 850,460 Q1050,400 1240,455 Q1380,415 1440,460 L1440,800 L0,800 Z" class="hill-mid"/>' +
    '<path d="M0,560 Q280,485 510,545 Q780,470 1030,530 Q1260,475 1440,525 L1440,800 L0,800 Z" class="hill-front"/>' +
    '</svg>';

  function injectLandscape() {
    if (document.querySelector('.kw-landscape')) return;
    var el = document.createElement('div');
    el.className = 'kw-landscape';
    el.setAttribute('aria-hidden', 'true');
    el.innerHTML = LANDSCAPE_SVG;
    document.body.insertBefore(el, document.body.firstChild);
  }

  /* ---------- Title de-branding ---------- */

  function cleanTitle() {
    if (!document.title) return;
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

  function removeKeycloakText() {
    var nodes = document.querySelectorAll('.pf-v5-c-masthead *, .pf-v5-c-page__header *');
    nodes.forEach(function (node) {
      if (node.nodeType === Node.TEXT_NODE) {
        if (/keycloak/i.test(node.textContent)) {
          node.textContent = node.textContent.replace(/keycloak/gi, '').trim();
        }
      } else if (
        node.textContent &&
        /keycloak/i.test(node.textContent) &&
        node.children.length === 0
      ) {
        if (node.tagName === 'SPAN' || node.tagName === 'DIV') {
          node.textContent = node.textContent.replace(/keycloak/gi, '').trim();
        }
      }
    });
  }

  /* ---------- User avatar initials ---------- */

  function initialsFromName(nameText) {
    var parts = nameText.split(/\s+/).filter(function (p) {
      return p.length > 0;
    });
    if (parts.length >= 2) {
      return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
    }
    return nameText.substring(0, 2).toUpperCase();
  }

  function createInitialsAvatar(initials) {
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
      'box-shadow:0 1px 2px rgb(0 0 0 / 0.1)',
    ].join(';');
    return init;
  }

  function beautifyUserProfile() {
    var masthead = document.querySelector('.pf-v5-c-masthead, .pf-c-page__header');
    if (!masthead) return;

    var toggles = masthead.querySelectorAll(
      '.pf-v5-c-dropdown__toggle, .pf-v5-c-menu-toggle, .pf-v5-c-toolbar__group:last-of-type button, .pf-v5-c-toolbar__item:last-of-type button, .pf-c-dropdown__toggle'
    );

    toggles.forEach(function (toggle) {
      if (!toggle || toggle.dataset.kwStyled === '1') return;

      var nameSpan = toggle.querySelector('span');
      var nameText = (nameSpan ? nameSpan.textContent : toggle.textContent || '').trim();

      if (!nameText || nameText.length < 2 || /keycloak/i.test(nameText)) return;

      var initials = initialsFromName(nameText);
      var avatars = toggle.querySelectorAll(
        'img, svg, .pf-v5-c-avatar, .pf-c-avatar, [class*="avatar"]'
      );
      var hasRealAvatar = false;

      avatars.forEach(function (av) {
        var isImg = av.tagName === 'IMG';
        var src = isImg ? av.getAttribute('src') || '' : '';
        var looksLikeRealPic =
          isImg &&
          src.length > 10 &&
          !/^(data:|blob:)?$/.test(src) &&
          !/keycloak|default|placeholder|silhouette|user\.svg|gravatar.*(d=404|d=mp)/i.test(src);

        if (looksLikeRealPic) {
          hasRealAvatar = true;
          av.style.borderRadius = '9999px';
          av.style.objectFit = 'cover';
        } else {
          av.style.display = 'none';
          if (!toggle.querySelector('.kw-user-initials')) {
            toggle.insertBefore(createInitialsAvatar(initials), toggle.firstChild);
          }
        }
      });

      if (!hasRealAvatar && !toggle.querySelector('.kw-user-initials') && nameText) {
        toggle.insertBefore(createInitialsAvatar(initials), toggle.firstChild || null);
      }

      toggle
        .querySelectorAll(
          '.pf-v5-c-dropdown__toggle-icon, .pf-c-dropdown__toggle-icon, [class*="caret"], [class*="toggle-icon"], .pf-v5-c-menu-toggle__toggle-icon'
        )
        .forEach(function (ic) {
          if (ic && ic.parentNode) ic.parentNode.removeChild(ic);
        });

      toggle.dataset.kwStyled = '1';
    });
  }

  function scheduleBeautify() {
    beautifyUserProfile();
    setTimeout(beautifyUserProfile, 650);
    setTimeout(beautifyUserProfile, 1400);
    setTimeout(beautifyUserProfile, 2400);
  }

  /* ---------- Boot ---------- */

  function boot() {
    injectLandscape();
    cleanTitle();
    scheduleBeautify();

    var titleEl = document.querySelector('title');
    var titleObserver = new MutationObserver(function () {
      cleanTitle();
    });
    if (titleEl) {
      titleObserver.observe(titleEl, { childList: true, characterData: true, subtree: true });
    } else if (document.head) {
      titleObserver.observe(document.head, { childList: true, subtree: true });
    }

    var attempts = 0;
    var interval = setInterval(function () {
      cleanTitle();
      injectLandscape();
      attempts++;
      if (attempts > 8) clearInterval(interval);
    }, 400);

    setTimeout(removeKeycloakText, 800);
    setTimeout(removeKeycloakText, 1800);

    var mastObserver = new MutationObserver(function () {
      beautifyUserProfile();
    });
    var mastCheck = setInterval(function () {
      var mast = document.querySelector('.pf-v5-c-masthead, .pf-c-page__header');
      if (mast) {
        clearInterval(mastCheck);
        mastObserver.observe(mast, { childList: true, subtree: true });
        beautifyUserProfile();
      }
    }, 300);

    setTimeout(beautifyUserProfile, 3500);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', boot);
  } else {
    boot();
  }
})();
