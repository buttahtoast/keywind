<#import "template.ftl" as layout>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayMessage=false; section>
  <#if section="header">
    <#if messageHeader??>
      ${kcSanitize(msg("${messageHeader}"))?no_esc}
    <#else>
      ${kcSanitize(message.summary)?no_esc}
    </#if>
  <#elseif section="form">
    <div class="space-y-3 text-secondary-600 text-sm">
      <p>
        ${kcSanitize(message.summary)?no_esc}
        <#if requiredActions??>
          <#list requiredActions>: <b><#items as reqActionItem>${kcSanitize(msg("requiredAction.${reqActionItem}"))?no_esc}<#sep>, </#items></b></#list>
        </#if>
      </p>
      <#if !skipLink??>
        <#if pageRedirectUri?has_content>
          <@link.kw color="primary" href=pageRedirectUri>${msg("backToApplication")}</@link.kw>
        <#elseif actionUri?has_content>
          <@link.kw color="primary" href=actionUri>${msg("proceedWithAction")}</@link.kw>
        <#elseif (client.baseUrl)?has_content>
          <@link.kw color="primary" href=client.baseUrl>${msg("backToApplication")}</@link.kw>
        </#if>
      </#if>
    </div>
  </#if>
</@layout.registrationLayout>
