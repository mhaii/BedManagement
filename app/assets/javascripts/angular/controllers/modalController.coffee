modalController = ($scope, $uibModalInstance, admitService, checkOutService, sessionService, header, data)->
  $scope.header  = header
  $scope.data    = data
  $scope.session = sessionService

  @dateOptions = {
    minDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }
  checkAllProcessEnd = ()->
    $scope.checkAllProcess = 0
    for i in $scope.data.check_out_steps
      if i.time_ended == null then $scope.checkAllProcess = $scope.checkAllProcess+1

  switch header
    when 'PROCESS'
      $scope.startProcess = (process)-> checkOutService.start.update({id: process.id})
      $scope.endProcess   = (process)-> checkOutService.stop .update({id: process.id})
      $scope.resetProcess = (process)-> checkOutService.reset.delete({id: process.id})
      $scope.endCheckOut  = ()       ->
        admitService.admit.update({id: $scope.data.id}, {status: 4}).$promise.then ()->
          $uibModalInstance.dismiss('DONE_DISCHARGE')
      checkAllProcessEnd()
      $scope.session.websocket.bind 'check_out', (steps)->
        $scope.data.check_out_steps = steps
        checkAllProcessEnd()
    when 'QUEUE'
      @session       = sessionService
      @referred      = true
      @confirmRoom   = (queue)->
        data = queue
        $uibModalInstance.close(data)
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