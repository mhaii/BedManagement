translationController = ($scope, $translate, $state) ->
  $scope.changeLanguage = (lang) ->
    $translate.use(lang)

  $scope.getLanguage = ->
    $translate.use()

angular.module('app').controller('translationController', translationController)