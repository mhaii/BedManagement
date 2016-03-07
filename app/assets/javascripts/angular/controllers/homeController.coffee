homeController = ($scope, sessionService) ->
  $scope.session = sessionService

homeController.$inject = ['$scope', 'sessionService']

angular.module('app').controller('homeController', homeController)