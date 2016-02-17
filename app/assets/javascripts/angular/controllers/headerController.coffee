headerController = ($scope,$translate)->
  $scope.changeLanguage = (langKey)->
    $translate.use(langKey)
    return

  $scope.getLanguage = ()->
    return $translate.use()


angular.module('app').controller('headerController', headerController)