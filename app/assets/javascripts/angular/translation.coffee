angular.module('app').config ($translateProvider) ->
  $translateProvider.useSanitizeValueStrategy null
  $translateProvider.preferredLanguage 'th'
  $translateProvider.registerAvailableLanguageKeys ['en', 'th']

  $translateProvider.useStaticFilesLoader {
    prefix: '/assets/angular/translation/'
    suffix: '.json'
  }

  return