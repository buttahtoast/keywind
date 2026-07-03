<#import "/assets/icons/arrow-top-right-on-square.ftl" as icon>
<#import "/components/atoms/link.ftl" as link>

<#macro kw linkHref="" linkTitle="" name="">
  <div class="bg-[var(--kw-surface-muted)] border border-[var(--kw-border)] flex items-center justify-center mb-4 px-4 py-3 rounded-xl space-x-2">
    <span class="font-medium text-[var(--kw-text)]">${name}</span>
    <@link.kw
      color="primary"
      href=linkHref
      title=linkTitle
    >
      <@icon.kw />
    </@link.kw>
  </div>
</#macro>