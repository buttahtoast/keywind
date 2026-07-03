<#macro kw checked=false id="" label="" rest...>
  <div>
    <input
      <#if checked>checked</#if>

      class="border-secondary-200 text-primary-600 focus:ring-primary-600 dark:border-secondary-700 dark:bg-secondary-800 dark:text-primary-500"
      id="${id}"
      type="radio"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-secondary-600 text-sm dark:text-secondary-300" for="${id}">
      ${label}
    </label>
  </div>
</#macro>
