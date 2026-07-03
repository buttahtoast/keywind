import type { Meta, StoryObj } from '@storybook/html';

const meta: Meta = {
  title: 'Examples/Login Page',
  tags: ['autodocs'],
  render: () => `
    <div class="w-full max-w-md">
      <div class="bg-[var(--kw-surface)] p-8 rounded-2xl shadow-xl shadow-black/5 dark:shadow-black/20 space-y-6">
        <!-- Header -->
        <div class="space-y-4 text-center">
          <div class="font-bold text-2xl">Keywind</div>
          <h1 class="text-xl">Sign in to your account</h1>
        </div>

        <!-- Error Alert -->
        <div class="bg-red-50 text-red-700 dark:bg-red-950/60 dark:text-red-400 px-4 py-3 rounded-2xl text-sm" role="alert">
          Invalid username or password.
        </div>

        <form class="m-0 space-y-4" onsubmit="event.preventDefault();">
          <div class="space-y-1.5">
            <label class="block text-sm font-medium text-[var(--kw-text)]" for="username">Username</label>
            <input 
              class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm"
              id="username" type="text" value="demo" />
          </div>

          <div class="space-y-1.5">
            <label class="block text-sm font-medium text-[var(--kw-text)]" for="pw">Password</label>
            <div class="relative" x-data="{ show: false }">
              <input 
                class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-[var(--kw-text)] placeholder:text-[var(--kw-text-subtle)] focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500/30 sm:text-sm"
                id="pw" :type="show ? 'text' : 'password'" value="secret" />
              <button type="button" @click="show = !show" class="absolute right-4 top-3.5 text-[var(--kw-text-subtle)]">
                👁
              </button>
            </div>
          </div>

          <div class="flex items-center justify-between text-sm">
            <label class="flex items-center gap-2">
              <input type="checkbox" class="text-primary-600 rounded" checked /> Remember me
            </label>
            <a href="#" class="text-primary-600 hover:text-primary-500">Forgot Password?</a>
          </div>

          <button type="submit" class="bg-primary-600 hover:bg-primary-700 text-white px-5 py-3 text-sm font-medium flex justify-center w-full rounded-2xl transition-all focus:outline-none focus:ring-2 focus:ring-primary-500/40">
            Sign In
          </button>
        </form>

        <div class="pt-2 separate text-[var(--kw-text-subtle)] text-sm">Or sign in with</div>
        
        <div class="grid grid-cols-3 gap-3">
          <button class="border border-[var(--kw-border)] py-2 rounded-2xl text-xs">Google</button>
          <button class="border border-[var(--kw-border)] py-2 rounded-2xl text-xs">GitHub</button>
          <button class="border border-[var(--kw-border)] py-2 rounded-2xl text-xs">Microsoft</button>
        </div>
      </div>
    </div>
  `,
};

export default meta;
type Story = StoryObj;

export const Default: Story = {};

export const WithPasskeys: Story = {
  render: () => `
    <div class="w-full max-w-md">
      <div class="bg-[var(--kw-surface)] p-8 rounded-2xl shadow-xl shadow-black/5 dark:shadow-black/20 space-y-6">
        <div class="space-y-4 text-center">
          <div class="font-bold text-2xl">Keywind</div>
          <h1 class="text-xl">Sign in</h1>
        </div>

        <div x-data="{}">
          <button class="bg-secondary-100 hover:bg-secondary-200 text-[var(--kw-text)] w-full py-3 rounded-2xl text-sm">
            Sign in with a passkey
          </button>
        </div>

        <div class="text-center text-[var(--kw-text-muted)] text-xs">or</div>

        <form class="space-y-4" onsubmit="event.preventDefault();">
          <input placeholder="Email" class="block w-full rounded-2xl border border-[var(--kw-border)] bg-[var(--kw-surface)] px-4 py-3 text-sm" />
          <button class="bg-primary-600 text-white w-full py-3 rounded-2xl text-sm font-medium">Continue</button>
        </form>
      </div>
    </div>
  `,
};
