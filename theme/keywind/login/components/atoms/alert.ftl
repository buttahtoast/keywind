<#macro kw color="">
  <#switch color>
    <#case "error">
      <#assign colorClass="bg-red-50 text-red-700 dark:bg-red-950/60 dark:text-red-400">
      <#break>
    <#case "info">
      <#assign colorClass="bg-primary-50 text-primary-700 dark:bg-primary-950/60 dark:text-primary-400">
      <#break>
    <#case "success">
      <#assign colorClass="bg-emerald-50 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-400">
      <#break>
    <#case "warning">
      <#assign colorClass="bg-amber-50 text-amber-700 dark:bg-amber-950/60 dark:text-amber-400">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-50 text-primary-700 dark:bg-primary-950/60 dark:text-primary-400">
  </#switch>

  <div class="${colorClass} px-4 py-3 rounded-2xl text-sm" role="alert">
    <#nested>
  </div>
</#macro>