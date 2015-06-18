document.addEventListener('DOMContentLoaded', function () {
  if (document.getElementById('search_map')) {
    return require('./pages/search/onload')
  }
  if (document.getElementById('listings-edit-add-vue')) {
    return require('./pages/listings/add-edit/onload')
  }
  if (document.getElementById('lenyt-vue-listings-show')) {
    return require('./pages/listings/show/onload')
  }
  if (document.getElementById('vue-messages')) {
    return require('./pages/messages/onload')
  }
})
