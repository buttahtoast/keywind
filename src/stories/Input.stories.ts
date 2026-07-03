import type { Meta, StoryObj } from '@storybook/html';

type InputArgs = {
  label?: string;
  type?: 'text' | 'password' | 'email';
  placeholder?: string;
  invalid?: boolean;
  message?: string;
  disabled?: boolean;
  value?: string;
};

const meta: Meta<InputArgs> = {
  title: 'Atoms/Input',
  tags: ['autodocs'],
  argTypes: {
    type: { control: 'select', options: ['text', 'password', 'email'] },
    label: { control: 'text' },
    invalid: { control: 'boolean' },
    disabled: { control: 'boolean' },
    message: { control: 'text' },
  },
  args: {
    label: 'Username',
    placeholder: 'Enter your username',
  },
  render: (args) => {
    const baseClass =
      'block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm transition-colors';

    const invalidClass = args.invalid
      ? 'border-red-500 focus:border-red-500 focus:ring-red-500/30'
      : '';

    const disabledAttr = args.disabled ? 'disabled' : '';
    const valueAttr = args.value ? `value="${args.value}"` : '';

    let inputHtml = '';

    if (args.type === 'password') {
      // Password with Alpine toggle (works because Alpine is initialized in preview)
      inputHtml = `
        <div class="relative" x-data="{ show: false }">
          <input
            ${disabledAttr}
            aria-invalid="${args.invalid ? 'true' : 'false'}"
            class="${baseClass} ${invalidClass}"
            id="password"
            name="password"
            placeholder="${args.label || 'Password'}"
            :type="show ? 'text' : 'password'"
            ${valueAttr}
          />
          <button
            @click="show = !show"
            aria-controls="password"
            :aria-expanded="show"
            class="absolute right-4 top-3.5 text-[var(--kw-text-subtle)] hover:text-[var(--kw-text-muted)] transition-colors"
            type="button"
          >
            <div x-show="!show">
              <!-- Eye icon -->
              <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 12.5C11.3807 12.5 12.5 11.3807 12.5 10C12.5 8.61929 11.3807 7.5 10 7.5C8.61929 7.5 7.5 8.61929 7.5 10C7.5 11.3807 8.61929 12.5 10 12.5Z" />
                <path clip-rule="evenodd" d="M0.664255 10.5904C0.517392 10.2087 0.517518 9.78563 0.66461 9.40408C2.10878 5.65788 5.7433 3 9.99859 3C14.256 3 17.892 5.66051 19.3347 9.40962C19.4816 9.79127 19.4814 10.2144 19.3344 10.5959C17.8902 14.3421 14.2557 17 10.0004 17C5.74298 17 2.10698 14.3395 0.664255 10.5904ZM14.0004 10C14.0004 12.2091 12.2095 14 10.0004 14C7.79123 14 6.00037 12.2091 6.00037 10C6.00037 7.79086 7.79123 6 10.0004 6C12.2095 6 14.0004 7.79086 14.0004 10Z" fill-rule="evenodd" />
              </svg>
            </div>
            <div x-cloak x-show="show">
              <!-- Eye slash -->
              <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path clip-rule="evenodd" d="M3.28033 2.21967C2.98744 1.92678 2.51256 1.92678 2.21967 2.21967C1.92678 2.51256 1.92678 2.98744 2.21967 3.28033L16.7197 17.7803C17.0126 18.0732 17.4874 18.0732 17.7803 17.7803C18.0732 17.4874 18.0732 17.0126 17.7803 16.7197L16.0352 14.9745C17.5064 13.8594 18.6595 12.3465 19.3344 10.5959C19.4814 10.2144 19.4816 9.79127 19.3347 9.40962C17.892 5.66051 14.256 3 9.99859 3C8.28207 3 6.66657 3.43249 5.2551 4.19444L3.28033 2.21967ZM7.75194 6.69128L8.84367 7.78301C9.18951 7.60223 9.58291 7.5 10.0002 7.5C11.3809 7.5 12.5002 8.61929 12.5002 10C12.5002 10.4173 12.398 10.8107 12.2172 11.1565L13.3091 12.2484C13.7454 11.6077 14.0004 10.8336 14.0004 10C14.0004 7.79086 12.2095 6 10.0004 6C9.16675 6 8.39268 6.25501 7.75194 6.69128Z" fill-rule="evenodd" />
                <path d="M10.7484 13.9302L13.2711 16.4529C12.2462 16.8074 11.1458 17 10.0004 17C5.74298 17 2.10698 14.3395 0.664255 10.5904C0.517392 10.2087 0.517518 9.78563 0.66461 9.40408C1.15603 8.12932 1.90108 6.98057 2.83791 6.01969L6.0702 9.25198C6.02436 9.4943 6.00037 9.74435 6.00037 10C6.00037 12.2091 7.79123 14 10.0004 14C10.256 14 10.5061 13.976 10.7484 13.9302Z" />
              </svg>
            </div>
          </button>
        </div>
      `;
    } else {
      inputHtml = `
        <input
          ${disabledAttr}
          aria-invalid="${args.invalid ? 'true' : 'false'}"
          class="${baseClass} ${invalidClass}"
          id="input"
          name="input"
          placeholder="${args.placeholder || args.label || ''}"
          type="${args.type || 'text'}"
          ${valueAttr}
        />
      `;
    }

    const labelHtml = args.label
      ? `<label class="block text-sm font-medium text-[var(--kw-text)]" for="input">${args.label}</label>`
      : '';

    const messageHtml =
      args.invalid && args.message
        ? `<div class="text-red-500 text-sm">${args.message}</div>`
        : '';

    return `
      <div class="space-y-1.5 w-full max-w-sm">
        ${labelHtml}
        ${inputHtml}
        ${messageHtml}
      </div>
    `;
  },
};

export default meta;
type Story = StoryObj<InputArgs>;

export const Default: Story = {};

export const Password: Story = {
  args: {
    label: 'Password',
    type: 'password',
  },
};

export const Invalid: Story = {
  args: {
    label: 'Email',
    type: 'email',
    invalid: true,
    message: 'Please enter a valid email address.',
    value: 'bad-email',
  },
};

export const Disabled: Story = {
  args: {
    label: 'Username',
    disabled: true,
    value: 'existing-user',
  },
};
