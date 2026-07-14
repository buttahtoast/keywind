package org.keywind.theme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Mock FreeMarker data model for Keywind Account Console pages.
 * Used by {@link AccountThemeTest} for local UI preview.
 */
public class AccountDataModel {
  public static Map<String, Object> createDataModel() {
    Map<String, Object> dataModel = new HashMap<>();
    dataModel.put("account", createAccountModel());
    dataModel.put("applications", createApplicationsModel());
    dataModel.put("federatedIdentity", createFederatedIdentityModel());
    dataModel.put("locale", createLocaleModel());
    dataModel.put("message", createMessageModel());
    dataModel.put("password", createPasswordModel());
    dataModel.put("properties", createPropertiesModel());
    dataModel.put("realm", createRealmModel());
    dataModel.put("sessions", createSessionsModel());
    dataModel.put("totp", createTotpModel());
    dataModel.put("url", createUrlModel());
    return dataModel;
  }

  private static Map<String, Object> createAccountModel() {
    Map<String, Object> account = new HashMap<>();
    account.put("username", "ada");
    account.put("email", "ada@example.com");
    account.put("firstName", "Ada");
    account.put("lastName", "Lovelace");
    account.put("fullName", "Ada Lovelace");
    account.put("initials", "AL");
    return account;
  }

  private static List<Map<String, Object>> createApplicationsModel() {
    Map<String, Object> demo = new HashMap<>();
    demo.put("clientId", "demo-app");
    demo.put("clientName", "Demo Application");
    demo.put("description", "Primary application used for development.");
    demo.put("userConsentRequired", true);
    demo.put("inUse", true);
    demo.put("clientScopesGranted", List.of("profile", "email", "offline_access"));

    Map<String, Object> admin = new HashMap<>();
    admin.put("clientId", "account-console");
    admin.put("clientName", "Account Console");
    admin.put("description", "Manage your account settings.");
    admin.put("userConsentRequired", false);
    admin.put("inUse", true);
    admin.put("clientScopesGranted", List.of());

    List<Map<String, Object>> applications = new ArrayList<>();
    applications.add(demo);
    applications.add(admin);
    return applications;
  }

  private static Map<String, Object> createFederatedIdentityModel() {
    Map<String, Object> linkedGithub = new HashMap<>();
    linkedGithub.put("providerId", "github");
    linkedGithub.put("providerName", "GitHub");
    linkedGithub.put("userName", "ada-lovelace");

    Map<String, Object> availableGoogle = new HashMap<>();
    availableGoogle.put("providerId", "google");
    availableGoogle.put("providerName", "Google");
    availableGoogle.put("url", "#link-google");

    Map<String, Object> availableMicrosoft = new HashMap<>();
    availableMicrosoft.put("providerId", "microsoft");
    availableMicrosoft.put("providerName", "Microsoft");
    availableMicrosoft.put("url", "#link-microsoft");

    Map<String, Object> federatedIdentity = new HashMap<>();
    federatedIdentity.put("linked", List.of(linkedGithub));
    federatedIdentity.put("available", List.of(availableGoogle, availableMicrosoft));
    return federatedIdentity;
  }

  private static Map<String, Object> createLocaleModel() {
    Map<String, Object> locale = new HashMap<>();
    locale.put("current", "English");
    locale.put("currentLanguageTag", "en");
    return locale;
  }

  private static Map<String, Object> createMessageModel() {
    // Default: no global banner. Pages that need one can still read null-safe via message?has_content.
    // Provide a subtle success example for personal-info style feedback.
    return null;
  }

  private static Map<String, Object> createPasswordModel() {
    Map<String, Object> password = new HashMap<>();
    password.put("passwordSet", true);
    password.put("lastUpdate", "12 Mar 2026, 14:32");
    return password;
  }

  /**
   * Point styles/scripts at Vite source entries so {@code npm run dev} can HMR them.
   */
  private static Map<String, Object> createPropertiesModel() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("styles", "src/index.css");
    properties.put("scripts", "src/index.ts");
    return properties;
  }

  private static Map<String, Object> createRealmModel() {
    Map<String, Object> realm = new HashMap<>();
    realm.put("displayName", "Keywind");
    realm.put("name", "keywind");
    realm.put("editUsernameAllowed", true);
    realm.put("registrationEmailAsUsername", true);
    return realm;
  }

  private static List<Map<String, Object>> createSessionsModel() {
    Map<String, Object> current = new HashMap<>();
    current.put("id", "session-current");
    current.put("ipAddress", "203.0.113.42");
    current.put("browser", "Chrome / Linux");
    current.put("started", "14 Jul 2026, 09:10");
    current.put("lastAccess", "14 Jul 2026, 10:22");
    current.put("current", true);
    current.put("clients", List.of("account-console", "demo-app"));

    Map<String, Object> mobile = new HashMap<>();
    mobile.put("id", "session-mobile");
    mobile.put("ipAddress", "198.51.100.17");
    mobile.put("browser", "Safari / iOS");
    mobile.put("started", "13 Jul 2026, 18:04");
    mobile.put("lastAccess", "13 Jul 2026, 22:41");
    mobile.put("current", false);
    mobile.put("clients", List.of("demo-app"));

    List<Map<String, Object>> sessions = new ArrayList<>();
    sessions.add(current);
    sessions.add(mobile);
    return sessions;
  }

  private static Map<String, Object> createTotpModel() {
    Map<String, Object> credential = new HashMap<>();
    credential.put("id", "totp-1");
    credential.put("userLabel", "Phone authenticator");
    credential.put("createdDate", "2 Jan 2026");

    Map<String, Object> totp = new HashMap<>();
    totp.put("enabled", true);
    totp.put("credentials", List.of(credential));
    totp.put("totpSecretEncoded", "JBSWY3DPEHPK3PXP");
    totp.put("supportedApplications", List.of("totpAppFreeOTPName", "totpAppGoogleName", "totpAppMicrosoftAuthenticatorName"));
    // Small placeholder PNG (same QR used by login mocks)
    totp.put("totpSecretQrCode",
        "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");
    return totp;
  }

  private static Map<String, Object> createUrlModel() {
    Map<String, Object> url = new HashMap<>();
    url.put("accountUrl", "/html/account/account.html");
    url.put("passwordUrl", "/html/account/password.html");
    url.put("totpUrl", "/html/account/totp.html");
    url.put("sessionsUrl", "/html/account/sessions.html");
    url.put("applicationsUrl", "/html/account/applications.html");
    url.put("socialUrl", "/html/account/federatedIdentity.html");
    url.put("logoutUrl", "/html/login/login.html");
    // Empty → absolute Vite paths (/src/index.css) on any port
    url.put("resourcesPath", "");
    return url;
  }
}
