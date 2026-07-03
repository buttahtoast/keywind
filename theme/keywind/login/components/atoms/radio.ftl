<#macro kw checked=false id="" label="" rest...>
  <div>
    <input
      <#if checked>checked</#if>

      class="h-4 w-4 border-[var(--kw-border)] text-primary-600 focus:ring-primary-500/30"
      id="${id}"
      type="radio"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-[var(--kw-text-muted)] text-sm" for="${id}">
      ${label}
    </label>
  </div>
</#macro>
