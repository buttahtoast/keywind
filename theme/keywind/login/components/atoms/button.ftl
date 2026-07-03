<#macro kw color="" component="button" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 text-white focus:ring-primary-500 hover:bg-primary-700">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-white border border-secondary-300 text-secondary-700 focus:ring-primary-500 hover:bg-secondary-50 hover:text-secondary-900">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 text-white focus:ring-primary-500 hover:bg-primary-700">
  </#switch>

  <#switch size>
    <#case "medium">
      <#assign sizeClass="px-4 py-2 text-sm">
      <#break>
    <#case "small">
      <#assign sizeClass="px-2 py-1 text-xs">
      <#break>
    <#default>
      <#assign sizeClass="px-4 py-2 text-sm">
  </#switch>

  <${component}
    class="${colorClass} ${sizeClass} flex font-medium justify-center relative rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-white"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
