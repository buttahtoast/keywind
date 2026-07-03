<#import "/assets/providers/providers.ftl" as providerIcons>

<#macro kw providers=[]>
  <div class="separate text-[var(--kw-text-subtle)] text-sm">
    ${msg("identity-provider-login-label")}
  </div>
  <div class="gap-3 grid grid-cols-3">
    <#list providers as provider>
      <#switch provider.alias>
        <#case "apple">
          <#assign colorClass="hover:bg-provider-apple/10 hover:border-provider-apple/30">
          <#break>
        <#case "bitbucket">
          <#assign colorClass="hover:bg-provider-bitbucket/10 hover:border-provider-bitbucket/30">
          <#break>
        <#case "discord">
          <#assign colorClass="hover:bg-provider-discord/10 hover:border-provider-discord/30">
          <#break>
        <#case "facebook">
          <#assign colorClass="hover:bg-provider-facebook/10 hover:border-provider-facebook/30">
          <#break>
        <#case "github">
          <#assign colorClass="hover:bg-provider-github/10 hover:border-provider-github/30">
          <#break>
        <#case "gitlab">
          <#assign colorClass="hover:bg-provider-gitlab/10 hover:border-provider-gitlab/30">
          <#break>
        <#case "google">
          <#assign colorClass="hover:bg-provider-google/10 hover:border-provider-google/30">
          <#break>
        <#case "instagram">
          <#assign colorClass="hover:bg-provider-instagram/10 hover:border-provider-instagram/30">
          <#break>
        <#case "linkedin-openid-connect">
          <#assign colorClass="hover:bg-provider-linkedin/10 hover:border-provider-linkedin/30">
          <#break>
        <#case "microsoft">
          <#assign colorClass="hover:bg-provider-microsoft/10 hover:border-provider-microsoft/30">
          <#break>
        <#case "oidc">
          <#assign colorClass="hover:bg-provider-oidc/10 hover:border-provider-oidc/30">
          <#break>
        <#case "openshift-v3">
          <#assign colorClass="hover:bg-provider-openshift/10 hover:border-provider-openshift/30">
          <#break>
        <#case "openshift-v4">
          <#assign colorClass="hover:bg-provider-openshift/10 hover:border-provider-openshift/30">
          <#break>
        <#case "paypal">
          <#assign colorClass="hover:bg-provider-paypal/10 hover:border-provider-paypal/30">
          <#break>
        <#case "slack">
          <#assign colorClass="hover:bg-provider-slack/10 hover:border-provider-slack/30">
          <#break>
        <#case "stackoverflow">
          <#assign colorClass="hover:bg-provider-stackoverflow/10 hover:border-provider-stackoverflow/30">
          <#break>
        <#case "twitter">
          <#assign colorClass="hover:bg-provider-twitter/10 hover:border-provider-twitter/30">
          <#break>
        <#default>
          <#assign colorClass="hover:bg-[var(--kw-surface-muted)]">
      </#switch>

      <a
        class="${colorClass} bg-[var(--kw-surface)] border border-[var(--kw-border)] flex justify-center py-2.5 rounded-xl transition-colors"
        data-provider="${provider.alias}"
        href="${provider.loginUrl}"
        type="button"
      >
        <#if providerIcons[provider.alias]??>
          <div class="h-5 w-5">
            <@providerIcons[provider.alias] />
          </div>
        <#else>
          <span class="text-[var(--kw-text-muted)] text-xs">${provider.displayName!}</span>
        </#if>
      </a>
    </#list>
  </div>
</#macro>