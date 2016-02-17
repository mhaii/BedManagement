angular.module('app').config ($translateProvider) ->
  $translateProvider.preferredLanguage('th')
  $translateProvider.useStaticFilesLoader({
    prefix: '/assets/angular/translation/'
    suffix: '.json'
  })
  $translateProvider.registerAvailableLanguageKeys(['en', 'th'])
  return