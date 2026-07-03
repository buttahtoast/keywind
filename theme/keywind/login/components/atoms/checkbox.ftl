<#macro kw checked=false label="" name="" rest...>
  <div class="flex items-center">
    <input
      <#if checked>checked</#if>

      class="h-4 w-4 rounded border-[var(--kw-border)] bg-[var(--kw-surface)] text-primary-600 focus:ring-1 focus:ring-primary-500/40"
      id="${name}"
      name="${name}"
      type="checkbox"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2.5 text-[var(--kw-text-muted)] text-sm" for="${name}">
      ${label}
    </label>
  </div>
</#macro>