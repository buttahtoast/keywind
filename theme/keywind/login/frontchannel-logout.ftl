<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("frontchannel-logout.title")}
  <#elseif section="form">
    <p class="text-secondary-600 text-sm">${msg("frontchannel-logout.message")}</p>
    <ul class="space-y-2 text-secondary-600 text-sm">
      <#list logout.clients as client>
        <li>
          ${client.name}
          <iframe src="${client.frontChannelLogoutUrl}" style="display:none;"></iframe>
        </li>
      </#list>
    </ul>
    <#if logout.logoutRedirectUri?has_content>
      <script>
        document.addEventListener('readystatechange', () => {
          if (document.readyState === 'complete') {
            window.location.replace('${logout.logoutRedirectUri?js_string}')
          }
        })
      </script>
      <@button.kw color="primary" component="a" href=logout.logoutRedirectUri>
        ${msg("doContinue")}
      </@button.kw>
    </#if>
  </#if>
</@layout.registrationLayout>
