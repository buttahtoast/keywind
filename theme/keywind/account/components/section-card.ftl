<#macro kw title="" description="">
  <section class="bg-[var(--kw-surface)] border border-[var(--kw-border)] rounded-2xl shadow-sm overflow-hidden">
    <#if title?has_content || description?has_content>
      <div class="border-b border-[var(--kw-border)] px-6 py-5 space-y-1">
        <#if title?has_content>
          <h2 class="text-base font-semibold text-[var(--kw-text)]">${title}</h2>
        </#if>
        <#if description?has_content>
          <p class="text-sm text-[var(--kw-text-muted)]">${description}</p>
        </#if>
      </div>
    </#if>
    <div class="px-6 py-5 space-y-5">
      <#nested>
    </div>
  </section>
</#macro>
