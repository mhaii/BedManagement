BedStatusController = ($rootScope, $http, $location, $uibModal, $anchorScroll, admitService, patientService, roomService, wardService)->
  vm = @

  if patientService.admit
    vm.queue = patientService.admit
    patientService.admit = null

  vm.clear = ()->
    vm.queue = null

  vm.getWards = ()->
    wardService.all.query().$promise.then (data)->
      vm.wards = data

  vm.getIcuPatient = ()->
    admitService.in_icu.query().$promise.then (data)->
      vm.icuPatients = data

  vm.getWards()
  vm.getIcuPatient()

  vm.move = (room)->
    vm.queue = room.admit

  vm.choose = (room)->
    if vm.queue
      admitService.admit.update({id: vm.queue.id}, {room_id: room.id, status: 2}).$promise.then ()->
        vm.queue = null
    else
      $uibModal.open({
        templateUrl : 'templates/tables/queues.html',
        controller  : 'queueController as queueCtrl',
        size        : 'lg'
      }).result.then ()->
        admitService.admit.update({id: patientService.admit.id}, {room_id: room.id, status: 2})
        patientService.admit = null

  vm.remove = (room)->
    admitService.admit.update({id: room.admit.id}, {status: 1, room_id: null})

  vm.toICU = (room)->
    $uibModal.open({
      templateUrl : 'templates/modals/bed-status-modal.html',
      controller  : 'modalController as modalCtrl',
      resolve     : {
        header    : ()-> 'CONFIRM_TO_ICU'
        data      : ()-> room
      }
    }).result.then (result)->
      if result is 'reserve'
        roomService.room.update({id: room.id}, {status: -1}).$promise.then ()->
          admitService.admit.update({id: room.admit.id}, {status: -1}).$promise.then null, ()->
            roomService.room.update({id: room.id}, {status: 0}) # prevent ghost occupant
      else
        admitService.admit.update({id: room.admit.id}, {status: -1, room_id: null})

  vm.backFromICU = (admit)->
    if admit.room_id?
      admitService.admit.update({id: admit.id}, {status: 2})
    else
      vm.queue = admit


  admitService.websocket.bind 'updated', (admit)->
    vm.getWards()

  admitService.websocket.bind 'icu', (admit)->
    vm.getIcuPatient()

  return


BedStatusController
  .$inject = ['$rootScope', '$http', '$location', '$uibModal', '$anchorScroll', 'admitService', 'patientService', 'roomService', 'wardService']

angular.module('app').controller('BedStatusController', BedStatusController)