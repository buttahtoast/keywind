import type { Meta, StoryObj } from '@storybook/html';

type ButtonArgs = {
  color?: 'primary' | 'secondary' | 'ghost';
  size?: 'medium' | 'small';
  disabled?: boolean;
  label: string;
};

const meta: Meta<ButtonArgs> = {
  title: 'Atoms/Button',
  tags: ['autodocs'],
  argTypes: {
    color: {
      control: 'select',
      options: ['primary', 'secondary', 'ghost'],
    },
    size: {
      control: 'select',
      options: ['medium', 'small'],
    },
    disabled: { control: 'boolean' },
    label: { control: 'text' },
  },
  args: {
    label: 'Sign In',
  },
  render: (args) => {
    const colorClass =
      args.color === 'secondary'
        ? 'bg-[var(--kw-surface)] border border-[var(--kw-border)] text-[var(--kw-text)] hover:bg-[var(--kw-surface-muted)] hover:border-[var(--kw-border-strong)]'
        : args.color === 'ghost'
        ? 'bg-transparent text-[var(--kw-text-muted)] hover:bg-[var(--kw-surface-muted)] hover:text-[var(--kw-text)]'
        : 'bg-primary-600 text-white hover:bg-primary-700 active:bg-primary-800';

    const sizeClass = args.size === 'small' ? 'px-3 py-2 text-xs' : 'px-5 py-3 text-sm';

    const disabledAttr = args.disabled ? 'disabled' : '';

    return `
      <button
        class="${colorClass} ${sizeClass} flex font-medium gap-2 items-center justify-center relative rounded-2xl transition-all w-full focus:outline-none focus:ring-2 focus:ring-primary-500/40"
        ${disabledAttr}
      >
        ${args.label}
      </button>
    `;
  },
};

export default meta;
type Story = StoryObj<ButtonArgs>;

export const Primary: Story = {};

export const Secondary: Story = {
  args: { color: 'secondary', label: 'Cancel' },
};

export const Ghost: Story = {
  args: { color: 'ghost', label: 'Try Another Way' },
};

export const Small: Story = {
  args: { size: 'small', label: 'Small Button' },
};

export const Disabled: Story = {
  args: { disabled: true, label: 'Disabled' },
};
