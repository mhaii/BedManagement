modalController = ($scope, $uibModalInstance, admitService, checkOutService, sessionService, header, data)->
  $scope.header  = header
  $scope.data    = data
  $scope.session = sessionService

  @dateOptions = {
    minDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  switch header
    when 'PROCESS'
      checkAllProcessEnded    = ()->
        for step in data.check_out_steps[..-2]
          unless step.time_ended then return false
        true
      $scope.allProcessEnded  = checkAllProcessEnded()

      $scope.startProcess = (process)-> checkOutService.start.update({id: process.id})
      $scope.resetProcess = (process)-> checkOutService.reset.delete({id: process.id})
      $scope.endProcess   = (process)->
        checkOutService.stop.update({id: process.id})
        if process is data.check_out_steps[-1..][0]
          admitService.admit.update({id: $scope.data.id}, {status: 4}).$promise.then ()->
            $uibModalInstance.dismiss('DONE_DISCHARGE')

      $scope.session.websocket.bind 'check_out', (steps)->
        $scope.allProcessEnded = checkAllProcessEnded()
        $scope.data.check_out_steps = steps
    when 'QUEUE'
      @session       = sessionService
      @referred      = true
      @confirmRoom   = (queue)->
        data = queue
        $uibModalInstance.close(data)
      @toConfirmed = (admit)->
        admitService.admit.update({id: admit.id}, {status: 1})
    when 'CONFIRM_ROOM'
      $scope.data.admit.edd = if $scope.data.admit.edd then new Date($scope.data.admit.edd) else null
    else
      'sth'

  $scope.confirm   = ()=>
    confirm = @checkbox and 'reserve' or null
    $uibModalInstance.close(confirm or $scope.data.admit? and $scope.data.admit.edd or @remark or 'confirmed')

  $scope.close     = ()->
    $uibModalInstance.dismiss('cancel')

  return


modalController.$inject = ['$scope', '$uibModalInstance', 'admitService', 'checkOutService', 'sessionService', 'header', 'data']

angular.module('app').controller('modalController', modalController)