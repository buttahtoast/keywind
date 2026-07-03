<#import "template.ftl" as layout>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("emailLinkIdpTitle", idpDisplayName)}
  <#elseif section="form">
    <div class="space-y-3 text-[var(--kw-text-muted)] text-sm">
      <p>${msg("emailLinkIdp1", idpDisplayName, brokerContext.username, realm.displayName)}</p>
      <p>
        ${msg("emailLinkIdp2")}
        <@link.kw color="primary" href=url.loginAction>${msg("doClickHere")}</@link.kw>
        ${msg("emailLinkIdp3")}
      </p>
      <p>
        ${msg("emailLinkIdp4")}
        <@link.kw color="primary" href=url.loginAction>${msg("doClickHere")}</@link.kw>
        ${msg("emailLinkIdp5")}
      </p>
    </div>
  </#if>
</@layout.registrationLayout>
