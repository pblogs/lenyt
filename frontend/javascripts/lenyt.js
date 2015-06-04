document.addEventListener('DOMContentLoaded', function () {
  if (document.getElementById('search_map')) {
    return require('./pages/search/onload')
  }
  if (document.getElementById('listings-edit-add-vue')) {
    return require('./pages/listings/add-edit/onload')
  }
})
