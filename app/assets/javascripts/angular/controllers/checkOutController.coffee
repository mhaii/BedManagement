checkOutController = (checkOutService, $uibModal, sessionService)->
  @session = sessionService

  @updateModal = (data) =>
    @session.admit = (checkout for checkout in sessionService.checkouts when data is checkout)[0]
    $uibModal.open({
      animation   : true,
      templateUrl : 'templates/modals/check-out-modal.html',
      controller  : 'modalController as modalCtrl',
      size        : 'lg',
      resolve     : {
        header    : ()-> 'PROCESS'
        data      : ()-> 'in sessionService.admit'
      }
    }).closed.then ->
      sessionService.admit = null

  return

checkOutController
  .$inject = ['checkOutService', '$uibModal', 'sessionService']

angular.module('app').controller('checkOutController', checkOutController)