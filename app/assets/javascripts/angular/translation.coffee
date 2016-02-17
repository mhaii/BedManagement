angular.module('app').config ($translateProvider)->
  $translateProvider.translations('en', {
    'Hello': 'Hello',
    'FOO': 'This is a paragraph'
  })

  $translateProvider.translations('th-TH', {
    'Hello': 'สวัสดี',
    'FOO': 'นี้คือพารากราฟฟฟ เหมือน ยีราฟฟ'
  })

  $translateProvider.preferredLanguage('th-TH')
  return