BedStatusController = ($uibModal, $anchorScroll, admitService, checkOutService, roomService, sessionService, $rootScope)->
  @session = sessionService
  ########### Pre-assign variable if it's referred ############
  if sessionService.admit
    @queue = sessionService.admit
    sessionService.admit = null

  ############## Methods for interact with Rails ##############
  @clear = =>
    @queue = null

  @move = (room)=>
    @queue = room.admit

  confirmModal = (queue, header)->
    $uibModal.open {
      templateUrl : 'templates/modals/bed-status-modal.html'
      controller  : 'modalController as modalCtrl'
      size        : 'lg'
      resolve:{
        header    : ()-> header
        data      : ()-> queue
      }
    }

  @choose = (room)=>
    if @queue
      confirmModal(@queue, 'CONFIRM_ROOM').result.then (edd)=>
        admitService.admit.update({id: @queue.id}, {room_id: room.id, status: 2, edd: edd}).$promise.then =>
          @queue = null
    else
      $uibModal.open({
        templateUrl : 'templates/tables/queues.html'
        controller  : 'modalController as queueCtrl'
        size        : 'lg'
        resolve:{
          header    : ()-> 'QUEUE'
          data      : ()-> 'lolololol'
        }
      }).result.then (queue)->
        confirmModal(queue, 'CONFIRM_ROOM').result.then (edd)=>
          console.log(edd)
          admitService.admit.update({id: queue.id}, {room_id: room.id, status: 2, edd: edd})

  @remove = (room)->
    confirmModal(room, 'DELETE').result.then (eiei)=>
      admitService.admit.update({id: room.admit.id}, {status: 1, room_id: null, edd: null})

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

  @delayStay = (room)->
    confirmModal(room,'DELAY_STAY').result.then (remark)->
      newDate = new Date(room.admit.edd)
      newDate.setDate(newDate.getDate()+1)
      admitService.admit.update({id: room.admit.id}, {status: 2, edd: newDate, remark: remark})

  return


BedStatusController.$inject = ['$uibModal', '$anchorScroll', 'admitService', 'checkOutService', 'roomService', 'sessionService', '$rootScope']

angular.module('app').controller('BedStatusController', BedStatusController)