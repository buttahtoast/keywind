<#import "/assets/icons/eye.ftl" as iconEye>
<#import "/assets/icons/eye-slash.ftl" as iconEyeSlash>

<#macro
  kw
  autofocus=false
  class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm transition-colors"
  disabled=false
  invalid=false
  label=""
  message=""
  name=""
  required=true
  type="text"
  rest...
>
  <div class="space-y-1.5">
    <#if label?has_content>
      <label class="block text-sm font-medium text-[var(--kw-text)]" for="${name}">
        ${label}
      </label>
    </#if>
    <#if type == "password">
      <div class="relative" x-data="{ show: false }">
        <input
          <#if autofocus>autofocus</#if>
          <#if disabled>disabled</#if>
          <#if required>required</#if>

          aria-invalid="${invalid?c}"
          class="${class}"
          id="${name}"
          name="${name}"
          placeholder="${label}"
          :type="show ? 'text' : 'password'"

          <#list rest as attrName, attrValue>
            ${attrName}="${attrValue}"
          </#list>
        >
        <button
          @click="show = !show"
          aria-controls="${name}"
          :aria-expanded="show"
          class="absolute right-4 top-3.5 text-[var(--kw-text-subtle)] hover:text-[var(--kw-text-muted)] transition-colors"
          type="button"
        >
          <div x-show="!show">
            <@iconEye.kw />
          </div>
          <div x-cloak x-show="show">
            <@iconEyeSlash.kw />
          </div>
        </button>
      </div>
    <#else>
      <input
        <#if autofocus>autofocus</#if>
        <#if disabled>disabled</#if>
        <#if required>required</#if>

        aria-invalid="${invalid?c}"
        class="${class}"
        id="${name}"
        name="${name}"
        placeholder="${label}"
        type="${type}"

        <#list rest as attrName, attrValue>
          ${attrName}="${attrValue}"
        </#list>
      >
    </#if>
    <#if invalid?? && message??>
      <div class="text-red-500 text-sm">
        ${message?no_esc}
      </div>
    </#if>
  </div>
</#macro>