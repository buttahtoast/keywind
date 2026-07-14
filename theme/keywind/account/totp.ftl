<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/field.ftl" as field>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="signing-in">
  <@pageHeader.kw
    title=msg("authenticatorTitle")
    intro=msg("accountSecurityIntroMessage")
  />

  <#if totp.enabled && totp.credentials?has_content>
    <@sectionCard.kw title="Configured authenticators">
      <ul class="divide-y divide-[var(--kw-border)] -mx-6 -my-5">
        <#list totp.credentials as credential>
          <li class="flex items-center justify-between gap-4 px-6 py-4">
            <div class="min-w-0">
              <p class="text-sm font-medium text-[var(--kw-text)]">${credential.userLabel}</p>
              <p class="text-xs text-[var(--kw-text-muted)]">Added ${credential.createdDate}</p>
            </div>
            <form method="post" action="${url.totpUrl}" class="m-0">
              <input type="hidden" name="credentialId" value="${credential.id}">
              <@button.kw color="ghost" type="submit" name="remove">
                ${msg("doRemove")}
              </@button.kw>
            </form>
          </li>
        </#list>
      </ul>
    </@sectionCard.kw>
  </#if>

  <@sectionCard.kw title=msg("authenticatorTitle") description=msg("updatePasswordMessageTitle")>
    <ol class="list-decimal list-inside space-y-3 text-sm text-[var(--kw-text-muted)]">
      <li>Install an authenticator app (FreeOTP, Google Authenticator, or Microsoft Authenticator).</li>
      <li>Scan the QR code or enter the secret key manually.</li>
      <li>Enter the one-time code to confirm setup.</li>
    </ol>

    <div class="flex flex-col sm:flex-row gap-6 items-start">
      <div class="rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface-muted)] p-4">
        <img
          src="data:image/png;base64,${totp.totpSecretQrCode}"
          alt="TOTP QR code"
          class="h-40 w-40 rounded-lg"
        >
      </div>
      <div class="space-y-3 text-sm">
        <div>
          <p class="font-medium text-[var(--kw-text)]">Manual entry key</p>
          <code class="mt-1 block rounded-xl bg-[var(--kw-surface-muted)] px-3 py-2 font-mono text-xs text-[var(--kw-text)] break-all">
            ${totp.totpSecretEncoded}
          </code>
        </div>
        <p class="text-[var(--kw-text-muted)]">
          Supported apps:
          <#list totp.supportedApplications as app>
            <span class="text-[var(--kw-text)]">${msg(app)}</span><#if app_has_next>, </#if>
          </#list>
        </p>
      </div>
    </div>

    <form class="m-0 space-y-5" method="post" action="${url.totpUrl}">
      <@field.kw
        label=msg("authenticatorCode")
        name="totp"
        required=true
        autocomplete="one-time-code"
      />
      <@field.kw
        label="Device name"
        name="userLabel"
        value="Authenticator app"
        help="A label to help you recognize this device."
      />
      <div class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2 pt-2">
        <@button.kw color="secondary" href=url.passwordUrl>
          ${msg("doCancel")}
        </@button.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doSave")}
        </@button.kw>
      </div>
    </form>
  </@sectionCard.kw>
</@layout.accountLayout>
