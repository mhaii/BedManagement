modalController = ($scope, $uibModalInstance, checkOutService, sessionService, header, data)->
  $scope.header  = header
  $scope.data  = data
  $scope.session = sessionService

  @dateOptions = {
    minDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  switch header
    when 'PROCESS'
      console.log data
      $scope.session.websocket.bind 'check_out', (steps)->
        $scope.data.check_out_steps = steps
    when 'QUEUE'
      @session       = sessionService
      @referred      = true
      @tableColumns   = [['HN_NUMBER', 'patient.hn'], ['NAME', 'patient.first_name'], ['DIAGNOSIS', 'diagnosis'],
        ['APPOINTMENT', 'admitted_date'], ['DOCTOR', 'doctor.name'], ['PHONE', 'patient.phone'], ['STATUS', 'status']]
    when 'CONFIRM_ROOM'
      $scope.data.admit = data
    else
      'sth'

  @confirmRoom  = (queue)->
    data = queue or null
    $uibModalInstance.close(data)

  $scope.confirm   = ()=>
    confirm = $scope.checkbox and 'reserve' or null
    edd     = @edd or null
    console.log()
    $uibModalInstance.close(confirm or edd or 'confirmed')

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