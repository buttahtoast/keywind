<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#assign webAuthnData = webAuthn!{} />
<#assign webAuthnAuthenticators = (webAuthnData.authenticators)!(authenticators!"") />
<#assign webAuthnShouldDisplayAuthenticators = (webAuthnData.shouldDisplayAuthenticators)!(shouldDisplayAuthenticators!false) />

<@layout.registrationLayout script="dist/webAuthnAuthenticate.js"; section>
  <#if section="title">
    title
  <#elseif section="header">
    ${kcSanitize(msg("webauthn-login-title"))?no_esc}
  <#elseif section="form">
    <div x-data="webAuthnAuthenticate">
      <form action="${url.loginAction}" method="post" x-ref="webAuthnForm">
        <input name="authenticatorData" type="hidden" x-ref="authenticatorDataInput" />
        <input name="clientDataJSON" type="hidden" x-ref="clientDataJSONInput" />
        <input name="credentialId" type="hidden" x-ref="credentialIdInput" />
        <input name="error" type="hidden" x-ref="errorInput" />
        <input name="signature" type="hidden" x-ref="signatureInput" />
        <input name="userHandle" type="hidden" x-ref="userHandleInput" />
      </form>
      <#if webAuthnAuthenticators?has_content>
        <form x-ref="authnSelectForm">
          <#list webAuthnAuthenticators.authenticators as authenticator>
            <input value="${authenticator.credentialId}" type="hidden" />
          </#list>
        </form>
        <#if webAuthnShouldDisplayAuthenticators>
          <#if webAuthnAuthenticators.authenticators?size gt 1>
            <p>${kcSanitize(msg("webauthn-available-authenticators"))?no_esc}</p>
          </#if>
          <#list webAuthnAuthenticators.authenticators as authenticator>
            <div>
              <div class="font-medium">${kcSanitize(msg("${authenticator.label}"))?no_esc}</div>
              <#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
                <div>
                  <#list authenticator.transports.displayNameProperties as nameProperty>
                    <span>${kcSanitize(msg("${nameProperty!}"))?no_esc}</span>
                    <#if nameProperty?has_next>
                      <span>, </span>
                    </#if>
                  </#list>
                </div>
              </#if>
              <div class="text-sm">
                <span>${kcSanitize(msg("webauthn-createdAt-label"))?no_esc}</span>
                <span>${kcSanitize(authenticator.createdAt)?no_esc}</span>
              </div>
            </div>
          </#list>
        </#if>
      </#if>
      <@buttonGroup.kw>
        <@button.kw @click="webAuthnAuthenticate" color="primary" type="button">
          ${kcSanitize(msg("webauthn-doAuthenticate"))}
        </@button.kw>
      </@buttonGroup.kw>
    </div>
  </#if>
</@layout.registrationLayout>

<script>
  document.addEventListener('alpine:init', () => {
    Alpine.store('webAuthnAuthenticate', {
      challenge: '${((webAuthnData.challenge)!(challenge!""))?string?js_string}',
      createTimeout: '${((webAuthnData.createTimeout)!(createTimeout!""))?string?js_string}',
      isUserIdentified: '${((webAuthnData.isUserIdentified)!(isUserIdentified!""))?string?js_string}',
      rpId: '${((webAuthnData.rpId)!(rpId!""))?string?js_string}',
      unsupportedBrowserText: '${msg("webauthn-unsupported-browser-text")?js_string}',
      userVerification: '${((webAuthnData.userVerification)!(userVerification!""))?string?js_string}',
    })
  })
</script>
