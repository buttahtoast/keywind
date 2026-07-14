import { defineConfig, type Plugin } from 'vite';
import { readdirSync, existsSync } from 'fs';
import { join } from 'path';

/**
 * Map production dist/*.js script tags (from FreeMarker) to Vite source modules
 * so local preview gets HMR instead of stale built assets.
 */
const DIST_TO_SRC: Record<string, string> = {
  '/dist/index.js': '/src/index.ts',
  '/dist/index.css': '/src/index.css',
  '/dist/passkeys.js': '/src/data/passkeys.ts',
  '/dist/recoveryCodes.js': '/src/data/recoveryCodes.ts',
  '/dist/webAuthnAuthenticate.js': '/src/data/webAuthnAuthenticate.ts',
  '/dist/webAuthnRegister.js': '/src/data/webAuthnRegister.ts',
};

function keywindMockPreview(): Plugin {
  return {
    name: 'keywind-mock-preview',
    configureServer(server) {
      server.middlewares.use((req, res, next) => {
        if (!req.url) {
          next();
          return;
        }

        const path = req.url.split('?')[0];

        if (path === '/' || path === '/index.html') {
          res.statusCode = 302;
          res.setHeader('Location', '/html/index.html');
          res.end();
          return;
        }

        const mapped = DIST_TO_SRC[path];
        if (mapped) {
          const qs = req.url.includes('?') ? req.url.slice(req.url.indexOf('?')) : '';
          req.url = mapped + qs;
        }

        next();
      });

      const loginDir = join(process.cwd(), 'html/login');
      const accountDir = join(process.cwd(), 'html/account');
      const loginPages = existsSync(loginDir)
        ? readdirSync(loginDir).filter((f) => f.endsWith('.html')).length
        : 0;
      const accountPages = existsSync(accountDir)
        ? readdirSync(accountDir).filter((f) => f.endsWith('.html')).length
        : 0;
      if (loginPages + accountPages > 0) {
        console.log(
          `\n  Keywind UI mocks: login=${loginPages} account=${accountPages} → http://localhost:5173/\n`,
        );
      } else {
        console.warn('\n  No html mocks found. Run: npm run mock:generate\n');
      }
    },
  };
}

/**
 * Local UI preview server.
 *
 * - Serves FreeMarker mock HTML from html/
 * - HMR for src CSS/TS (linked by mock properties + dist→src rewrite)
 * - Index at / lists every login page mock
 *
 * Workflow:
 *   npm run mock:generate   # render FTL → html/login/*.html (Java/Maven or Docker)
 *   npm run dev             # open http://localhost:5173/
 */
export default defineConfig({
  appType: 'mpa',
  publicDir: false,
  server: {
    port: 5173,
    strictPort: false,
    open: '/html/index.html',
    fs: {
      allow: ['.'],
    },
  },
  plugins: [keywindMockPreview()],
  build: {
    rollupOptions: {
      input: [
        'src/index.ts',
        'src/data/passkeys.ts',
        'src/data/recoveryCodes.ts',
        'src/data/webAuthnAuthenticate.ts',
        'src/data/webAuthnRegister.ts',
      ],
      output: {
        assetFileNames: '[name][extname]',
        dir: 'theme/keywind/login/resources/dist',
        entryFileNames: '[name].js',
      },
    },
  },
});
