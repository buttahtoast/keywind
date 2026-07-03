<#import "/assets/icons/chevron-down.ftl" as icon>
<#import "/components/atoms/link.ftl" as link>

<#macro kw currentLocale="" locales=[]>
  <div class="relative" x-data="{ open: false }">
    <@link.kw @click="open = !open" color="secondary" component="button" type="button">
      <div class="flex items-center">
        <span class="mr-1 text-sm">${currentLocale}</span>
        <@icon.kw />
      </div>
    </@link.kw>
    <div
      @click.away="open = false"
      class="absolute bg-[var(--kw-surface)] border border-[var(--kw-border)] bottom-full left-1/2 -translate-x-1/2 max-h-80 mb-2 overflow-y-auto rounded-xl shadow-card dark:shadow-card-dark w-40"
      x-cloak
      x-show="open"
    >
      <#list locales as locale>
        <#if currentLocale != locale.label>
          <div class="px-4 py-2">
            <@link.kw color="secondary" href=locale.url size="small">
              ${locale.label}
            </@link.kw>
          </div>
        </#if>
      </#list>
    </div>
  </div>
</#macro>