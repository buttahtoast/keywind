<#macro kw>
  <div class="flex flex-col items-center gap-3">
    <div class="flex items-center justify-center gap-2">
      <svg class="h-6 w-6 text-[var(--kw-text)]" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
      </svg>
      <div class="font-semibold text-2xl tracking-[-0.02em] text-[var(--kw-text)]">
        <#nested>
      </div>
    </div>
  </div>
</#macro>