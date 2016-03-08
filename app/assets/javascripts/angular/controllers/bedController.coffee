BedStatusController = ($uibModal, $anchorScroll, admitService, checkOutService, roomService, sessionService, $rootScope)->
  @session = sessionService
  ########### Pre-assign variable if it's referred ############
  if sessionService.admit
    @queue = sessionService.admit
    sessionService.admit = null

  ########################### Modals ##########################
  confirmModal = (header, data=null)->
    $uibModal.open {
      templateUrl : 'templates/modals/bed-status-modal.html'
      controller  : 'modalController as modalCtrl'
      resolve     : {
        header  : ()-> header
        data    : ()-> data
      }
    }

  queueModal = ()->
    $uibModal.open {
      templateUrl : 'templates/tables/queues.html'
      controller  : 'modalController as queueCtrl'
      size        : 'lg'
      resolve     : {
        header  : ()-> 'QUEUE'
        data    : ()-> 'lol'
      }
    }

  ############## Methods for interact with Rails ##############

  @clear  =       =>  @queue = null
  @move   = (room)=>  @queue = room.admit

  @choose = (room)=>
    modal = (queue)=>
      confirmModal('CONFIRM_ROOM', {admit: queue, room: room}).result.then (edd)=>
        console.log edd
        admitService.admit.update({id: @queue.id}, {room_id: room.id, status: 2, edd: sessionService.UTCDateTime(edd)}).$promise.then =>
          @queue = null if @queue
    if @queue then modal(@queue) else queueModal().result.then (queue)-> modal(queue)

  @remove = (room)->
    confirmModal('DELETE', room).result.then =>
      admitService.admit.update({id: room.admit.id}, {status: 1, room_id: null, edd: null})

  @checkOutModal = (room)->
    confirmModal('CHECK_THIS_PATIENT_OUT', room).result.then ->
      admitService.admit.update({id: room.admit.id}, {status: 3})

  @delayStay = (room)->
    confirmModal('DELAY_STAY', room).result.then (remark)->
      newDate = new Date(room.admit.edd)
      newDate.setDate(newDate.getDate()+1)
      admitService.admit.update({id: room.admit.id}, {edd: newDate, remark: remark})

  #################### ICU and back again. ####################

  @toICU = (room)->
    confirmModal('CONFIRM_TO_ICU', room).result.then (result)->
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

  return


BedStatusController.$inject = ['$uibModal', '$anchorScroll', 'admitService', 'checkOutService', 'roomService', 'sessionService', '$rootScope']

angular.module('app').controller('BedStatusController', BedStatusController)