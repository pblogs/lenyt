// = require jquery
// = require jquery_ujs
// = require twitter/bootstrap
// = require noframework.waypoints.min
// = require jquery.mCustomScrollbar.concat.min
// = require waypoint_custom
// = require common
// = require owl.carousel

jQuery(function () {
  $('a[rel~=popover], .has-popover').popover()
  return $('a[rel~=tooltip], .has-tooltip').tooltip()
})

jQuery(document).ready(function ($) {
  $('.owl-carousel').owlCarousel({
    items: 5,
    lazyLoad: true,
    navigation: true,
    itemsCustom: false,
    itemsDesktop: [1199, 4],
    itemsDesktopSmall: [980, 3],
    itemsTablet: [768, 2],
    itemsTablet: [1024, 3],
    itemsTablet: [1280, 3],
    itemsTabletSmall: false,
    itemsMobile: [479, 1],
    singleItem: false,
    itemsScaleUp: false
  })
})
