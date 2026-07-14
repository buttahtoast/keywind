<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="device-activity">
  <@pageHeader.kw
    title=msg("deviceActivityHtmlTitle")
    intro=msg("accountSecurityIntroMessage")
  />

  <@sectionCard.kw title=msg("sessionsHtmlTitle")>
    <#if sessions?has_content>
      <ul class="divide-y divide-[var(--kw-border)] -mx-6 -my-5">
        <#list sessions as session>
          <li class="px-6 py-4 space-y-2">
            <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3">
              <div class="min-w-0 space-y-1">
                <div class="flex items-center gap-2">
                  <p class="text-sm font-medium text-[var(--kw-text)]">${session.ipAddress}</p>
                  <#if session.current>
                    <span class="inline-flex items-center rounded-full bg-primary-50 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-primary-700 dark:bg-primary-950/60 dark:text-primary-400">
                      Current
                    </span>
                  </#if>
                </div>
                <p class="text-sm text-[var(--kw-text-muted)]">${session.browser}</p>
                <p class="text-xs text-[var(--kw-text-subtle)]">
                  Started ${session.started} · Last access ${session.lastAccess}
                </p>
                <#if session.clients?has_content>
                  <p class="text-xs text-[var(--kw-text-muted)]">
                    Clients:
                    <#list session.clients as client>
                      ${client}<#if client_has_next>, </#if>
                    </#list>
                  </p>
                </#if>
              </div>
              <#if !session.current>
                <form method="post" action="${url.sessionsUrl}" class="m-0 shrink-0">
                  <input type="hidden" name="sessionId" value="${session.id}">
                  <@button.kw color="ghost" type="submit">
                    ${msg("doSignOut")}
                  </@button.kw>
                </form>
              </#if>
            </div>
          </li>
        </#list>
      </ul>
    <#else>
      <p class="text-sm text-[var(--kw-text-muted)]">No active sessions.</p>
    </#if>

    <div class="pt-2">
      <form method="post" action="${url.sessionsUrl}" class="m-0">
        <input type="hidden" name="logoutAll" value="true">
        <@button.kw color="secondary" type="submit">
          ${msg("doLogOutAllSessions")}
        </@button.kw>
      </form>
    </div>
  </@sectionCard.kw>
</@layout.accountLayout>
