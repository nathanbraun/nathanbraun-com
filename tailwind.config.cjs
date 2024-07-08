/** @type {import('tailwindcss').Config} */
module.exports = {
    theme: {
        extend: {},
        fontFamily: {
          sans: ['IBM Plex Sans'],
          header: ['Roboto']
        },
        screens: {
              'sm': '640px',
              // => @media (min-width: 640px) { ... }

              'md': '768px',
              // => @media (min-width: 768px) { ... }

              'lg': '1024px',
              // => @media (min-width: 1024px) { ... }

              'xl': '1280px',
              // => @media (min-width: 1280px) { ... }

              'xxl': '1536px',
              // => @media (min-width: 1536px) { ... }
              'xxxl': '1920px',
              'xxxxl': '2200px',

            }
    },
    variants: [],
    plugins: [
        require("@tailwindcss/typography"),
        require("@tailwindcss/forms"),
        require("@tailwindcss/aspect-ratio")
    ],
}
