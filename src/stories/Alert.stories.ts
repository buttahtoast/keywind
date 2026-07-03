import type { Meta, StoryObj } from '@storybook/html';

type AlertArgs = {
  color?: 'error' | 'info' | 'success' | 'warning';
  message: string;
};

const meta: Meta<AlertArgs> = {
  title: 'Atoms/Alert',
  tags: ['autodocs'],
  argTypes: {
    color: {
      control: 'select',
      options: ['error', 'info', 'success', 'warning'],
    },
    message: { control: 'text' },
  },
  args: {
    message: 'Something went wrong. Please try again.',
  },
  render: (args) => {
    const colorClass =
      args.color === 'error'
        ? 'bg-red-50 text-red-700 dark:bg-red-950/60 dark:text-red-400'
        : args.color === 'success'
        ? 'bg-emerald-50 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-400'
        : args.color === 'warning'
        ? 'bg-amber-50 text-amber-700 dark:bg-amber-950/60 dark:text-amber-400'
        : 'bg-primary-50 text-primary-700 dark:bg-primary-950/60 dark:text-primary-400';

    return `
      <div class="${colorClass} px-4 py-3 rounded-2xl text-sm" role="alert">
        ${args.message}
      </div>
    `;
  },
};

export default meta;
type Story = StoryObj<AlertArgs>;

export const Info: Story = {};

export const Error: Story = {
  args: {
    color: 'error',
    message: 'Invalid username or password.',
  },
};

export const Success: Story = {
  args: {
    color: 'success',
    message: 'Recovery codes downloaded successfully.',
  },
};

export const Warning: Story = {
  args: {
    color: 'warning',
    message: 'Your session is about to expire.',
  },
};
