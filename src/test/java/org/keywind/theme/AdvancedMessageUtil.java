package org.keywind.theme;

import java.util.List;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

/**
 * Lightweight stand-in for Keycloak's advancedMsg() FreeMarker helper.
 * Returns the first argument as a string (enough for static UI mocks).
 */
public class AdvancedMessageUtil implements TemplateMethodModelEx {
  @Override
  @SuppressWarnings("rawtypes")
  public Object exec(List arguments) throws TemplateModelException {
    if (arguments == null || arguments.isEmpty() || arguments.get(0) == null) {
      return "";
    }

    return arguments.get(0).toString();
  }
}
