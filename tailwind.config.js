/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./App.{js, jsx, ts, tsx}",
    "./src/**/*.{js, jsx, ts, tsx}",
    "./src/screens/**/index.tsx",
  ],
  theme: {
    extend: {
      colors:{
        background: '#09090a'
      }
    },
  },
  plugins: [],
}
