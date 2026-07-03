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
      <p class="text-[var(--kw-text-muted)] text-sm">${msg("copyCodeInstruction")}</p>
      <input class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 mt-2 text-[var(--kw-text)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm" id="code" readonly value="${code.code}" />
    <#else>
      <p class="text-red-600 text-sm">${kcSanitize(code.error)?no_esc}</p>
    </#if>
  </#if>
</@layout.registrationLayout>
