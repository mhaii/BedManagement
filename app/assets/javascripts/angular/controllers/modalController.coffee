modalController = ($scope, $uibModalInstance, patientService, header, data)->
  $scope.header   = header
  $scope.data     = data

  $scope.confirm  = ()->
    confirm = $scope.checkbox and 'reserve' or null
    $uibModalInstance.close(confirm or 'confirmed')

  $scope.close    = ()->
    $uibModalInstance.dismiss('cancel')


modalController
  .$inject = ['$scope', '$uibModalInstance', 'patientService', 'header', 'data']

angular.module('app').controller('modalController', modalController)