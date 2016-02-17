angular.module('app').config ($translateProvider)->

  $translateProvider.translations('en', {
    'HOME': 'Home',
    'QUEUE': 'Queue',
    'FOO': 'eiei'
  })

  $translateProvider.translations('th-TH', {
    'HOME': 'หน้าแรก',
    'QUEUE': 'คิว',
    'FOO': 'อิอิ'
  })

  $translateProvider.preferredLanguage('th-TH')
  return