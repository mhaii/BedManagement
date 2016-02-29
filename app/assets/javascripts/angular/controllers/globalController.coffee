globalController = ($resource, $rootScope, $scope, $translate, $state) ->
  user = $resource('/current_user.json').get()

  $scope.changeLanguage = (lang) ->
    $translate.use(lang)

  $scope.getLanguage = ->
    $translate.use()

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)->
    event.preventDefault() if toState.data.access.indexOf(user.role) < 0

globalController
  .$inject = ['$resource','$rootScope','$scope','$translate','$state']

angular.module('app').controller('globalController', globalController)