package org.keywind.theme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Mock FreeMarker data model approximating Keycloak login form beans.
 * Used by {@link LoginThemeTest} to render static HTML for local UI preview.
 */
public class LoginDataModel {
  public static Map<String, Object> createDataModel() {
    Map<String, Object> dataModel = new HashMap<>();
    dataModel.put("auth", createAuthModel());
    dataModel.put("brokerContext", createBrokerContextModel());
    dataModel.put("client", createClientModel());
    dataModel.put("code", createCodeModel());
    dataModel.put("configuredOtpCredentials", createConfiguredOtpCredentialsModel());
    dataModel.put("idpDisplayName", "Identity Provider");
    dataModel.put("locale", createLocaleModel());
    dataModel.put("login", createLoginModel());
    dataModel.put("logout", createFrontchannelLogoutModel());
    dataModel.put("logoutConfirm", createLogoutConfirmModel());
    dataModel.put("message", createMessageModel());
    dataModel.put("oauth", createOAuthModel());
    dataModel.put("otpLogin", createOtpLoginModel());
    dataModel.put("passwordRequired", true);
    dataModel.put("properties", createPropertiesModel());
    dataModel.put("realm", createRealmModel());
    dataModel.put("recoveryAuthnCodesConfigBean", createRecoveryAuthnCodesConfigBeanModel());
    dataModel.put("recoveryAuthnCodesInputBean", createRecoveryAuthnCodesInputBeanModel());
    dataModel.put("register", createRegisterModel());
    dataModel.put("social", createSocialModel());
    dataModel.put("samlPost", createSamlPostModel());
    dataModel.put("totp", createTotpModel());
    dataModel.put("url", createUrlModel());
    dataModel.put("user", createUserModel());
    dataModel.put("webAuthn", createWebAuthnModel());
    dataModel.put("execution", "webauthn-execution-id");
    dataModel.put("username", "Username");
    dataModel.put("x509", createX509Model());

    return dataModel;
  }

  private static Map<String, Object> createAuthModel() {
    Map<String, Object> securityKey = new HashMap<>();
    securityKey.put("authExecId", "authExecId");
    securityKey.put("displayName", "Security Key");
    securityKey.put("helpText", "Use your security key to sign in.");

    Map<String, Object> password = new HashMap<>();
    password.put("authExecId", "passwordExecId");
    password.put("displayName", "Password");
    password.put("helpText", "Sign in with your password.");

    List<Map<String, Object>> authenticationSelections = new ArrayList<>();
    authenticationSelections.add(securityKey);
    authenticationSelections.add(password);

    Map<String, Object> auth = new HashMap<>();
    auth.put("attemptedUsername", "user@example.com");
    auth.put("authenticationSelections", authenticationSelections);
    auth.put("showResetCredentials", new AuthenticationUtil());
    auth.put("showTryAnotherWayLink", new AuthenticationUtil());
    auth.put("showUsername", new AuthenticationUtil());

    return auth;
  }

  private static Map<String, Object> createClientModel() {
    Map<String, Object> attributes = new HashMap<>();
    attributes.put("tosUri", "https://example.com/tos");
    attributes.put("policyUri", "https://example.com/privacy");

    Map<String, Object> client = new HashMap<>();
    client.put("attributes", attributes);
    client.put("baseUrl", "https://example.com");
    client.put("clientId", "demo-client");
    client.put("name", "Demo Application");

    return client;
  }

  private static Map<String, Object> createBrokerContextModel() {
    Map<String, Object> brokerContext = new HashMap<>();
    brokerContext.put("username", "broker.user@example.com");

    return brokerContext;
  }

  private static Map<String, Object> createCodeModel() {
    Map<String, Object> code = new HashMap<>();
    code.put("code", "demo-auth-code");
    code.put("error", "error");
    code.put("success", true);

    return code;
  }

