<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayInfo=!isAppInitiatedAction??; section>
  <#if section="header">
    ${msg("emailVerifyTitle")}
  <#elseif section="form">
    <p class="text-secondary-600 text-sm dark:text-secondary-300">
      <#if verifyEmail??>
        ${msg("emailVerifyInstruction1", verifyEmail)}
      <#else>
        ${msg("emailVerifyInstruction4", user.email)}
      </#if>
    </p>
    <#if isAppInitiatedAction??>
      <@form.kw action=url.loginAction method="post">
        <@buttonGroup.kw>
          <#if verifyEmail??>
            <@button.kw color="primary" type="submit">
              ${msg("emailVerifyResend")}
            </@button.kw>
          <#else>
            <@button.kw color="primary" type="submit">
              ${msg("emailVerifySend")}
            </@button.kw>
          </#if>
          <@button.kw color="secondary" name="cancel-aia" type="submit" value="true">
            ${msg("doCancel")}
          </@button.kw>
        </@buttonGroup.kw>
      </@form.kw>
    </#if>
  <#elseif section="info">
    <#if !isAppInitiatedAction??>
      <div class="text-center">
        ${msg("emailVerifyInstruction2")}
        <@link.kw color="primary" href=url.loginAction>
          ${msg("doClickHere")}
        </@link.kw>
        ${msg("emailVerifyInstruction3")}
      </div>
    </#if>
  </#if>
</@layout.registrationLayout>
