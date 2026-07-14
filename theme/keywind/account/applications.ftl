<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="applications">
  <@pageHeader.kw
    title=msg("applicationsHtmlTitle")
    intro=msg("applicationsIntroMessage")
  />

  <@sectionCard.kw title=msg("applicationsHtmlTitle")>
    <#if applications?has_content>
      <ul class="divide-y divide-[var(--kw-border)] -mx-6 -my-5">
        <#list applications as app>
          <li class="px-6 py-4">
            <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
              <div class="min-w-0 space-y-2">
                <div>
                  <p class="text-sm font-medium text-[var(--kw-text)]">${app.clientName}</p>
                  <p class="text-xs text-[var(--kw-text-subtle)] font-mono">${app.clientId}</p>
                </div>
                <#if app.description?has_content>
                  <p class="text-sm text-[var(--kw-text-muted)]">${app.description}</p>
                </#if>
                <#if app.userConsentRequired && app.clientScopesGranted?has_content>
                  <div class="flex flex-wrap gap-1.5">
                    <#list app.clientScopesGranted as scope>
                      <span class="inline-flex rounded-lg bg-[var(--kw-surface-muted)] px-2 py-1 text-xs text-[var(--kw-text-muted)]">
                        ${scope}
                      </span>
                    </#list>
                  </div>
                </#if>
              </div>
              <#if app.inUse || app.userConsentRequired>
                <form method="post" action="${url.applicationsUrl}" class="m-0 shrink-0">
                  <input type="hidden" name="clientId" value="${app.clientId}">
                  <@button.kw color="ghost" type="submit" name="revoke">
                    ${msg("doRemove")}
                  </@button.kw>
                </form>
              </#if>
            </div>
          </li>
        </#list>
      </ul>
    <#else>
      <p class="text-sm text-[var(--kw-text-muted)]">No applications have access to your account.</p>
    </#if>
  </@sectionCard.kw>
</@layout.accountLayout>