  private static Map<String, Object> createConfiguredOtpCredentialsModel() {
    Map<String, Object> otpCredential = new HashMap<>();
    otpCredential.put("id", "otpCredentialId");
    otpCredential.put("userLabel", "Authenticator app");

    Map<String, Object> configuredOtpCredentials = new HashMap<>();
    configuredOtpCredentials.put("selectedCredentialId", "otpCredentialId");
    configuredOtpCredentials.put("userOtpCredentials", List.of(otpCredential));

    return configuredOtpCredentials;
  }

  private static Map<String, Object> createFrontchannelLogoutModel() {
    Map<String, Object> client = new HashMap<>();
    client.put("frontChannelLogoutUrl", "https://example.com/logout");
    client.put("name", "Demo Application");

    Map<String, Object> logout = new HashMap<>();
    logout.put("clients", List.of(client));
    logout.put("logoutRedirectUri", "https://example.com");

    return logout;
  }

  private static Map<String, Object> createLocaleModel() {
    Map<String, Object> de = new HashMap<>();
    de.put("label", "Deutsch");
    de.put("url", "#de");
    de.put("languageTag", "de");

    Map<String, Object> en = new HashMap<>();
    en.put("label", "English");
    en.put("url", "#en");
    en.put("languageTag", "en");

    Map<String, Object> fr = new HashMap<>();
    fr.put("label", "Français");
    fr.put("url", "#fr");
    fr.put("languageTag", "fr");

    List<Map<String, Object>> supported = new ArrayList<>();
    supported.add(de);
    supported.add(en);
    supported.add(fr);

    Map<String, Object> locale = new HashMap<>();
    locale.put("current", "English");
    locale.put("currentLanguageTag", "en");
    locale.put("supported", supported);

    return locale;
  }

  private static Map<String, Object> createLoginModel() {
    Map<String, Object> login = new HashMap<>();
    login.put("rememberMe", true);
    login.put("username", "user@example.com");

    return login;
  }

  private static Map<String, Object> createLogoutConfirmModel() {
    Map<String, Object> logoutConfirm = new HashMap<>();
    logoutConfirm.put("code", "logout-code");
    logoutConfirm.put("skipLink", false);

    return logoutConfirm;
  }

  private static Map<String, Object> createMessageModel() {
    Map<String, Object> message = new HashMap<>();
    message.put("summary", "Example of an error message");
    message.put("type", "error");

    return message;
  }

  private static Map<String, Object> createOAuthModel() {
    Map<String, Object> scope = new HashMap<>();
    scope.put("consentScreenText", "View your email address");

    Map<String, Object> dynamicScope = new HashMap<>();
    dynamicScope.put("consentScreenText", "Access resource");
    dynamicScope.put("dynamicScopeParameter", "project-42");

    List<Map<String, Object>> clientScopesRequested = new ArrayList<>();
    clientScopesRequested.add(scope);
    clientScopesRequested.add(dynamicScope);

    Map<String, Object> oauth = new HashMap<>();
    oauth.put("clientScopesRequested", clientScopesRequested);
    oauth.put("code", "oauth-code");

    return oauth;
  }

  private static Map<String, Object> createOtpLoginModel() {
    Map<String, Object> otpCredential = new HashMap<>();
    otpCredential.put("id", "otpCredentialId");
    otpCredential.put("userLabel", "Authenticator app");

    Map<String, Object> otpLogin = new HashMap<>();
    otpLogin.put("selectedCredentialId", "otpCredentialId");
    otpLogin.put("userOtpCredentials", List.of(otpCredential));

    return otpLogin;
  }

  /**
   * Point styles/scripts at Vite source entries so {@code pnpm dev} can HMR them.
   * Production theme.properties still uses dist/* assets.
   */
  private static Map<String, Object> createPropertiesModel() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("scripts", "src/index.ts");
    properties.put("styles", "src/index.css");

