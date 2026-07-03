<#macro kw color="" component="a" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="text-primary-600 hover:text-primary-700">
      <#break>
    <#case "secondary">
      <#assign colorClass="text-secondary-700 hover:text-primary-700">
      <#break>
    <#default>
      <#assign colorClass="text-primary-600 hover:text-primary-700">
  </#switch>

  <#switch size>
    <#case "small">
      <#assign sizeClass="text-sm">
      <#break>
    <#default>
      <#assign sizeClass="">
  </#switch>

  <${component}
    class="<#compress>${colorClass} ${sizeClass} inline-flex</#compress>"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
