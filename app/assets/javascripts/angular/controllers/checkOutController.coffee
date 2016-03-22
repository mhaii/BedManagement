checkOutController = ($uibModal, checkOutService, sessionService)->
  @session = sessionService
  @stepIcon = checkOutService.icon

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
  .$inject = ['$uibModal', 'checkOutService', 'sessionService']

angular.module('app').controller('checkOutController', checkOutController)