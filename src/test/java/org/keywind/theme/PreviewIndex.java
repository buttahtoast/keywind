package org.keywind.theme;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

/**
 * Writes {@code html/index.html} listing login + account FreeMarker mocks.
 */
public final class PreviewIndex {
  private PreviewIndex() {}

  public static void write() throws IOException {
    List<Section> sections = new ArrayList<>();
    sections.add(section("Login", "html/login", "/html/login/"));
    sections.add(section("Account", "html/account", "/html/account/"));

    int total = sections.stream().mapToInt(s -> s.pages.size()).sum();

    StringBuilder body = new StringBuilder();
    body.append("<!DOCTYPE html>\n");
    body.append("<html lang=\"en\">\n");
    body.append("<head>\n");
    body.append("  <meta charset=\"utf-8\">\n");
    body.append("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
    body.append("  <title>Keywind · UI mocks</title>\n");
    body.append("  <link href=\"/src/index.css\" rel=\"stylesheet\">\n");
    body.append("</head>\n");
    body.append("<body class=\"text-[var(--kw-text)] antialiased min-h-screen bg-[var(--kw-page-bg)] px-6 py-12\">\n");
    body.append("  <main class=\"max-w-2xl mx-auto space-y-10\">\n");
    body.append("    <header class=\"space-y-2\">\n");
    body.append("      <p class=\"text-sm font-medium text-[var(--kw-primary-600)]\">Local preview</p>\n");
    body.append("      <h1 class=\"text-3xl font-semibold tracking-tight\">Keywind UI mocks</h1>\n");
    body.append("      <p class=\"text-[var(--kw-text-muted)] text-sm\">\n");
    body.append("        FreeMarker renders with mock Keycloak data. CSS/JS are served by Vite with HMR.\n");
    body.append("        Run <code class=\"bg-[var(--kw-surface-muted)] px-1.5 py-0.5 rounded text-xs\">npm run mock:generate</code>\n");
    body.append("        after template changes.\n");
    body.append("      </p>\n");
    body.append("    </header>\n");

    for (Section section : sections) {
      body.append("    <section class=\"space-y-3\">\n");
      body.append("      <div class=\"flex items-baseline justify-between gap-3\">\n");
      body.append("        <h2 class=\"text-lg font-semibold tracking-tight\">").append(section.title).append("</h2>\n");
      body.append("        <span class=\"text-xs text-[var(--kw-text-subtle)]\">")
          .append(section.pages.size())
          .append(" pages</span>\n");
      body.append("      </div>\n");

      if (section.pages.isEmpty()) {
        body.append("      <p class=\"text-sm text-[var(--kw-text-muted)]\">No mocks yet. Run mock:generate.</p>\n");
      } else {
        body.append("      <ul class=\"bg-[var(--kw-surface)] border border-[var(--kw-border)] rounded-2xl divide-y divide-[var(--kw-border)] shadow-sm\">\n");
        for (String page : section.pages) {
          String label = page.replace(".html", "").replace('-', ' ');
          body.append("        <li>\n");
          body.append("          <a class=\"flex items-center justify-between gap-4 px-5 py-3.5 text-sm hover:bg-[var(--kw-surface-muted)] transition-colors\" href=\"")
              .append(section.hrefPrefix)
              .append(page)
              .append("\">\n");
          body.append("            <span class=\"font-medium capitalize\">").append(label).append("</span>\n");
          body.append("            <span class=\"text-[var(--kw-text-subtle)] text-xs font-mono\">").append(page).append("</span>\n");
          body.append("          </a>\n");
          body.append("        </li>\n");
        }
        body.append("      </ul>\n");
      }
      body.append("    </section>\n");
    }

    body.append("    <p class=\"text-xs text-[var(--kw-text-subtle)]\">")
        .append(total)
        .append(" pages · login + account FreeMarker mocks</p>\n");
    body.append("  </main>\n");
    body.append("</body>\n");
    body.append("</html>\n");

    Files.createDirectories(new File("html").toPath());
    Files.writeString(new File("html/index.html").toPath(), body.toString(), StandardCharsets.UTF_8);
    System.out.println("Wrote html/index.html (" + total + " pages across login + account)");
  }

  private static Section section(String title, String dirPath, String hrefPrefix) {
    File dir = new File(dirPath);
    List<String> pages = new ArrayList<>();
    if (dir.isDirectory()) {
      File[] files = dir.listFiles((d, name) -> name.endsWith(".html"));
      if (files != null) {
        Arrays.stream(files)
            .map(File::getName)
            .sorted(Comparator.naturalOrder())
            .forEach(pages::add);
      }
    }
    return new Section(title, hrefPrefix, pages);
  }

  private record Section(String title, String hrefPrefix, List<String> pages) {}
}
