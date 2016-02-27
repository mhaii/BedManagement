BedStatusController = ($rootScope, $http, patientService, wardService, $location , $anchorScroll)->
  vm = @
  vm.icuPatients = {}
  vm.wards = wardService.query()
  vm.check = false
  vm.getIcuPatient = ()->
    $http(
      method: 'GET',
      url: '/resources/admits/in_icu.json'
    ).then((data)->
      vm.icuPatients = data.data
    )
    return

  vm.getIcuPatient()

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
        vm.symptom = patientService.list()[0].diagnosis
        vm.doctor = patientService.list()[0].doctor_id
      else
        vm.firstName = patientService.list()[0].patient.first_name
        vm.lastName = patientService.list()[0].patient.last_name
        vm.symptom = patientService.list()[0].diagnosis
        vm.doctor = patientService.list()[0].doctor_id

  vm.checkPatientData()

  vm.getWards = ()->
    wardService.query().$promise.then((data)->
      vm.wards = data
      return
    )
    return

  $rootScope.$on('refreshStatusTable', ()->
    vm.getWards()
    return
  )

  vm.isChecked = ()->
    if vm.check
      vm.check = false
    else
      vm.check = true

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
        $http(
          method: 'PUT',
          url: '/resources/admits/'+data.id+'.json',
          data: data
        ).then(()->
          vm.isPatientData = false
          patientService.clear()
          vm.getIcuPatient()
          vm.getWards()
        )
      else
        patientService.list()[0].patient_id = patientService.list()[0].patient.hn
        patientService.list()[0].admitted_date = (new Date).toISOString()
        patientService.list()[0].room_id = patientService.listRoom()[0].id
        patientService.list()[0].status = 2
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

  vm.movePatient = (room, type, dir) ->
    if dir
      patientService.clear()
      patientService.add(room.admit)
      patientService.list()[0].first_name = room.patient.first_name
      patientService.list()[0].last_name = room.patient.last_name
      #    patientService.list()[0].edd = null
      patientService.list()[0].admitted_date = (new Date).toISOString()
      if type == 'move'
        vm.isPatientData = true
        patientService.list()[0].move = true
        vm.checkPatientData()
        patientService.list()[0].room_id = null
      else
        vm.firstName = patientService.list()[0].first_name
        vm.lastName = patientService.list()[0].last_name
        vm.symptom = patientService.list()[0].diagnosis
        vm.doctor = patientService.list()[0].doctor_id
        vm.wardName = patientService.listWard()[0].name
        vm.roomName = patientService.listRoom()[0].number
        if type == 'icu'
          patientService.list()[0].status = -1
        else
          patientService.list()[0].status = 1
          patientService.list()[0].room_id = null
    else
      patientService.clear()
      patientService.add(room)
      patientService.list()[0].first_name = room.patient.first_name
      patientService.list()[0].last_name = room.patient.last_name
      patientService.list()[0].admitted_date = (new Date).toISOString()
      vm.firstName = patientService.list()[0].first_name
      vm.lastName = patientService.list()[0].last_name
      vm.symptom = patientService.list()[0].diagnosis
      vm.doctor = patientService.list()[0].doctor_id
      if room.room_id != null
        patientService.clearRoom()
        patientService.addRoom(room.room)
        patientService.listRoom()[0].status = 2
        vm.roomName = patientService.listRoom()[0].number
        $http(
          method: 'GET',
          url:'/resources/wards/'+patientService.listRoom()[0].ward_id+'.json'
        ).success((data)->
          vm.ward = data.name
          patientService.clearWard()
          patientService.addWard(data.data)
        )
      else
        patientService.clear()
        patientService.add(room)
        patientService.list()[0].first_name = room.patient.first_name
        patientService.list()[0].last_name = room.patient.last_name
        #    patientService.list()[0].edd = null
        patientService.list()[0].admitted_date = (new Date).toISOString()
        vm.isPatientData = true
        patientService.list()[0].move = true
        vm.checkPatientData()
        $location.hash('bed-status-all')
        $anchorScroll()
    return

  vm.deletePatient = ()->
    $http(
      method: 'PUT',
      url: '/resources/admits/'+patientService.list()[0].id+'.json',
      data: patientService.list()[0]
    ).then((data)->
      patientService.clear()
      $rootScope.$broadcast('refreshQueueTable')
    )

  vm.toICU = ()->
    if vm.check
      patientService.listRoom()[0].status = -1

      $http(
        method: 'PUT',
        url: '/resources/admits/'+patientService.list()[0].id+'.json',
        data: patientService.list()[0]
      ).then((data)->
        patientService.clear()
        $http(
          method: 'PUT',
          url: '/resources/rooms/'+patientService.listRoom()[0].id+'.json',
          data: patientService.listRoom()[0]
        ).then((data)->
          patientService.clear()
          vm.getIcuPatient()
          $rootScope.$broadcast('refreshQueueTable')
        )
      )
    else
      patientService.list()[0].room_id = null
      $http(
        method: 'PUT',
        url: '/resources/admits/'+patientService.list()[0].id+'.json',
        data: patientService.list()[0]
      ).then((data)->
        patientService.clear()
        patientService.listRoom()[0].status = 0
        $http(
          method: 'PUT',
          url: '/resources/rooms/'+patientService.listRoom()[0].id+'.json',
          data: patientService.listRoom()[0]
        ).then((data)->
          patientService.clear()
          vm.getIcuPatient()
          $rootScope.$broadcast('refreshQueueTable')
        )
      )
  vm.backFromICU = ()->
    if patientService.list()[0].room_id != null
      patientService.list()[0].status = 2
      $http(
        method: 'PUT',
        url: '/resources/admits/'+patientService.list()[0].id+'.json',
        data: patientService.list()[0]
      ).then((data)->
        patientService.clear()
        $http(
          method: 'PUT',
          url: '/resources/rooms/'+patientService.listRoom()[0].id+'.json',
          data: patientService.listRoom()[0]
        ).then((data)->
          patientService.clear()
          vm.getIcuPatient()
          $rootScope.$broadcast('refreshQueueTable')
          $location.hash('bed-status-all')
          $anchorScroll()
        )
      )
  source = new EventSource('/bed_refresh')
  source.addEventListener('message', vm.getWards(), false)
  return



BedStatusController
  .$inject = ['$rootScope','$http','patientService', 'wardService','$location','$anchorScroll']

angular.module('app').controller('BedStatusController',BedStatusController)