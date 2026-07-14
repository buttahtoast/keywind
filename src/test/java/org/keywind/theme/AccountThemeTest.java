package org.keywind.theme;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;

import freemarker.core.HTMLOutputFormat;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModelException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.Test;
import org.keycloak.theme.KeycloakSanitizerMethod;
import org.keycloak.theme.beans.MessageFormatterMethod;

/**
 * Renders FreeMarker Account Console templates against a mock data model
 * and writes static HTML into {@code html/account/} for local UI preview.
 *
 * <p>Note: production Keycloak Account Console v3 is a React SPA
 * ({@code parent=keycloak.v3}). These FreeMarker pages provide a Keywind-styled
 * account UI for local verification and design iteration.
 */
public class AccountThemeTest {
  private static final Locale LOCALE = Locale.ENGLISH;
  private static final String MESSAGE_PATH = "theme/base/account/messages/messages";
  private static final String OUTPUT_PATH = "html/account";
  private static final String THEME_PATH = "theme/keywind/account";

  private static final String[] TEMPLATE_NAMES = {
      "account.ftl",
      "password.ftl",
      "totp.ftl",
      "sessions.ftl",
      "applications.ftl",
      "federatedIdentity.ftl",
  };

  @Test
  public void shouldRenderAccountTemplates() throws IOException, TemplateException {
    Configuration configuration = createFreeMarkerConfiguration();
    List<String> rendered = new ArrayList<>();
    List<String> failed = new ArrayList<>();

    Files.createDirectories(new File(OUTPUT_PATH).toPath());

    for (String templateName : TEMPLATE_NAMES) {
      try {
        Template template = configuration.getTemplate(templateName);
        String html = renderTemplate(template);
        Document document = formatHtml(html);
        saveHtmlToFile(templateName, document);
        rendered.add(templateName);
        System.out.println("Rendered account: " + templateName);
      } catch (TemplateException e) {
        failed.add(templateName + " → " + e.getMessageWithoutStackTop());
        System.err.println("Failed to render " + templateName + ": " + e.getMessageWithoutStackTop());
      }
    }

    PreviewIndex.write();

    System.out.println();
    System.out.println("Account mock generation summary:");
    System.out.println("  rendered: " + rendered.size());
    System.out.println("  failed:   " + failed.size());

    if (!failed.isEmpty()) {
      throw new AssertionError(
          "Failed to render " + failed.size() + " account template(s):\n  - " + String.join("\n  - ", failed));
    }
  }

  private Configuration createFreeMarkerConfiguration() throws IOException, TemplateModelException {
    Configuration configuration = new Configuration(Configuration.VERSION_2_3_32);
    configuration.setDirectoryForTemplateLoading(new File(THEME_PATH));
    configuration.setOutputFormat(HTMLOutputFormat.INSTANCE);
    configuration.setDefaultEncoding(StandardCharsets.UTF_8.name());

    Properties messages = loadMessages(LOCALE);
    // Merge login messages for shared keys like totpApp* names used in authenticator setup
    messages.putAll(loadOptionalMessages("theme/base/login/messages/messages", LOCALE));
    // Neutral branding for local mocks (production SPA still uses theme messages)
    messages.setProperty("accountManagementTitle", "Account");
    messages.setProperty("accountManagementWelcomeMessage", "Welcome to your account");

    configuration.setSharedVariable("kcSanitize", new KeycloakSanitizerMethod());
    configuration.setSharedVariable("msg", new MessageFormatterMethod(LOCALE, messages));
    configuration.setSharedVariable("advancedMsg", new AdvancedMessageUtil());

    return configuration;
  }

  private Properties loadMessages(Locale locale) {
    ResourceBundle resourceBundle = ResourceBundle.getBundle(MESSAGE_PATH, locale);
    Properties properties = new Properties();
    Enumeration<String> keys = resourceBundle.getKeys();
    while (keys.hasMoreElements()) {
      String key = keys.nextElement();
      properties.setProperty(key, resourceBundle.getString(key));
    }
    return properties;
  }

  private Properties loadOptionalMessages(String path, Locale locale) {
    Properties properties = new Properties();
    try {
      ResourceBundle resourceBundle = ResourceBundle.getBundle(path, locale);
      Enumeration<String> keys = resourceBundle.getKeys();
      while (keys.hasMoreElements()) {
        String key = keys.nextElement();
        properties.setProperty(key, resourceBundle.getString(key));
      }
    } catch (Exception ignored) {
      // optional
    }
    return properties;
  }

  private String renderTemplate(Template template) throws IOException, TemplateException {
    Map<String, Object> dataModel = AccountDataModel.createDataModel();
    try (StringWriter writer = new StringWriter()) {
      template.process(dataModel, writer);
      return writer.toString();
    }
  }

  private Document formatHtml(String html) {
    Document document = Jsoup.parse(html);
    document.outputSettings()
        .indentAmount(2)
        .prettyPrint(true)
        .charset(StandardCharsets.UTF_8);
    return document;
  }

  private void saveHtmlToFile(String templateName, Document document) throws IOException {
    File outputFile = new File(OUTPUT_PATH, templateName.replace(".ftl", ".html"));
    try (FileWriter fileWriter = new FileWriter(outputFile, StandardCharsets.UTF_8)) {
      fileWriter.write(document.outerHtml());
    }
  }
}
