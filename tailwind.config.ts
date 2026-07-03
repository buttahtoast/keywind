import type { Config } from 'tailwindcss';
import colors from 'tailwindcss/colors';

export default {
  content: [
    './theme/**/*.ftl',
    './src/**/*.{html,js,ts,jsx,tsx}',
    './.storybook/**/*.{html,js,ts,jsx,tsx}',
  ],
  darkMode: 'media',
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          'Inter',
          'ui-sans-serif',
          'system-ui',
          '-apple-system',
          'BlinkMacSystemFont',
          'Segoe UI',
          'sans-serif',
        ],
      },
      colors: {
        primary: {
          50: 'var(--kw-primary-50)',
          100: 'var(--kw-primary-100)',
          200: 'var(--kw-primary-200)',
          300: '#93c5fd',
          400: '#60a5fa',
          500: 'var(--kw-primary-500)',
          600: 'var(--kw-primary-600)',
          700: 'var(--kw-primary-700)',
          800: '#1e40af',
          900: '#1e3a8a',
        },
        secondary: colors.zinc,

        provider: {
          apple: '#000000',
          bitbucket: '#0052CC',
          discord: '#5865F2',
          facebook: '#1877F2',
          github: '#181717',
          gitlab: '#FC6D26',
          google: '#4285F4',
          instagram: '#E4405F',
          linkedin: '#0A66C2',
          microsoft: '#5E5E5E',
          oidc: '#F78C40',
          openshift: '#EE0000',
          paypal: '#00457C',
          slack: '#4A154B',
          stackoverflow: '#F58025',
          twitter: '#1DA1F2',
        },
      },
      boxShadow: {
        card: '0 10px 15px -3px rgb(0 0 0 / 0.05), 0 4px 6px -4px rgb(0 0 0 / 0.05)',
        'card-dark': '0 10px 15px -3px rgb(0 0 0 / 0.2), 0 4px 6px -4px rgb(0 0 0 / 0.2)',
      },
    },
  },
} satisfies Config;