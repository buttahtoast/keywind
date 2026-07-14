<#macro kw color="primary" type="button" href="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 text-white hover:bg-primary-700">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-[var(--kw-surface)] border border-[var(--kw-border)] text-[var(--kw-text)] hover:bg-[var(--kw-surface-muted)]">
      <#break>
    <#case "danger">
      <#assign colorClass="bg-red-600 text-white hover:bg-red-700">
      <#break>
    <#case "ghost">
      <#assign colorClass="bg-transparent text-[var(--kw-text-muted)] hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)]">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 text-white hover:bg-primary-700">
  </#switch>

  <#assign baseClass="${colorClass} inline-flex items-center justify-center gap-2 rounded-2xl px-5 py-2.5 text-sm font-medium transition-all focus:outline-none focus:ring-2 focus:ring-primary-500/40">

  <#if href?has_content>
    <a href="${href}" class="${baseClass}"
      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
      <#nested>
    </a>
  <#else>
    <button type="${type}" class="${baseClass}"
      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
      <#nested>
    </button>
  </#if>
</#macro>
