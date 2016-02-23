BedStatusController = ($rootScope, $http, patientService, wardService)->
  vm = @

  vm.onHover = (item,ward)->
    console.log(item)
    patientService.clearRoom()
    patientService.addRoom(item)
    patientService.clearWard()
    patientService.addWard(ward)
    vm.wardName = patientService.listWard()[0].name
    vm.roomName = patientService.listRoom()[0].number
    return

  vm.checkPatientData = ()->
    if patientService.list().length is 0
    then vm.isPatientData = false
    else
      vm.isPatientData = true
      if patientService.list()[0].move
        vm.firstName = patientService.list()[0].first_name
        vm.lastName = patientService.list()[0].last_name
        vm.symptom = patientService.list()[0].diagnosis
        vm.doctor = patientService.list()[0].doctor_id
        vm.wardName = patientService.listWard()[0].name
        vm.roomName = patientService.listRoom()[0].number
      else
        vm.firstName = patientService.list()[0].patient.first_name
        vm.lastName = patientService.list()[0].patient.last_name
        vm.symptom = patientService.list()[0].diagnosis
        vm.doctor = patientService.list()[0].doctor_id

  vm.wards = wardService.query()
  vm.checkPatientData()

  vm.getWards = ()->
    wardService.query().$promise.then((data)->
      console.log(data)
      vm.wards = data
      return
    )
    return

  $rootScope.$on('refreshStatusTable', ()->
    console.log('bedCtrl')
    vm.getWards()
    return
  )

  vm.addToRoom = ()->
    if vm.isPatientData
      if patientService.list()[0].move
        data = {
          id: patientService.list()[0].id,
          patient_id: patientService.list()[0].patient_id
          room_id: patientService.listRoom()[0].id,
          doctor_id: patientService.list()[0].doctor_id,
          diagnosis: patientService.list()[0].diagnosis,
          admitted_date: patientService.list()[0].admitted_date,
          status: 2
        }
        console.log(data)
        $http(
          method: 'PUT',
          url: '/resources/admits/'+data.id+'.json',
          data: data
        ).then(()->
          vm.isPatientData = false
          patientService.clear()
          vm.getWards()
        )
      else
        patientService.list()[0].patient_id = patientService.list()[0].patient.hn
        delete patientService.list()[0].patient
        patientService.list()[0].admitted_date = (new Date).toISOString()
        patientService.list()[0].room_id = patientService.listRoom()[0].id
        patientService.list()[0].status = 2
        console.log(patientService.list()[0])
        $http(
          method: 'PUT',
          url: '/resources/admits/'+patientService.list()[0].id+'.json',
          data: patientService.list()[0]
        ).then((data)->
          patientService.clear()
          vm.checkPatientData()
          vm.getWards()
        )
    return

  vm.movePatient = (room, move) ->
    patientService.clear()
    patientService.add(room.admit)
    patientService.list()[0].first_name = room.patient.first_name
    patientService.list()[0].last_name = room.patient.last_name
#    patientService.list()[0].edd = null
    patientService.list()[0].admitted_date = (new Date).toISOString()
    patientService.list()[0].room_id = null
#    patientService.list()[0].status = 1
    if move
      vm.isPatientData = true
      patientService.list()[0].move = true
      vm.checkPatientData()
    else
      vm.firstName = patientService.list()[0].first_name
      vm.lastName = patientService.list()[0].last_name
      vm.symptom = patientService.list()[0].diagnosis
      vm.doctor = patientService.list()[0].doctor_id
      vm.wardName = patientService.listWard()[0].name
      vm.roomName = patientService.listRoom()[0].number
    return

  vm.deletePatient = ()->
    $http(
      method: 'PUT',
      url: '/resources/admits/'+patientService.list()[0].admitId+'.json',
      data: patientService.list()[0]
    ).then((data)->
      $rootScope.$broadcast('refreshQueueTable')
    )


  return

BedStatusController
  .$inject = ['$rootScope','$http','patientService', 'wardService']

angular.module('app').controller('BedStatusController',BedStatusController)