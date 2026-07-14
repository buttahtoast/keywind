<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/field.ftl" as field>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="signing-in">
  <@pageHeader.kw
    title=msg("signingInSidebarTitle")
    intro=msg("accountSecurityIntroMessage")
  />

  <@sectionCard.kw title=msg("updatePasswordTitle") description=msg("updatePasswordMessage")>
    <#if password.passwordSet>
      <p class="text-sm text-[var(--kw-text-muted)]">
        ${msg("passwordLastUpdateMessage")}
        <span class="font-medium text-[var(--kw-text)]">${password.lastUpdate}</span>
      </p>
    </#if>

    <form class="m-0 space-y-5" method="post" action="${url.passwordUrl}">
      <#if password.passwordSet>
        <@field.kw
          label=msg("currentPassword")
          name="password"
          type="password"
          required=true
          autocomplete="current-password"
        />
      </#if>
      <@field.kw
        label=msg("passwordNew")
        name="password-new"
        type="password"
        required=true
        autocomplete="new-password"
      />
      <@field.kw
        label=msg("passwordConfirm")
        name="password-confirm"
        type="password"
        required=true
        autocomplete="new-password"
      />

      <div class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2 pt-2">
        <@button.kw color="primary" type="submit">
          ${msg("doSave")}
        </@button.kw>
      </div>
    </form>
  </@sectionCard.kw>

  <@sectionCard.kw title=msg("authenticatorTitle") description=msg("accountSecurityIntroMessage")>
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div class="space-y-1">
        <p class="text-sm font-medium text-[var(--kw-text)]">
          <#if totp.enabled>
            Two-factor authentication is enabled
          <#else>
            Two-factor authentication is not set up
          </#if>
        </p>
        <p class="text-sm text-[var(--kw-text-muted)]">
          <#if totp.enabled>
            ${totp.credentials?size} authenticator(s) configured
          <#else>
            Add an authenticator app for stronger sign-in security.
          </#if>
        </p>
      </div>
      <@button.kw color="secondary" href=url.totpUrl>
        <#if totp.enabled>Manage<#else>${msg("doAdd")}</#if>
      </@button.kw>
    </div>
  </@sectionCard.kw>
</@layout.accountLayout>
