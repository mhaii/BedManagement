checkOutController = (checkOutService, $uibModal, admitService)->
  @processes = ['CHECK_OUT_DC', 'CHECK_OUT_APPOINTMENT', 'CHECK_OUT_GET_MED', 'CHECK_OUT_RETURN_MED',
                'CHECK_OUT_CONTACT_FAM', 'CHECK_OUT_BILLING', 'CHECK_OUT_NOTIFY_FINANCE', 'CHECK_OUT_INFORM_BILLING',
                'CHECK_OUT_PAYMENT', 'CHECK_OUT_CONTACT_TRANS', 'CHECK_OUT_PATIENT_LEAVE']

  @getList   = ()=>
    checkOutService.list.query().$promise.then (patient)=>
      @patients = patient

  @getList()

  @updateModal = (data)=>
    $uibModal.open {
      animation   : true,
      templateUrl : 'templates/modals/check-out-modal.html',
      controller  : 'modalController as modalCtrl',
      size        : 'lg',
      resolve     : {
        header    : ()-> 'PROCESS'
        data      : ()=> [data , @processes]
      }
    }

  return

checkOutController
  .$inject = ['checkOutService', '$uibModal', 'admitService']

angular.module('app').controller('checkOutController', checkOutController)