modalController = ($scope, $uibModalInstance, patientService, header, data, checkOutService)->
  $scope.header    = header

  #if this one is needed when the data can update
  $scope.refreshData = ()->
    $scope.data.check_out_steps.forEach (element, index, value)->
      $scope.sortedStep[element.step] = element

  if header is 'PROCESS'
    $scope.processes = data[1]
    $scope.data = data[0]
    $scope.sortedStep = new Array($scope.processes.length)
    $scope.refreshData()
  else
    $scope.data = data

  $scope.confirm   = ()->
    confirm = $scope.checkbox and 'reserve' or null
    $uibModalInstance.close(confirm or 'confirmed')

  $scope.close     = ()->
    $uibModalInstance.dismiss('cancel')

  $scope.startProcess = (process)->
    send = {
      "step": process,
      "admit_id": $scope.data.id
    }
    checkOutService.start.save(send)

  $scope.resetProcess = (process)->
    checkOutService.reset.delete({id:$scope.data.check_out_steps[process].id})

  $scope.endProcess = (process)->
    checkOutService.stop.update({id:$scope.data.check_out_steps[process].id})

modalController
  .$inject = ['$scope', '$uibModalInstance', 'patientService', 'header', 'data', 'checkOutService']

angular.module('app').controller('modalController', modalController)