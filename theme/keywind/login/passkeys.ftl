<#import "components/atoms/button.ftl" as button>
<#assign webAuthnData = webAuthn!{} />
<#if !webAuthnData?has_content && webauthn??>
  <#assign webAuthnData = webauthn />
</#if>
<#assign webAuthnAuthenticators = (webAuthnData.authenticators)!(authenticators!"") />
<#assign webAuthnShouldDisplayAuthenticators = (webAuthnData.shouldDisplayAuthenticators)!(shouldDisplayAuthenticators!false) />
<#assign webAuthnConditionalUIEnabled = (webAuthnData.enableWebAuthnConditionalUI)!(enableWebAuthnConditionalUI!"") />

<#macro hiddenForms>
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
  </#if>
</#macro>

<#macro authenticatorList titleMessage createdAtMessage>
  <#if webAuthnAuthenticators?has_content && webAuthnShouldDisplayAuthenticators>
    <div class="space-y-3">
      <#if webAuthnAuthenticators.authenticators?size gt 1>
        <p class="text-secondary-600 text-sm dark:text-secondary-300">
          ${kcSanitize(msg(titleMessage))?no_esc}
        </p>
      </#if>
      <#list webAuthnAuthenticators.authenticators as authenticator>
        <div class="rounded-md border border-secondary-200 p-3 dark:border-secondary-700">
          <div class="font-medium text-secondary-900 dark:text-secondary-100">${kcSanitize(msg("${authenticator.label}"))?no_esc}</div>
          <#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
            <div class="text-secondary-600 text-sm dark:text-secondary-300">
              <#list authenticator.transports.displayNameProperties as nameProperty>
                <span>${kcSanitize(msg("${nameProperty!}"))?no_esc}</span>
                <#if nameProperty?has_next>
                  <span>, </span>
                </#if>
              </#list>
            </div>
          </#if>
          <div class="text-secondary-600 text-sm dark:text-secondary-300">
            <span>${kcSanitize(msg(createdAtMessage))?no_esc}</span>
            <span>${kcSanitize(authenticator.createdAt)?no_esc}</span>
          </div>
        </div>
      </#list>
    </div>
  </#if>
</#macro>

<#macro store unsupportedBrowserMessage>
  <script>
    document.addEventListener('alpine:init', () => {
      Alpine.store('passkeys', {
        authenticatorAttachment: '${((webAuthnData.authenticatorAttachment)!(authenticatorAttachment!""))?string?js_string}',
        challenge: '${((webAuthnData.challenge)!(challenge!""))?string?js_string}',
        createTimeout: '${((webAuthnData.createTimeout)!(createTimeout!""))?string?js_string}',
        isUserIdentified: '${((webAuthnData.isUserIdentified)!(isUserIdentified!""))?string?js_string}',
        mediation: '${((webAuthnData.mediation)!(mediation!"conditional"))?string?js_string}',
        rpId: '${((webAuthnData.rpId)!(rpId!""))?string?js_string}',
        unsupportedBrowserText: '${msg(unsupportedBrowserMessage)?js_string}',
        userVerification: '${((webAuthnData.userVerification)!(userVerification!""))?string?js_string}',
      })
    })
  </script>
</#macro>

<#macro conditionalUIData>
  <#if webAuthnConditionalUIEnabled?has_content>
    <div x-data="passkeys" x-init="initPasskeyConditionalUI">
      <@hiddenForms />
      <div x-cloak x-show="passkeyFallbackVisible" class="mt-4">
        <@button.kw @click="authenticatePasskey" color="secondary" type="button">
          ${kcSanitize(msg("webauthn-doAuthenticate"))?no_esc}
        </@button.kw>
      </div>
    </div>
    <@store unsupportedBrowserMessage="passkey-unsupported-browser-text" />
  </#if>
</#macro>
