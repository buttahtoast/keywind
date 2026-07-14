<#import "document.ftl" as document>
<#import "components/sidebar.ftl" as sidebar>
<#import "components/landscape.ftl" as landscape>

<#macro
  accountLayout
  active=""
  displayMessage=true
>
  <!DOCTYPE html>
  <html lang="${(locale.currentLanguageTag)!'en'}">
    <head>
      <@document.kw />
    </head>
    <body class="text-[var(--kw-text)] antialiased min-h-screen font-sans relative">
      <@landscape.kw />

      <div class="relative z-10 mx-auto max-w-6xl px-4 py-8 sm:px-6 lg:px-8">
        <div class="flex flex-col lg:flex-row gap-8 lg:gap-10">
          <@sidebar.kw active=active />

          <main class="min-w-0 flex-1 space-y-6">
            <#if displayMessage && message?has_content>
              <#if message.type == "success">
                <#assign alertClass = "bg-emerald-50 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-400">
              <#elseif message.type == "warning">
                <#assign alertClass = "bg-amber-50 text-amber-700 dark:bg-amber-950/60 dark:text-amber-400">
              <#elseif message.type == "error">
                <#assign alertClass = "bg-red-50 text-red-700 dark:bg-red-950/60 dark:text-red-400">
              <#else>
                <#assign alertClass = "bg-primary-50 text-primary-700 dark:bg-primary-950/60 dark:text-primary-400">
              </#if>
              <div class="${alertClass} px-4 py-3 rounded-2xl text-sm" role="alert">
                ${kcSanitize(message.summary)?no_esc}
              </div>
            </#if>

            <#nested>
          </main>
        </div>
      </div>
    </body>
  </html>
</#macro>
