<#macro
  kw
  label=""
  name=""
  type="text"
  value=""
  required=false
  disabled=false
  autocomplete=""
  help=""
>
  <div class="space-y-1.5">
    <#if label?has_content>
      <label class="block text-sm font-medium text-[var(--kw-text)]" for="${name}">
        ${label}
        <#if required><span class="text-red-500" aria-hidden="true">*</span></#if>
      </label>
    </#if>
    <#if type == "password">
      <div class="relative" x-data="{ show: false }">
        <input
          class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm transition-colors"
          id="${name}"
          name="${name}"
          <#if required>required</#if>
          <#if disabled>disabled</#if>
          <#if autocomplete?has_content>autocomplete="${autocomplete}"</#if>
          :type="show ? 'text' : 'password'"
          value="${value}"
        >
        <button
          type="button"
          class="absolute right-4 top-3.5 text-[var(--kw-text-subtle)] hover:text-[var(--kw-text-muted)]"
          @click="show = !show"
          :aria-expanded="show"
          aria-controls="${name}"
        >
          <span x-show="!show" class="text-xs font-medium">Show</span>
          <span x-cloak x-show="show" class="text-xs font-medium">Hide</span>
        </button>
      </div>
    <#else>
      <input
        class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm transition-colors disabled:bg-[var(--kw-surface-muted)] disabled:text-[var(--kw-text-muted)]"
        id="${name}"
        name="${name}"
        type="${type}"
        value="${value}"
        <#if required>required</#if>
        <#if disabled>disabled</#if>
        <#if autocomplete?has_content>autocomplete="${autocomplete}"</#if>
      >
    </#if>
    <#if help?has_content>
      <p class="text-xs text-[var(--kw-text-subtle)]">${help}</p>
    </#if>
  </div>
</#macro>
