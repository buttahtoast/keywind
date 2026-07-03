import type { Meta, StoryObj } from '@storybook/html';

const meta: Meta = {
  title: 'Atoms/Card',
  tags: ['autodocs'],
  render: (args: any) => {
    const header = args.showHeader
      ? `<div class="space-y-4 text-center">
          <div class="font-bold text-center text-2xl">Keywind</div>
          <h1 class="text-center text-xl">Sign in to your account</h1>
        </div>`
      : '';

    const content = args.showContent
      ? `<div class="space-y-5">
          <p class="text-[var(--kw-text-muted)] text-sm">This is example card content. It can contain forms, alerts, buttons, etc.</p>
          <button class="bg-primary-600 text-white px-5 py-3 text-sm flex font-medium justify-center relative rounded-2xl transition-all w-full focus:outline-none focus:ring-2 focus:ring-primary-500/40">Example Action</button>
        </div>`
      : '';

    const footer = args.showFooter
      ? `<div class="border-t border-[var(--kw-border)] pt-5 space-y-4 text-sm text-[var(--kw-text-muted)]">
          <div>Footer area for links or secondary actions.</div>
        </div>`
      : '';

    return `
      <div class="w-full max-w-md">
        <div class="bg-[var(--kw-surface)] p-8 rounded-2xl shadow-xl shadow-black/5 dark:shadow-black/20 space-y-6">
          ${header}
          ${content}
          ${footer}
        </div>
      </div>
    `;
  },
};

export default meta;
type Story = StoryObj;

export const Basic: Story = {
  args: { showContent: true },
};

export const WithHeader: Story = {
  args: { showHeader: true, showContent: true },
};

export const WithFooter: Story = {
  args: { showHeader: true, showContent: true, showFooter: true },
};

export const Empty: Story = {};
