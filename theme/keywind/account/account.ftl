<#import "template.ftl" as layout>
<#import "components/page-header.ftl" as pageHeader>
<#import "components/section-card.ftl" as sectionCard>
<#import "components/field.ftl" as field>
<#import "components/button.ftl" as button>

<@layout.accountLayout active="personal-info">
  <@pageHeader.kw
    title=msg("personalInfoHtmlTitle")
    intro=msg("personalInfoIntroMessage")
  />

  <@sectionCard.kw title=msg("personalSubTitle") description=msg("personalSubMessage")>
    <form class="m-0 space-y-5" method="post" action="${url.accountUrl}">
      <@field.kw
        label=msg("username")
        name="username"
        value=(account.username)!""
        disabled=!(realm.editUsernameAllowed!false)
        autocomplete="username"
      />
      <@field.kw
        label=msg("email")
        name="email"
        type="email"
        value=(account.email)!""
        required=true
        autocomplete="email"
      />
      <@field.kw
        label=msg("firstName")
        name="firstName"
        value=(account.firstName)!""
        required=true
        autocomplete="given-name"
      />
      <@field.kw
        label=msg("lastName")
        name="lastName"
        value=(account.lastName)!""
        required=true
        autocomplete="family-name"
      />

      <div class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2 pt-2">
        <@button.kw color="secondary" type="reset">
          ${msg("doCancel")}
        </@button.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doSave")}
        </@button.kw>
      </div>
    </form>
  </@sectionCard.kw>
</@layout.accountLayout>
