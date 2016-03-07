checkOutController = (checkOutService, $uibModal, sessionService)->
  @session = sessionService

  @updateModal = (data) =>
    $uibModal.open {
      animation   : true,
      templateUrl : 'templates/modals/check-out-modal.html',
      controller  : 'modalController as modalCtrl',
      size        : 'lg',
      resolve     : {
        header    : ()-> 'PROCESS'
        data      : ()-> data
      }
    }

  return

checkOutController
  .$inject = ['checkOutService', '$uibModal', 'sessionService']

angular.module('app').controller('checkOutController', checkOutController)