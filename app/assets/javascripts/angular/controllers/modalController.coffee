modalController = ($scope, $uibModalInstance, checkOutService, sessionService, header, data)->
  $scope.header  = header
  $scope.session = sessionService
  console.log sessionService.admit

  switch header
    when 'PROCESS'
      $scope.session.websocket.bind 'check_out', (steps)->
        $scope.session.admit.check_out_steps = steps
    else
      $scope.data  = data

  $scope.confirm   = ()->
    confirm = $scope.checkbox and 'reserve' or null
    $uibModalInstance.close(confirm or 'confirmed')

  $scope.close     = ()->
    $uibModalInstance.dismiss('cancel')

  ###### Check-out modal ######
  $scope.startProcess = (process)->
    checkOutService.start.update({id:process.id})

  $scope.endProcess   = (process)->
    checkOutService.stop.update({id:process.id})

  $scope.resetProcess = (process)->
    checkOutService.reset.delete({id:process.id})
  return


modalController.$inject = ['$scope', '$uibModalInstance', 'checkOutService', 'sessionService', 'header', 'data']

angular.module('app').controller('modalController', modalController)