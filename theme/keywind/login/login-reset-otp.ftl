<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/radio.ftl" as radio>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError("totp"); section>
  <#if section="header">
    ${msg("doLogIn")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <p class="text-secondary-600 text-sm">${msg("otp-reset-description")}</p>
      <div class="space-y-2">
        <#list configuredOtpCredentials.userOtpCredentials as otpCredential>
          <@radio.kw
            checked=(otpCredential.id == configuredOtpCredentials.selectedCredentialId)
            id="kc-otp-credential-${otpCredential?index}"
            label=otpCredential.userLabel
            name="selectedCredentialId"
            tabindex=otpCredential?index
            value=otpCredential.id
          />
        </#list>
      </div>
      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doSubmit")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
