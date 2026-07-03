import type { Preview } from '@storybook/html';
import Alpine from 'alpinejs';

// Make Alpine available globally for stories using x-data, x-show etc.
(window as any).Alpine = Alpine;
Alpine.start();

// Import the main CSS (Tailwind + custom styles + CSS vars)
import '../src/index.css';

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: '^on[A-Z].*' },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    // Nice backgrounds matching the theme
    backgrounds: {
      default: 'light',
      values: [
        { name: 'light', value: '#fafafa' },
        { name: 'dark', value: '#09090b' },
        { name: 'surface', value: '#ffffff' },
      ],
    },
    // Make it feel like the Keycloak login pages
    layout: 'centered',
  },
  // Make sure Alpine processes new content (for x-data etc in stories)
  decorators: [
    (storyFn, context) => {
      const storyHtml = storyFn();
      // Return a fragment or element
      const wrapper = document.createElement('div');
      wrapper.innerHTML = storyHtml;
      // Re-init Alpine on the newly inserted nodes
      setTimeout(() => {
        if ((window as any).Alpine) {
          (window as any).Alpine.initTree(wrapper);
        }
      }, 0);
      return wrapper;
    },
  ],
};

export default preview;
