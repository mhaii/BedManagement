queueController = ($rootScope, $scope, $http, $location, $uibModal, admitService, patientService)->
  vm = @

  vm.tableColumns   = [['HN_NUMBER', 'patient.hn'], ['NAME', 'patient.first_name'], ['DIAGNOSIS', 'diagnosis'],
                       ['APPOINTMENT', 'admitted_date'], ['DOCTOR', 'doctor.name'], ['PHONE', 'patient.phone'], ['STATUS', 'status']]

  vm.sortTable      = (column)->
    return vm.sortReversed and 'fa-caret-up' or 'fa-caret-down' unless column?
    vm.sortType     = column or 'admitted_date'
    vm.sortReversed = !vm.sortReversed or false

  vm.referred       = $location.path() == '/status'
  vm.isAlone        = $location.path() == '/queue'

  vm.update = ()->
    admitService.queue.query().$promise.then (data)-> vm.queues = data
  vm.update()

  vm.choose = (queue)->
    patientService.admit = queue
    $uibModalInstance.close('confirmed') if vm.referred

  vm.toPending = (admit)->
    admitService.admit.update({id: admit.id}, {status: 0})

  vm.toConfirmed = (admit)->
    admitService.admit.update({id: admit.id}, {status: 1})

  vm.openDeleteModal = (queue)->
    $uibModal.open({
      templateUrl : 'templates/modals/queue-modal.html',
      controller  : 'modalController as modalCtrl',
      resolve     : {
        header  : ()-> 'CONFIRM_DELETE'
        data    : ()-> queue
      }
    }).result.then ()->
      admitService.admit.delete({id: queue.id})

  admitService.websocket.bind 'updated', (admit)->
    vm.update()

  admitService.websocket.bind 'destroyed', ()->
    vm.update()

  return

queueController
  .$inject = ['$rootScope', '$scope', '$http', '$location', '$uibModal', 'admitService','patientService']

angular.module('app').controller('queueController', queueController)