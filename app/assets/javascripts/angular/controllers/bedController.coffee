BedStatusController = ($uibModal, $anchorScroll, admitService, checkOutService, roomService, wardService, sessionService)->
  @session = sessionService
  ############ Preassign variable if its referred #############
  if sessionService.admit
    @queue = sessionService.admit
    sessionService.admit = null

  ############## Methods for interact with Rails ##############
  @clear = =>
    @queue = null

  @move = (room)=>
    @queue = room.admit

  @choose = (room)=>
    if @queue
      admitService.admit.update({id: @queue.id}, {room_id: room.id, status: 2}).$promise.then =>
        @queue = null
    else
      $uibModal.open({
        templateUrl : 'templates/tables/queues.html'
        controller  : 'queueController as queueCtrl'
        size        : 'lg'
      }).result.then (queue)->
        admitService.admit.update({id: queue.id}, {room_id: room.id, status: 2})

  @remove = (room)->
    admitService.admit.update({id: room.admit.id}, {status: 1, room_id: null})

  @toICU = (room)->
    $uibModal.open({
      templateUrl : 'templates/modals/bed-status-modal.html'
      controller  : 'modalController as modalCtrl'
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

  @backFromICU = (admit)=>
    if admit.room_id?
      admitService.admit.update({id: admit.id}, {status: 2})
    else
      @queue = admit

  @checkOutModal = (room)->
    $uibModal.open({
      templateUrl : 'templates/modals/bed-status-modal.html'
      controller  : 'modalController as modalCtrl'
      resolve     : {
        header    : ()-> 'CHECK_THIS_PATIENT_OUT'
        data      : ()-> room
      }
    }).result.then (queue)->
      admitService.admit.update({id: room.admit.id}, {status: 3})

  return


BedStatusController.$inject = ['$uibModal', '$anchorScroll', 'admitService', 'checkOutService', 'roomService', 'wardService', 'sessionService']

angular.module('app').controller('BedStatusController', BedStatusController)