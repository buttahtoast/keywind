<#macro kw color="" component="button" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 text-white hover:bg-primary-700 active:bg-primary-800">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-[var(--kw-surface)] border border-[var(--kw-border)] text-[var(--kw-text)] hover:bg-[var(--kw-surface-muted)] hover:border-[var(--kw-border-strong)]">
      <#break>
    <#case "ghost">
      <#assign colorClass="bg-transparent text-[var(--kw-text-muted)] hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)]">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 text-white hover:bg-primary-700 active:bg-primary-800">
  </#switch>

  <#switch size>
    <#case "medium">
      <#assign sizeClass="px-5 py-3 text-sm">
      <#break>
    <#case "small">
      <#assign sizeClass="px-3 py-2 text-xs">
      <#break>
    <#default>
      <#assign sizeClass="px-5 py-3 text-sm">
  </#switch>

  <${component}
    class="${colorClass} ${sizeClass} flex font-medium gap-2 items-center justify-center relative rounded-2xl transition-all w-full focus:outline-none focus:ring-2 focus:ring-primary-500/40"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>