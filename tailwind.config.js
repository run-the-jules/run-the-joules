module.exports = {

  purge: {
    enabled: true,
    content: [
      './**/*.html'
    ]},
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      'display': ['Roboto'],
       'body': ['Roboto Slab']
    },
    colors: {
      red: {
        DEFAULT: '#7F1D1D'
      }
    }
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
