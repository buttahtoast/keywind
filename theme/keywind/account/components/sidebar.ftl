<#--
  Account Console sidebar navigation.
  active: one of personal-info | signing-in | device-activity | linked-accounts | applications
-->
<#macro kw active="">
  <#assign items = [
    {"id": "personal-info", "href": url.accountUrl, "label": msg("personalInfoSidebarTitle")},
    {"id": "signing-in", "href": url.passwordUrl, "label": msg("signingInSidebarTitle")},
    {"id": "device-activity", "href": url.sessionsUrl, "label": msg("deviceActivitySidebarTitle")},
    {"id": "linked-accounts", "href": url.socialUrl, "label": msg("linkedAccountsSidebarTitle")},
    {"id": "applications", "href": url.applicationsUrl, "label": msg("applicationsHtmlTitle")}
  ] />

  <aside class="w-full lg:w-64 shrink-0">
    <div class="lg:sticky lg:top-8 space-y-6">
      <div class="flex items-center gap-2.5 px-1">
        <svg class="h-5 w-5 text-[var(--kw-text)]" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
        </svg>
        <span class="font-semibold text-[var(--kw-text)] tracking-tight">${(realm.displayName)!(realm.name)!"Account"}</span>
      </div>

      <nav class="flex lg:flex-col gap-1 overflow-x-auto lg:overflow-visible pb-1 lg:pb-0" aria-label="Account">
        <#list items as item>
          <#assign isActive = (active == item.id) />
          <a
            href="${item.href}"
            class="<#if isActive>bg-[var(--kw-surface)] text-[var(--kw-text)] shadow-sm border border-[var(--kw-border)]<#else>text-[var(--kw-text-muted)] hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)] border border-transparent</#if> whitespace-nowrap rounded-xl px-3.5 py-2.5 text-sm font-medium transition-colors"
            <#if isActive>aria-current="page"</#if>
          >
            ${item.label}
          </a>
        </#list>
      </nav>

      <div class="hidden lg:block border-t border-[var(--kw-border)] pt-4 space-y-3">
        <div class="flex items-center gap-3 px-1">
          <div class="flex h-9 w-9 items-center justify-center rounded-full bg-primary-600 text-xs font-semibold text-white" aria-hidden="true">
            ${account.initials}
          </div>
          <div class="min-w-0">
            <p class="truncate text-sm font-medium text-[var(--kw-text)]">${account.fullName}</p>
            <p class="truncate text-xs text-[var(--kw-text-muted)]">${account.email}</p>
          </div>
        </div>
        <a
          href="${url.logoutUrl}"
          class="flex w-full items-center justify-center rounded-xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-3 py-2 text-sm font-medium text-[var(--kw-text-muted)] hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)] transition-colors"
        >
          ${msg("doSignOut")}
        </a>
      </div>
    </div>
  </aside>
</#macro>
