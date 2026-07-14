package org.keywind.theme;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;

import freemarker.core.HTMLOutputFormat;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModelException;
import freemarker.template.TemplateNotFoundException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.Test;
import org.keycloak.forms.login.LoginFormsPages;
import org.keycloak.forms.login.freemarker.Templates;
import org.keycloak.theme.KeycloakSanitizerMethod;
import org.keycloak.theme.beans.MessageFormatterMethod;
import org.keycloak.theme.beans.MessagesPerFieldBean;

/**
 * Renders FreeMarker login templates against a mock Keycloak data model
 * and writes static HTML into {@code html/login/} for local UI preview.
 *
 * Run: {@code pnpm mock:generate} or {@code mvn test}
 * Preview: {@code pnpm dev} then open http://localhost:5173/
 */
public class LoginThemeTest {
  private static final Locale LOCALE = Locale.ENGLISH;
  private static final String MESSAGE_PATH = "theme/base/login/messages/messages";
  private static final String OUTPUT_PATH = "html/login";
  private static final String THEME_PATH = "theme/keywind/login";

  /** Templates not covered by LoginFormsPages but present in the theme. */
  private static final String[] EXTRA_TEMPLATE_NAMES = {
      "login-passkeys-conditional-authenticate.ftl",
      "select-organization.ftl",
      "terms.ftl",
      "webauthn-register.ftl",
  };

  @Test
  public void shouldTestTemplates() throws IOException, TemplateException {
    Configuration configuration = createFreeMarkerConfiguration();
    List<String> rendered = new ArrayList<>();
    List<String> skipped = new ArrayList<>();
    List<String> failed = new ArrayList<>();

    Files.createDirectories(new File(OUTPUT_PATH).toPath());

    for (String templateName : getTemplateNames()) {
      try {
        Template template = configuration.getTemplate(templateName);
        String renderedTemplate = renderTemplate(template);
        Document document = formatHtml(renderedTemplate);

        saveHtmlToFile(templateName, document);
        rendered.add(templateName);
        System.out.println("Rendered: " + templateName);
      } catch (TemplateNotFoundException e) {
        skipped.add(templateName);
        System.out.println("Template not found (skipped): " + templateName);
      } catch (TemplateException e) {
        failed.add(templateName + " → " + e.getMessageWithoutStackTop());
        System.err.println("Failed to render " + templateName + ": " + e.getMessageWithoutStackTop());
      }
    }

    PreviewIndex.write();

    System.out.println();
    System.out.println("Login mock generation summary:");
    System.out.println("  rendered: " + rendered.size());
    System.out.println("  skipped:  " + skipped.size());
    System.out.println("  failed:   " + failed.size());

    if (!failed.isEmpty()) {
      throw new AssertionError(
          "Failed to render " + failed.size() + " template(s):\n  - " + String.join("\n  - ", failed));
    }
  }

  private Configuration createFreeMarkerConfiguration() throws IOException, TemplateModelException {
    Configuration configuration = new Configuration(Configuration.VERSION_2_3_32);
    configuration.setDirectoryForTemplateLoading(new File(THEME_PATH));
    configuration.setOutputFormat(HTMLOutputFormat.INSTANCE);
    configuration.setDefaultEncoding(StandardCharsets.UTF_8.name());

    Properties messages = loadMessages(LOCALE);

    configuration.setSharedVariable("kcSanitize", new KeycloakSanitizerMethod());
    configuration.setSharedVariable("messagesPerField", new MessagesPerFieldBean());
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

  private String[] getTemplateNames() {
    Set<String> names = new LinkedHashSet<>();

    Arrays.stream(LoginFormsPages.values())
        .map(Templates::getTemplate)
        .forEach(names::add);

    names.addAll(Arrays.asList(EXTRA_TEMPLATE_NAMES));

    return names.toArray(String[]::new);
  }

  private String renderTemplate(Template template) throws IOException, TemplateException {
    Map<String, Object> dataModel = LoginDataModel.createDataModel();

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
