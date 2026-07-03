<#import "template.ftl" as layout>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayInfo=false; section>
  <#if section="header">
    ${msg("loginChooseAuthenticator")}
  <#elseif section="form">
    <div x-data class="space-y-2">
      <@form.kw action=url.loginAction method="post" x\-ref="selectCredentialForm">
        <input name="authenticationExecution" type="hidden" x-ref="authExecInput" />
        <#list auth.authenticationSelections as authenticationSelection>
          <button
            @click="$refs.authExecInput.value = '${authenticationSelection.authExecId}'; $refs.selectCredentialForm.submit()"
            class="w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-left transition hover:bg-[var(--kw-surface-muted)] focus:outline-none focus:ring-1 focus:ring-primary-500/40"
            type="button"
          >
            <div class="font-medium text-[var(--kw-text)]">${msg("${authenticationSelection.displayName}")}</div>
            <div class="mt-0.5 text-[var(--kw-text-muted)] text-sm">${msg("${authenticationSelection.helpText}")}</div>
          </button>
        </#list>
      </@form.kw>
    </div>
  </#if>
</@layout.registrationLayout>
