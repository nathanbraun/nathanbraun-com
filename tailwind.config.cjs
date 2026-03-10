/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {},
    fontFamily: {
      sans: ['IBM Plex Sans'],
      header: ['Roboto'],
    },
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      'xxl': '1536px',
      'xxxl': '1920px',
      'xxxxl': '2200px',
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
