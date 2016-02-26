queueController = ($http, patientService, $location, $rootScope)->
  vm = @
  vm.addRoomData = {}
  vm.prepareDelete = {}
  vm.prepareToAdd = {}
  vm.preparePending = {}
  vm.isEdit = false

  vm.tableColumns = { HN_NUMBER: 'patient.hn', FIRST_NAME: 'patient.first_name', LAST_NAME: 'patient.last_name', APPOINTMENT: 'admitted_date', DIAGNOSIS: 'diagnosis', DOCTOR: 'doctor.name', PHONE: 'patient.phone', STATUS: 'status' }
  vm.sortType = 'admitted_date'
  vm.sortReverse = false
  vm.sortTable = (column)->
    return (if vm.sortReverse then 'fa-caret-up' else 'fa-caret-down') unless column?
    vm.sortType = column
    vm.sortReverse = !vm.sortReverse

  vm.isQueue = $location.path() != '/status'
  vm.isAlone = $location.path() == '/queue'

  vm.getQueues = ()->
    $http.get('/resources/admits/queue.json').success((data)->
      vm.qData = data
    )
    return

  vm.state = $location.path()
  vm.getQueues()

  vm.choose = (item)->
    if vm.isQueue
      patientService.clear()
      patientService.add(item)
    return

  vm.prepareData = (item)->
    vm.addRoomData.wardName = patientService.listWard()[0].name
    vm.addRoomData.roomName = patientService.listRoom()[0].number
    vm.addRoomData.doctor = item.doctor
#    vm.addRoomData.edd = null
    vm.addRoomData.room = patientService.listRoom()[0].id
    vm.addRoomData.first_name = item.patient.first_name
    vm.addRoomData.last_name = item.patient.last_name
#    vm.addRoomData.doctor_value = item.doctor_id
    vm.addRoomData.symptom = item.diagnosis
    vm.prepareToAdd.patient_id = item.patient.hn
    vm.prepareToAdd.id = item.id
    vm.prepareToAdd.admitted_date = (new Date).toISOString()
    vm.prepareToAdd.status = 2
    vm.prepareToAdd.room_id = patientService.listRoom()[0].id
    return

  vm.confirm = ()->
    $http(
      method: 'PUT',
      url: '/resources/admits/'+vm.prepareToAdd.id+'.json',
      data: vm.prepareToAdd
    ).then(()->
      $rootScope.$emit('refreshStatusTable')
      vm.getQueues()
    )
    return

  $rootScope.$on('refreshQueueTable', ()->
    vm.getQueues()
    $rootScope.$emit('refreshStatusTable')
    return
  )

  vm.changeStatus = (item)->
    item.status = 1
    item.id = parseInt(item.id)
    item.doctor_id = item.doctor_id
    item.patient_id = parseInt(item.patient.hn)
    $http(
      method: 'PUT',
      url: '/resources/admits/'+item.id+'.json'
      data: item
    ).then(->
      vm.getQueues()
    )
    return

  vm.deleteQueue = (item)->
    vm.prepareDelete = item
    vm.prepareDelete.status = 0
    vm.prepareDelete.doctor = item.doctor
    vm.prepareDelete.first_name = item.patient.first_name
    vm.prepareDelete.last_name = item.patient.last_name
    vm.prepareDelete.symptom = item.diagnosis
    vm.prepareDelete.patient = item.patient.hn
    return

  vm.backToPending = (item)->
    item.status = 0
    item.id = parseInt(item.id)
    item.doctor_id = item.doctor_id
    item.patient_id = parseInt(item.patient.hn)
    $http(
      method: 'PUT',
      url: '/resources/admits/'+item.id+'.json'
      data: item
    ).success((data)->
      vm.getQueues()
    )
    return

  vm.delete = ()->
    $http(
      method: 'DELETE',
      url: '/resources/admits/'+vm.prepareDelete.id+'.json',
    ).success((data)->
      vm.getQueues()
    )
    return
  return

queueController
  .$inject = ['$http','patientService','$location','$rootScope']

angular.module('app').controller('queueController', queueController)