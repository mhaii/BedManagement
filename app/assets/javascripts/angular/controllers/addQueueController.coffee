addQueuesCtrl = ($http,searchService,$window)->
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
      hn : vm.patientInfo.hn
      first_name: '',
      last_name: '',
      phone: '',
      sex:'',
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
      console.log(vm.admitInfo)
      $http(
        method: 'POST',
        url: '/resources/admits.json',
        data: vm.admitInfo
      ).then((data)->
        console.log('done')
        window.location.href = '/queues'
        return
      )
    else
      console.log(vm.patientInfo)
      $http(
        method: 'POST',
        url: '/resources/patients.json'
        data: vm.patientInfo.patient
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
          console.log('done')
          window.location.href = '/queues'
          return
        )
      )
    return
  return

addQueuesCtrl
  .$inject = ['$http','searchService','$window']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)