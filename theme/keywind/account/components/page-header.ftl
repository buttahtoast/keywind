<#macro kw title="" intro="">
  <header class="space-y-1.5">
    <h1 class="text-2xl font-semibold tracking-tight text-[var(--kw-text)]">
      <#if title?has_content>${title}<#else><#nested></#if>
    </h1>
    <#if intro?has_content>
      <p class="text-sm text-[var(--kw-text-muted)]">${intro}</p>
    </#if>
  </header>
</#macro>
