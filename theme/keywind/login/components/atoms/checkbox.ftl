<#macro kw checked=false label="" name="" rest...>
  <div class="flex items-center">
    <input
      <#if checked>checked</#if>

      class="border-[var(--kw-border-strong)] h-4 rounded text-primary-600 w-4 focus:ring-[var(--kw-focus)]"
      id="${name}"
      name="${name}"
      type="checkbox"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-[var(--kw-text-muted)] text-sm" for="${name}">
      ${label}
    </label>
  </div>
</#macro>