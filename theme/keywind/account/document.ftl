<#macro kw>
  <title>${msg("accountManagementTitle")}</title>

  <meta charset="utf-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <#if properties.styles?has_content>
    <#list properties.styles?split(" ") as style>
      <link href="${url.resourcesPath}/${style}" rel="stylesheet">
    </#list>
  </#if>

  <#if properties.scripts?has_content>
    <#list properties.scripts?split(" ") as script>
      <script defer src="${url.resourcesPath}/${script}" type="module"></script>
    </#list>
  </#if>
</#macro>
