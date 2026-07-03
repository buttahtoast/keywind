<#macro kw color="">
  <#switch color>
    <#case "error">
      <#assign colorClass="bg-red-50 border border-red-200 text-red-700 dark:bg-red-950/50 dark:border-red-900 dark:text-red-400">
      <#break>
    <#case "info">
      <#assign colorClass="bg-primary-50 border border-primary-200 text-primary-700 dark:bg-primary-950/50 dark:border-primary-900 dark:text-primary-400">
      <#break>
    <#case "success">
      <#assign colorClass="bg-emerald-50 border border-emerald-200 text-emerald-700 dark:bg-emerald-950/50 dark:border-emerald-900 dark:text-emerald-400">
      <#break>
    <#case "warning">
      <#assign colorClass="bg-amber-50 border border-amber-200 text-amber-700 dark:bg-amber-950/50 dark:border-amber-900 dark:text-amber-400">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-50 border border-primary-200 text-primary-700 dark:bg-primary-950/50 dark:border-primary-900 dark:text-primary-400">
  </#switch>

  <div class="${colorClass} p-4 rounded-xl text-sm" role="alert">
    <#nested>
  </div>
</#macro>