<#macro kw color="" component="button" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 text-white focus:ring-primary-500 hover:bg-primary-700 active:bg-primary-800">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-[var(--kw-surface)] border border-[var(--kw-border-strong)] text-[var(--kw-text)] focus:ring-primary-500 hover:bg-[var(--kw-surface-muted)] hover:border-primary-500">
      <#break>
    <#case "ghost">
      <#assign colorClass="bg-transparent border border-[var(--kw-border)] text-[var(--kw-text-muted)] focus:ring-primary-500 hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)] hover:border-[var(--kw-border-strong)]">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 text-white focus:ring-primary-500 hover:bg-primary-700 active:bg-primary-800">
  </#switch>

  <#switch size>
    <#case "medium">
      <#assign sizeClass="px-4 py-2.5 text-sm">
      <#break>
    <#case "small">
      <#assign sizeClass="px-3 py-1.5 text-xs">
      <#break>
    <#default>
      <#assign sizeClass="px-4 py-2.5 text-sm">
  </#switch>

  <${component}
    class="${colorClass} ${sizeClass} flex font-medium gap-2 items-center justify-center relative rounded-xl transition-colors w-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-[var(--kw-surface)]"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>