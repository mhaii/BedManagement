BedStatusController = ($scope, $http, patientService, wardService)->
  vm = @

  vm.onHover = (item,ward)->
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
        vm.symptom = patientService.list()[0].symptom
        vm.doctor = patientService.list()[0].doctor_r
        vm.wardName = patientService.listWard()[0].name
        vm.roomName = patientService.listRoom()[0].number
      else
        vm.firstName = patientService.list()[0].patient.first_name
        vm.lastName = patientService.list()[0].patient.last_name
        vm.symptom = patientService.list()[0].symptom
        vm.doctor = patientService.list()[0].doctor_r.value

  vm.wards = wardService.query()
  vm.checkPatientData()

  vm.getWards = ()->
    wardService.query().$promise.then((data)->
      console.log(data)
      vm.wards = data
      return
    )
    return

  $scope.$on('refreshStatusTable', ()->
    vm.getWards()
    return
  )

  vm.addToRoom = ()->
    if vm.isPatientData
      if patientService.list()[0].move
        patientService.list()[0].room = patientService.listRoom()[0].id
        patientService.list()[0].status = 2
        $http(
          method: 'PUT',
          url: '/api/admits/'+patientService.list()[0].admitId+'/',
          data: patientService.list()[0]
        ).then((data)->
          vm.isPatientData = false
          patientService.clear()
          vm.getWards()
        )
      else
        patientService.list()[0].patient = patientService.list()[0].patient.hn
        patientService.list()[0].doctor = patientService.list()[0].doctor_r.key
        patientService.list()[0].edd = null
        patientService.list()[0].admit_date = (new Date).toISOString()
        patientService.list()[0].room = patientService.listRoom()[0].id
        patientService.list()[0].status = 2
        $http(
          method: 'PUT',
          url: '/api/admits/'+patientService.list()[0].id+'/',
          data: patientService.list()[0]
        ).then((data)->
          window.location.href = 'http://127.0.0.1:8000/queues/'
        )
    return

  vm.movePatient = (room, move) ->
    patientService.clear()
    patientService.add(room)
    patientService.list()[0].admitId = room.patient.id
    patientService.list()[0].first_name = room.patient.patient.first_name
    patientService.list()[0].last_name = room.patient.patient.last_name
    patientService.list()[0].doctor_r = room.patient.doctor_r.value
    patientService.list()[0].symptom = room.patient.symptom
    patientService.list()[0].doctor = room.patient.doctor_r.key
    patientService.list()[0].patient = room.patient.patient.hn
    patientService.list()[0].edd = null
    patientService.list()[0].admit_date = (new Date).toISOString()
    patientService.list()[0].room = null
    patientService.list()[0].status = 1
    if move
      vm.isPatientData = true
      patientService.list()[0].move = true
      vm.checkPatientData()
    else
      vm.firstName = patientService.list()[0].first_name
      vm.lastName = patientService.list()[0].last_name
      vm.symptom = patientService.list()[0].symptom
      vm.doctor = patientService.list()[0].doctor_r
      vm.wardName = patientService.listWard()[0].name
      vm.roomName = patientService.listRoom()[0].number
    return

  vm.deletePatient = ()->
    $http(
      method: 'PUT',
      url: '/api/admits/'+patientService.list()[0].admitId+'/',
      data: patientService.list()[0]
    ).then((data)->
      $scope.$emit('refreshQueueTable')
    )


  return

BedStatusController
  .$inject = ['$scope','$http','patientService', 'wardService']

angular.module('app').controller('BedStatusController',BedStatusController)