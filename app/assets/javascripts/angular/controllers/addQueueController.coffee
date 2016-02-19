addQueuesCtrl = ($http,searchService,$window,$state)->
  vm = @
  patient = false
  vm.isNotSearch = true
  vm.isNotFoundPatient = false
  vm.admitInfo = {
    doctor_id: null,
    status: 0,
    admitted_date: '',
    diagnosis: ''
    patient_id: 0
    room_id: null
  }

  vm.search = ()->
    vm.patientInfo = {
      hn : parseInt(vm.patientInfo.hn)
      first_name: '',
      last_name: '',
      phone: '',
      sex:0,
      age:'',
    }
    searchService.get({id: vm.patientInfo.hn}).$promise.then((user)->
      vm.isNotSearch = false
      if user.error
        console.log(user)
        vm.isNotFoundPatient = true
      else
        console.log(user)
        patient = true
        vm.patientInfo.first_name = user.first_name
        vm.patientInfo.last_name = user.last_name
        vm.patientInfo.phone = user.phone
        vm.admitInfo.patient_id = parseInt(vm.patientInfo.hn)
        vm.isNotFoundPatient = false
    )
    return

  vm.addToQueue = ()->
    if patient
      vm.admitInfo.admitted_date = vm.admitInfo.admitted_date+'T00:00:00.00Z'
      vm.admitInfo.doctor_id = parseInt(vm.admitInfo.doctor_id)
      $http(
        method: 'POST',
        url: '/resources/admits.json',
        data: vm.admitInfo
      ).then((data)->
        $state.go('queue')
        return
      )
    else
      $http(
        method: 'POST',
        url: '/resources/patients.json'
        data: vm.patientInfo
      ).then(->
        vm.admitInfo.patient_id = parseInt(vm.patientInfo.hn)
        vm.admitInfo.admitted_date = vm.admitInfo.admitted_date+'T00:00:00.00Z'
        vm.admitInfo.doctor_id = parseInt(vm.admitInfo.doctor_id)
        console.log(vm.admitInfo)
        $http(
          method: 'POST',
          url: '/resources/admits.json',
          data: vm.admitInfo
        ).then((data)->
          $state.go('queue')
          return
        )
      )
    return
  return

addQueuesCtrl
  .$inject = ['$http','searchService','$window','$state']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)