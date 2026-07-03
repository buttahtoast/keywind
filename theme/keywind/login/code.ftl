<#import "template.ftl" as layout>

<@layout.registrationLayout; section>
  <#if section="header">
    <#if code.success>
      ${msg("codeSuccessTitle")}
    <#else>
      ${kcSanitize(msg("codeErrorTitle", code.error))?no_esc}
    </#if>
  <#elseif section="form">
    <#if code.success>
      <p class="text-secondary-600 text-sm dark:text-secondary-300">${msg("copyCodeInstruction")}</p>
      <input class="block border-secondary-200 mt-1 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm dark:border-secondary-700 dark:bg-secondary-800 dark:text-secondary-100 dark:focus:border-primary-500 dark:focus:ring-primary-600" id="code" readonly value="${code.code}" />
    <#else>
      <p class="text-red-600 text-sm dark:text-red-300">${kcSanitize(code.error)?no_esc}</p>
    </#if>
  </#if>
</@layout.registrationLayout>
