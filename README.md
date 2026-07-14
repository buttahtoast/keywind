# :wind_face: Keywind

Keywind is a component-based Keycloak Login Theme built with [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss) and [Alpine.js](https://github.com/alpinejs/alpine).

![Preview](./preview.png)

### Styled Pages

- Error
- Login
- Login Config TOTP
- Login IDP Link Confirm
- Login OAuth Grant
- Login OTP
- Login Page Expired
- Login Password
- Login Recovery Authn Code Config
- Login Recovery Authn Code Input
- Login Reset Password
- Login Update Password
- Login Update Profile
- Login Username
- Login X.509 Info
- Logout Confirm
- Register
- Select Authenticator
- Terms and Conditions
- WebAuthn Authenticate
- WebAuthn Error
- WebAuthn Register

### Identity Provider Icons

- Apple
- Bitbucket
- Discord
- Facebook
- GitHub
- GitLab
- Google
- Instagram
- LinkedIn
- Microsoft
- OpenID
- Red Hat OpenShift
- PayPal
- Slack
- Stack Overflow
- Twitter

## Installation

Keywind has been designed with component-based architecture from the start, and **you can customize as little or as much Keywind as you need**:

1. [Deploy Keywind Login Theme](https://www.keycloak.org/docs/latest/server_development/#deploying-themes)
2. [Create your own Login Theme](https://www.keycloak.org/docs/latest/server_development/#creating-a-theme)
3. Specify parent theme in [theme properties](https://www.keycloak.org/docs/latest/server_development/#theme-properties):

```
parent=keywind
```

4. Brand and customize components with [FreeMarker](https://freemarker.apache.org/docs/dgui_quickstart_template.html)

## Customization

### Theme

When you do need to customize a palette, you can configure your colors under the `colors` key in the `theme` section of Tailwind config file:

`tailwind.config.js`

```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: colors.red,
      },
    },
  },
};
```

Read more about Tailwind CSS configuration in the [documentation](https://tailwindcss.com/docs/configuration).

### Components

You can update Keywind components in your own child theme. For example, create a copy of the `body` component and change the background:

`theme/mytheme/login/components/atoms/body.ftl`

```
<#macro kw>
  <body class="bg-primary-100">
    <#nested>
  </body>
</#macro>
```

## Local UI preview (mock)

You can verify every login page **without a Keycloak server**. FreeMarker templates are rendered with a mock data model into static HTML; Vite serves those pages and hot-reloads CSS/JS.

### Prerequisites

- **Node.js** 20+ (npm or pnpm)
- **Java 21 + Maven**, *or* **Docker** (used automatically if Maven is missing)

### Quick start

```bash
npm install          # or: pnpm install
npm run mock:generate
npm run dev
```

Then open [http://localhost:5173/](http://localhost:5173/) — an index lists every mock page (login, register, OTP, WebAuthn, …).

| Script | What it does |
| --- | --- |
| `npm run mock:generate` | Render `theme/keywind/login/**/*.ftl` → `html/login/*.html` + `html/index.html` |
| `npm run dev` | Start Vite on port 5173 (HMR for `src/index.css` / `src/index.ts`) |
| `npm run preview:ui` | Generate mocks, then start Vite |
| `npm test` | Same as `mock:generate` (Maven/Docker FreeMarker tests) |

After you change FreeMarker templates or mock data (`src/test/java/.../LoginDataModel.java`), re-run `mock:generate`. CSS/JS-only changes only need `dev` (HMR).

### How it works

1. `LoginThemeTest` / `AccountThemeTest` load Keycloak base messages and each FreeMarker template.
2. Templates are processed with mock models (`LoginDataModel`, `AccountDataModel`).
3. Output is written under `html/login/` and `html/account/` with asset URLs pointing at Vite (`/src/index.css`, `/src/index.ts`).
4. `npm run dev` serves those pages so humans or agents can screenshot and click through the UI.

Mock generation uses local `mvn test` when Maven is installed; otherwise it runs the same tests in `maven:3.9-eclipse-temurin-21` via Docker.

### Login vs Account

| | Login | Account |
| --- | --- | --- |
| Production | FreeMarker templates (`theme/keywind/login`) | Keycloak Account Console **v3 SPA** restyled by `keywind-account.css` / `keywind-account.js` (`parent=keycloak.v3`) |
| Local mocks | Full page set under `html/login/` | FreeMarker Account Console under `html/account/` (design reference; not served by Keycloak) |

**Real Keycloak account:** set Account theme to `keywind` in Realm settings. The SPA keeps working; Keywind injects palette, landscape background, de-branding, and cleaner cards/nav.

**Local FreeMarker account mocks** (`npm run dev` → `/html/account/`) are for UI design only and are not used at `/realms/.../account`.

## Build

When you're ready to deploy your own theme, run the build command to generate a static production build.

```bash
pnpm install
pnpm build
```

To deploy a theme as an archive, create a JAR archive with the theme resources.

```bash
pnpm build:jar
```
