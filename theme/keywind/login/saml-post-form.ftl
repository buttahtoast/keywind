<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("saml.post-form.title")}
  <#elseif section="form">
    <script>window.onload = function() { document.forms[0].submit() }</script>
    <p class="text-secondary-600 text-sm">${msg("saml.post-form.message")}</p>
    <form action="${samlPost.url}" method="post" name="saml-post-binding">
      <#if samlPost.SAMLRequest??>
        <input name="SAMLRequest" type="hidden" value="${samlPost.SAMLRequest}" />
      </#if>
      <#if samlPost.SAMLResponse??>
        <input name="SAMLResponse" type="hidden" value="${samlPost.SAMLResponse}" />
      </#if>
      <#if samlPost.relayState??>
        <input name="RelayState" type="hidden" value="${samlPost.relayState}" />
      </#if>
      <noscript>
        <p class="text-secondary-600 text-sm">${msg("saml.post-form.js-disabled")}</p>
        <@button.kw color="primary" type="submit">
          ${msg("doContinue")}
        </@button.kw>
      </noscript>
    </form>
  </#if>
</@layout.registrationLayout>
