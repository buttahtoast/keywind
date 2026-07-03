<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "features/labels/username.ftl" as usernameLabel>
<#import "passkeys.ftl" as passkeys>

<#assign usernameLabel><@usernameLabel.kw /></#assign>

<@layout.registrationLayout
  displayInfo=realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError("username")
  script="dist/passkeys.js"
  ;
  section
>
  <#if section="header">
    ${msg("passkey-login-title")}
  <#elseif section="form">
    <div x-data="passkeys" x-init="initPasskeyConditionalUI">
      <@passkeys.hiddenForms />
      <@passkeys.authenticatorList titleMessage="passkey-available-authenticators" createdAtMessage="passkey-createdAt-label" />
      <#if realm.password>
        <div x-cloak x-show="passkeyAutofillAvailable">
          <@form.kw
            action=url.loginAction
            method="post"
            onsubmit="login.disabled = true; return true;"
            x\-ref="passkeyLoginForm"
          >
            <#if !usernameHidden??>
              <@input.kw
                autocomplete="username webauthn"
                autofocus=true
                invalid=messagesPerField.existsError("username")
                label=msg("passkey-autofill-select")
                message=kcSanitize(messagesPerField.get("username"))?no_esc
                name="username"
                type="text"
                value=(login.username)!''
              />
            </#if>
          </@form.kw>
        </div>
      </#if>
      <div x-cloak x-show="passkeyFallbackVisible">
        <@buttonGroup.kw>
          <@button.kw @click="authenticatePasskey" color="primary" type="button">
            ${kcSanitize(msg("passkey-doAuthenticate"))?no_esc}
          </@button.kw>
        </@buttonGroup.kw>
      </div>
    </div>
    <@passkeys.store unsupportedBrowserMessage="passkey-unsupported-browser-text" />
  <#elseif section="info">
    <#if realm.registrationAllowed && !registrationDisabled??>
      <div class="text-center">
        ${msg("noAccount")}
        <@link.kw color="primary" href=url.registrationUrl>
          ${msg("doRegister")}
        </@link.kw>
      </div>
    </#if>
  </#if>
</@layout.registrationLayout>
