addQueuesCtrl = ($state, $filter, admitService, patientService)->
  vm = @
  vm.dateOptions = {
    dateDisabled: null,
    minDate: new Date(),
    startingDay: 1
  }

  # if editing, set as searched and found
  if vm.searched    = vm.patientFound  = vm.editing = !!vm.patientInfo = patientService.admit
    vm.admit        = patientService.admit
    patientService.admit = null

  vm.search = ()->
    vm.searched = true
    patientService.patient.get({id: vm.admit.patient.hn}).$promise.then (patient)->
      vm.admit = { patient: if vm.patientFound = !patient.error then patient else null }

  vm.submit = ()->
    vm.admit.admitted_date = $filter('date')(vm.admit.admitted_date, 'yyyy-MM-dd')

    unless vm.patientFound
      patientService.patients.save(vm.admit.patient).$promise.then ()->
        vm.patientFound = true

    if vm.patientFound
      # create new if this page isn't referred for edit
      admit = if vm.editing then admitService.admit.update({id: vm.admit.id}, vm.admit) else admitService.admits.save(vm.admit)

      admit.$promise.then (data)->
        $state.go('queue')
        return
    return

  return

addQueuesCtrl
  .$inject = ['$state', '$filter', 'admitService', 'patientService']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)