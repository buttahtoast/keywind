<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="linked-accounts">
  <@pageHeader.kw
    title=msg("linkedAccountsHtmlTitle")
    intro=msg("accountSecurityIntroMessage")
  />

  <@sectionCard.kw title="Linked" description="Identity providers already connected to your account.">
    <#if federatedIdentity.linked?has_content>
      <ul class="divide-y divide-[var(--kw-border)] -mx-6 -my-5">
        <#list federatedIdentity.linked as identity>
          <li class="flex items-center justify-between gap-4 px-6 py-4">
            <div class="min-w-0">
              <p class="text-sm font-medium text-[var(--kw-text)]">${identity.providerName}</p>
              <p class="text-xs text-[var(--kw-text-muted)]">${identity.userName}</p>
            </div>
            <form method="post" action="${url.socialUrl}" class="m-0">
              <input type="hidden" name="providerId" value="${identity.providerId}">
              <@button.kw color="ghost" type="submit" name="remove">
                ${msg("doRemove")}
              </@button.kw>
            </form>
          </li>
        </#list>
      </ul>
    <#else>
      <p class="text-sm text-[var(--kw-text-muted)]">No linked accounts yet.</p>
    </#if>
  </@sectionCard.kw>

  <@sectionCard.kw title="Available to link" description="Connect another identity provider to sign in faster.">
    <#if federatedIdentity.available?has_content>
      <ul class="divide-y divide-[var(--kw-border)] -mx-6 -my-5">
        <#list federatedIdentity.available as identity>
          <li class="flex items-center justify-between gap-4 px-6 py-4">
            <p class="text-sm font-medium text-[var(--kw-text)]">${identity.providerName}</p>
            <@button.kw color="secondary" href=identity.url>
              ${msg("doLink")}
            </@button.kw>
          </li>
        </#list>
      </ul>
    <#else>
      <p class="text-sm text-[var(--kw-text-muted)]">No additional providers are available.</p>
    </#if>
  </@sectionCard.kw>
</@layout.accountLayout>
