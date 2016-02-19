queueController = ($http, patientService, $location, $scope)->
  vm = @
  vm.addRoomData = {}
  vm.prepareDelete = {}
  vm.preparePending = {}

  if $location.path() == '/'
    vm.isQueue = true
  else
    vm.isQueue = false

  vm.getQueues = ()->
    $http.get('/resources/admits/queue.json').success((data)->
      console.log(data)
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
    vm.addRoomData.doctor = item.doctor_r.key
    vm.addRoomData.patient = item.patient.hn
    vm.addRoomData.admit_date = (new Date).toISOString()
    vm.addRoomData.edd = null
    vm.addRoomData.room = patientService.listRoom()[0].id
    vm.addRoomData.status = 2
    vm.addRoomData.id = item.id
    vm.addRoomData.first_name = item.patient.first_name
    vm.addRoomData.last_name = item.patient.last_name
    vm.addRoomData.doctor_value = item.doctor_r.value
    vm.addRoomData.symptom = item.symptom
    return

  vm.confirm = ()->
    $http(
      method: 'PUT',
      url: '/api/admits/'+vm.addRoomData.id+'/',
      data: vm.addRoomData
    ).then(()->
      $scope.$broadcast('refreshStatusTable')
      vm.getQueues()
    )
    return

  $scope.$on('refreshQueueTable', ()->
    vm.getQueues()
    $scope.$broadcast('refreshStatusTable')
    return
  )

  vm.toReadAble = (dateItem)->
    console.log(dateItem)

  vm.changeStatus = (item)->
    item.status = (parseInt(item.status_r.key)+1).toString()
    item.doctor = item.doctor_r.key
    item.patient = item.patient.hn
    $http(
      method: 'PUT',
      url: '/api/admits/'+item.id+'/'
      data: item
    ).then(->
      vm.getQueues()
    )
    return

  vm.deleteQueue = (item)->
    vm.prepareDelete = item
    vm.prepareDelete.status = 0
    vm.prepareDelete.doctor = item.doctor_r.key
    vm.prepareDelete.first_name = item.patient.first_name
    vm.prepareDelete.last_name = item.patient.last_name
    vm.prepareDelete.symptom = item.symptom
    vm.prepareDelete.patient = item.patient.hn
    return

  vm.backToPending = (item)->
    item.status = 0
    item.doctor = item.doctor_r.key
    item.patient = item.patient.hn
    $http(
      method: 'PUT',
      url: '/api/admits/'+item.id+'/'
      data: item
    ).success((data)->
      vm.getQueues()
    )
    return

  vm.delete = ()->
    $http(
      method: 'DELETE',
      url: '/api/admits/'+vm.prepareDelete.id+'/',
    ).success((data)->
      vm.getQueues()
    )
    return

  return

queueController
  .$inject = ['$http','patientService','$location','$scope']

angular.module('app').controller('queueController', queueController)