<#macro kw content="" footer="" header="">
  <div class="bg-[var(--kw-surface)] border border-[var(--kw-border)] p-8 rounded-2xl shadow-card dark:shadow-card-dark space-y-6">
    <#if header?has_content>
      <div class="space-y-3">
        ${header}
      </div>
    </#if>
    <#if content?has_content>
      <div class="space-y-5">
        ${content}
      </div>
    </#if>
    <#if footer?has_content>
      <div class="border-t border-[var(--kw-border)] pt-5 space-y-4">
        ${footer}
      </div>
    </#if>
  </div>
</#macro>