<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/form.ftl" as form>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("organization.select")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <div class="space-y-2">
        <#list user.organizations as organization>
          <@button.kw color="secondary" name="kc.org" type="submit" value=organization.alias>
            ${organization.name}
          </@button.kw>
        </#list>
      </div>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
