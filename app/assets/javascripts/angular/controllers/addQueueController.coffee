addQueuesCtrl = ($state, $http, $window, admitService, patientService)->
  vm = @

  # if editing, set as searched and found
  if vm.searched    = vm.patientFound   = !!vm.patientInfo == patientService.admit
    vm.admitInfo    = patientService.admit
    vm.patientInfo  = patientService.admit.patient

  vm.search = ()->
    patientService.patient.get({id: vm.patientInfo.hn}).$promise.then (patient)->
      vm.searched     = true
      vm.patientInfo  = if vm.patientFound = !patient.error then patient else null

  vm.submit = ()->
    console.log vm.admitInfo, admitService
    unless vm.patientFound
      patientService.patients.save(vm.patientInfo).$promise.then ()->
        vm.patientFound = true

    # create new if this page isn't referred for edit
    admit = if patientService.admit then admitService.admit.update({id: vm.admitInfo.id}, vm.admitInfo) else admitService.admits.save(vm.admitInfo)

    vm.admitInfo.patient_id = vm.patientInfo.hn
    console.log vm.admitInfo
    admit.$promise.then (data)->
      patientService.admit = null
      $state.go('queue')
      return
    return
  return

addQueuesCtrl
  .$inject = ['$state', '$http', '$window', 'admitService', 'patientService']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)