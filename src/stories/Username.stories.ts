import type { Meta, StoryObj } from '@storybook/html';

const meta: Meta = {
  title: 'Molecules/Username',
  tags: ['autodocs'],
  render: () => `
    <div class="bg-[var(--kw-surface-muted)] flex items-center justify-between mb-2 px-4 py-2.5 rounded-2xl text-sm w-full max-w-md">
      <span class="font-medium text-[var(--kw-text)]">user@example.com</span>
      <a
        class="text-primary-600 hover:text-primary-700"
        href="#"
        title="Restart login"
      >
        <!-- arrow-top-right-on-square icon -->
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
        </svg>
      </a>
    </div>
  `,
};

export default meta;
type Story = StoryObj;

export const Default: Story = {};
