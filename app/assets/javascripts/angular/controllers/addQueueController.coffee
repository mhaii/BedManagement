addQueuesCtrl = ($state, $http, $window, admitService, patientService,$filter)->
  vm = @

  vm.dateOptions = {
    dateDisabled: null,
    minDate: new Date(),
    startingDay: 1
  }

  vm.openDateTime = ()->
    vm.opened = true
    return

  # if editing, set as searched and found
  if vm.searched    = vm.patientFound   = !!vm.admit.patient = patientService.admit
    vm.admit    = patientService.admit
    vm.admit.patient  = patientService.admit.patient

  vm.search = ()->
    patientService.patient.get({id: vm.admit.patient.hn}).$promise.then (patient)->
      vm.searched     = true
      vm.admit.patient  = if vm.patientFound = !patient.error then patient else null

  vm.submit = ()->
    vm.admit.admitted_date = $filter('date')(vm.admit.admitted_date, 'yyyy-MM-dd')

    console.log vm.admit, admitService
    unless vm.patientFound
      patientService.patients.save(vm.admit.patient.hn).$promise.then ()->
        vm.patientFound = true

    # create new if this page isn't referred for edit
    admitReqType = if patientService.admit then admitService.admit.update({id: vm.admit.id}, vm.admit) else admitService.admits.save(vm.admit)

    vm.admit.patient_id = vm.admit.patient.hn
    admitReqType.$promise.then (data)->
      patientService.admit = null
      $state.go('queue')
      return
    return
  return

addQueuesCtrl
  .$inject = ['$state', '$http', '$window', 'admitService', 'patientService', '$filter']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)