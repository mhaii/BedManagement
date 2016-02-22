addQueuesCtrl = ($http,searchService,$window,$state, patientService)->
  vm = @
  patient = false
  vm.isNotSearch = true
  vm.isNotFoundPatient = false
  vm.admitInfo = {
    id: null,
    doctor_id: null,
    status: 0,
    admitted_date: '',
    diagnosis: ''
    patient_id: 0
    room_id: null
  }

  if patientService.list()[0]
    vm.patientInfo = {
      hn : null,
      first_name: '',
      last_name: '',
      phone: '',
      sex:0,
      age:'',
    }
    patient = true
    vm.isNotSearch = false
    vm.patientInfo.hn = patientService.list()[0].patient.hn
    vm.patientInfo.first_name = patientService.list()[0].patient.first_name
    vm.patientInfo.last_name = patientService.list()[0].patient.last_name
    vm.admitInfo.diagnosis = patientService.list()[0].diagnosis
    vm.patientInfo.age = patientService.list()[0].patient.age
    vm.patientInfo.phone = patientService.list()[0].patient.phone
    vm.admitInfo.doctor_id = patientService.list()[0].doctor_id
    vm.admitInfo.admitted_date = patientService.list()[0].admitted_date
    vm.admitInfo.id = patientService.list()[0].id
    vm.admitInfo.patient_id = patientService.list()[0].patient.hn
    vm.isNotFoundPatient = false

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
      if vm.admitInfo.id
        vm.admitInfo.admitted_date = vm.admitInfo.admitted_date
        $http(
          method: 'PUT',
          url: '/resources/admits/'+vm.admitInfo.id+'.json',
          data: vm.admitInfo
        ).then((data)->
          patientService.clear()
          $state.go('queue')
          return
        )
      else
        delete vm.admitInfo.id
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
  .$inject = ['$http','searchService','$window','$state', 'patientService']

angular.module('app').controller('addQueuesCtrl', addQueuesCtrl)