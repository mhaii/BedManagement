checkOutController = (checkOutService, $uibModal, admitService)->
  vm        = @

  vm.processes = ["CHECK_OUT_DC","CHECK_OUT_APPOINTMENT","CHECK_OUT_GET_MED","CHECK_OUT_RETURN_MED","CHECK_OUT_CONTACT_FAM","CHECK_OUT_BILLING","CHECK_OUT_NOTIFY_FINANCE","CHECK_OUT_INFORM_BILLING","CHECK_OUT_PAYMENT","CHECK_OUT_CONTACT_TRANS","CHECK_OUT_PATIENT_LEAVE"]

  vm.getList   = ()->
    checkOutService.list.query().$promise.then (patient)->
      console.log(patient)
      vm.patients = patient

  vm.getList()

  vm.updateModal = (data)->
    $uibModal.open {
      animation   : true,
      templateUrl : 'templates/modals/check-out-modal.html',
      controller  : 'modalController as modalCtrl',
      size        : "lg",
      resolve     : {
        header    : ()-> 'PROCESS'
        data      : ()->  [data , vm.processes]
      }
    }

  admitService.websocket.bind 'check_out', (admit)->
    vm.getList()

  return

checkOutController
  .$inject = ['checkOutService', '$uibModal', 'admitService']

angular.module('app').controller('checkOutController', checkOutController)