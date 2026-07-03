<#import "/assets/icons/arrow-top-right-on-square.ftl" as icon>
<#import "/components/atoms/link.ftl" as link>

<#macro kw linkHref="" linkTitle="" name="">
  <div class="bg-[var(--kw-surface-muted)] flex items-center justify-between mb-2 px-4 py-2.5 rounded-2xl text-sm">
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