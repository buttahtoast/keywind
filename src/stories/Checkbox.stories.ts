import type { Meta, StoryObj } from '@storybook/html';

const meta: Meta = {
  title: 'Atoms/Checkbox',
  tags: ['autodocs'],
  render: (args: any) => `
    <label class="flex items-center gap-2 text-sm cursor-pointer">
      <input 
        type="checkbox" 
        class="border-[var(--kw-border)] text-primary-600 rounded focus:ring-primary-500/30" 
        ${args.checked ? 'checked' : ''} 
        ${args.disabled ? 'disabled' : ''}
      />
      <span class="text-[var(--kw-text)]">Remember me</span>
    </label>
  `,
};

export default meta;
type Story = StoryObj;

export const Default: Story = {};

export const Checked: Story = {
  render: () => `
    <label class="flex items-center gap-2 text-sm cursor-pointer">
      <input type="checkbox" class="border-[var(--kw-border)] text-primary-600 rounded focus:ring-primary-500/30" checked />
      <span class="text-[var(--kw-text)]">Remember me</span>
    </label>
  `,
};

export const Disabled: Story = {
  render: () => `
    <label class="flex items-center gap-2 text-sm opacity-60">
      <input type="checkbox" class="border-[var(--kw-border)] text-primary-600 rounded focus:ring-primary-500/30" disabled />
      <span class="text-[var(--kw-text)]">Remember me</span>
    </label>
  `,
};
