modalController = ($scope, $uibModalInstance, patientService, header)->
  $scope.data   = patientService.admit
  $scope.header = header

  $scope.confirm  = ()->
    $uibModalInstance.close('confirmed');

  $scope.close    = ()->
    $uibModalInstance.dismiss('cancel')


modalController
  .$inject = ['$scope', '$uibModalInstance', 'patientService', 'header']

angular.module('app').controller('modalController', modalController)