    return properties;
  }

  private static Map<String, Object> createRealmModel() {
    Map<String, Object> realm = new HashMap<>();
    realm.put("displayName", "Keywind");
    realm.put("displayNameHtml", "Keywind");
    realm.put("internationalizationEnabled", true);
    realm.put("loginWithEmailAllowed", true);
    realm.put("name", "keywind");
    realm.put("password", true);
    realm.put("registrationAllowed", true);
    realm.put("registrationEmailAsUsername", true);
    realm.put("rememberMe", true);
    realm.put("resetPasswordAllowed", true);

    return realm;
  }

  private static Map<String, Object> createRegisterModel() {
    Map<String, Object> formData = new HashMap<>();
    formData.put("email", "");
    formData.put("firstName", "");
    formData.put("lastName", "");
    formData.put("username", "");

    Map<String, Object> register = new HashMap<>();
    register.put("formData", formData);

    return register;
  }

  public static Map<String, Object> createRecoveryAuthnCodesConfigBeanModel() {
    List<String> generatedRecoveryAuthnCodesList = new ArrayList<>();
    generatedRecoveryAuthnCodesList.add("0000-0000-0000");
    generatedRecoveryAuthnCodesList.add("1111-1111-1111");
    generatedRecoveryAuthnCodesList.add("2222-2222-2222");

    Map<String, Object> recoveryAuthnCodesConfigBean = new HashMap<>();
    recoveryAuthnCodesConfigBean.put("generatedAt", "2026-01-01T00:00:00Z");
    recoveryAuthnCodesConfigBean.put("generatedRecoveryAuthnCodesAsString",
        String.join(",", generatedRecoveryAuthnCodesList));
    recoveryAuthnCodesConfigBean.put("generatedRecoveryAuthnCodesList", generatedRecoveryAuthnCodesList);

    return recoveryAuthnCodesConfigBean;
  }

  public static Map<String, Object> createRecoveryAuthnCodesInputBeanModel() {
    Map<String, Object> recoveryAuthnCodesInputBean = new HashMap<>();
    recoveryAuthnCodesInputBean.put("codeNumber", 3);

    return recoveryAuthnCodesInputBean;
  }

  private static Map<String, Object> createSocialModel() {
    Map<String, Object> facebook = new HashMap<>();
    facebook.put("alias", "facebook");
    facebook.put("displayName", "Facebook");
    facebook.put("loginUrl", "#facebook");
    facebook.put("providerId", "facebook");

    Map<String, Object> github = new HashMap<>();
    github.put("alias", "github");
    github.put("displayName", "GitHub");
    github.put("loginUrl", "#github");
    github.put("providerId", "github");

    Map<String, Object> google = new HashMap<>();
    google.put("alias", "google");
    google.put("displayName", "Google");
    google.put("loginUrl", "#google");
    google.put("providerId", "google");

    List<Map<String, Object>> providers = new ArrayList<>();
    providers.add(facebook);
    providers.add(github);
    providers.add(google);

    Map<String, Object> social = new HashMap<>();
    social.put("providers", providers);

    return social;
  }

  private static Map<String, Object> createTotpModel() {
    Map<String, Object> otpCredential = new HashMap<>();
    otpCredential.put("id", "otpCredentialId");
    otpCredential.put("userLabel", "Authenticator app");

    List<Map<String, Object>> otpCredentials = new ArrayList<>();
    otpCredentials.add(otpCredential);

    List<String> supportedApplications = new ArrayList<>();
    supportedApplications.add("totpAppFreeOTPName");
    supportedApplications.add("totpAppGoogleName");
    supportedApplications.add("totpAppMicrosoftName");

    Map<String, Object> totp = new HashMap<>();
    totp.put("manualUrl", "otpauth://totp/Keywind:user@example.com?secret=JBSWY3DPEHPK3PXP&issuer=Keywind");
    totp.put("otpCredentials", otpCredentials);
    totp.put("policy", createTotpPolicyModel());
    totp.put("supportedApplications", supportedApplications);
    totp.put("totpSecret", "JBSWY3DPEHPK3PXP");
    totp.put("totpSecretEncoded", "JBSWY3DPEHPK3PXP");
    totp.put("totpSecretQrCode",
        "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");

    return totp;
  }

  private static Map<String, Object> createTotpPolicyModel() {
    Map<String, Object> policy = new HashMap<>();
    policy.put("algorithm", "HmacSHA1");
    policy.put("digits", 6);
    policy.put("lookAheadWindow", 1);
    policy.put("period", 30);
    policy.put("type", "totp");

    return policy;
  }

  private static Map<String, Object> createUrlModel() {
    Map<String, Object> url = new HashMap<>();
    url.put("loginAction", "#loginAction");
    url.put("loginResetCredentialsUrl", "#loginResetCredentials");
    url.put("loginRestartFlowUrl", "#loginRestartFlow");
    url.put("loginUrl", "/html/login/login.html");
    url.put("logoutConfirmAction", "#logoutConfirm");
    url.put("oauthAction", "#oauthAction");
    url.put("oauth2DeviceVerificationAction", "#oauth2DeviceVerification");
    url.put("registrationAction", "#registrationAction");
    url.put("registrationUrl", "/html/login/register.html");
    // Empty resourcesPath → absolute Vite paths (/src/index.css) on any port
    url.put("resourcesPath", "");

    return url;
  }

  private static Map<String, Object> createUserModel() {
    Map<String, Object> organization = new HashMap<>();
    organization.put("alias", "acme");
    organization.put("name", "Acme Corp");

    Map<String, Object> organization2 = new HashMap<>();
    organization2.put("alias", "globex");
    organization2.put("name", "Globex Inc");

    Map<String, Object> user = new HashMap<>();
    user.put("editUsernameAllowed", true);
    user.put("email", "user@example.com");
    user.put("firstName", "Ada");
    user.put("lastName", "Lovelace");
    user.put("organizations", List.of(organization, organization2));
    user.put("username", "ada");

    return user;
  }

  private static Map<String, Object> createSamlPostModel() {
    Map<String, Object> samlPost = new HashMap<>();
    samlPost.put("relayState", "relayState");
    samlPost.put("SAMLRequest", "SAMLRequest");
    samlPost.put("url", "https://idp.example.com/sso");

    return samlPost;
  }

  private static Map<String, Object> createWebAuthnModel() {
    Map<String, Object> transport = new HashMap<>();
    transport.put("displayNameProperties", List.of("webauthn-transport-usb"));

    Map<String, Object> authenticator = new HashMap<>();
    authenticator.put("credentialId", "credentialId");
    authenticator.put("createdAt", "2026-01-15");
    authenticator.put("label", "Security key");
    authenticator.put("transports", transport);

    Map<String, Object> authenticators = new HashMap<>();
    authenticators.put("authenticators", List.of(authenticator));

    Map<String, Object> webAuthn = new HashMap<>();
    webAuthn.put("attestationConveyancePreference", "not specified");
    webAuthn.put("authenticatorAttachment", "platform");
    webAuthn.put("authenticators", authenticators);
    webAuthn.put("challenge", "challenge");
    webAuthn.put("execution", "execution");
    webAuthn.put("createTimeout", "60000");
    webAuthn.put("enableWebAuthnConditionalUI", true);
    webAuthn.put("excludeCredentialIds", "");
    webAuthn.put("isUserIdentified", "true");
    webAuthn.put("mediation", "conditional");
    webAuthn.put("requireResidentKey", "not specified");
    webAuthn.put("rpId", "localhost");
    webAuthn.put("rpEntityName", "Keywind");
    webAuthn.put("shouldDisplayAuthenticators", true);
    webAuthn.put("signatureAlgorithms", "");
    webAuthn.put("userId", "userid");
    webAuthn.put("userVerification", "preferred");
    webAuthn.put("userVerificationRequirement", "preferred");
    webAuthn.put("username", "user@example.com");

    return webAuthn;
  }

  private static Map<String, Object> createX509Model() {
    Map<String, Object> formData = new HashMap<>();
    formData.put("isUserEnabled", "true");
    formData.put("subjectDN", "CN=User, C=US, O=Keywind");
    formData.put("username", "ada");

    Map<String, Object> x509 = new HashMap<>();
    x509.put("formData", formData);

    return x509;
  }
}
