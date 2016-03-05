queueController = ($injector, $scope, $location, admitService, patientService)->
  ############### Methods and values for table ################
  @tableColumns   = [['HN_NUMBER', 'patient.hn'], ['NAME', 'patient.first_name'], ['DIAGNOSIS', 'diagnosis'],
                     ['APPOINTMENT', 'admitted_date'], ['DOCTOR', 'doctor.name'], ['PHONE', 'patient.phone'], ['STATUS', 'status']]

  @sortTable      = (column)=>
    return @sortReversed and 'fa-caret-up' or 'fa-caret-down' unless column?
    @sortType     = column or 'admitted_date'
    @sortReversed = !@sortReversed or false

  ####### Set condition for views and methods for modal #######
  @isAlone            = $location.path() == '/queue'
  if @referred        = $location.path() == '/status'
    $uibModalInstance = $injector.get '$uibModalInstance'
    @confirmRoom      = (queue)->
      $uibModalInstance.close(queue)
  else
    $uibModal         = $injector.get '$uibModal'
    @openDeleteModal  = (queue)->
      $uibModal.open({
        templateUrl : 'templates/modals/queue-modal.html',
        controller  : 'modalController as modalCtrl',
        resolve     : {
          header  : ()-> 'CONFIRM_DELETE'
          data    : ()-> queue
        }
      }).result.then ()->
        admitService.admit.delete({id: queue.id})

  ############## Methods for interact with Rails ##############
  @choose = (queue)->
    patientService.admit = queue

  @toPending = (admit)->
    admitService.admit.update({id: admit.id}, {status: 0})

  @toConfirmed = (admit)->
    admitService.admit.update({id: admit.id}, {status: 1})


queueController
  .$inject = ['$injector', '$scope', '$location', 'admitService','patientService']

angular.module('app').controller('queueController', queueController)