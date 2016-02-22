QueuesController = ($http, patientService, $location, $scope)->
  vm = @
  vm.addRoomData = {}
  vm.prepareDelete = {}
  vm.preparePending = {}

  if $location.path() == '/'
    vm.isQueue = true
  else
    vm.isQueue = false

  vm.getQueues = ()->
    $http.get('/api/admits/queue_detail/').success((data)->
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

#####################################################################################

BedStatusController = ($scope, $http, djangoUrl, patientService, wardService)->
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

#####################################################################################

patientService = ()->
  items = []
  rooms = []
  wards = []
  itemsService = {}
  itemsService.add = (item)->
    items.push(item)
    return
  itemsService.list = ()->
    items
  itemsService.clear = ()->
    items = []
    return
  itemsService.addRoom = (item)->
    rooms.push(item)
    return
  itemsService.clearRoom = ()->
    rooms = []
    return
  itemsService.listRoom = ()->
    rooms
  itemsService.addWard = (item)->
    wards.push(item)
    return
  itemsService.clearWard = ()->
    wards = []
    return
  itemsService.listWard = ()->
    wards
  itemsService

#####################################################################################

roomService = ($resource, djangoUrl)->
  $resource(djangoUrl.reverse('ward-rooms')+'&djng_url_kwarg_pk=:id')

#####################################################################################

wardService = ($resource, djangoUrl)->
  $resource(djangoUrl.reverse('ward-with-rooms'))

#####################################################################################

BedStatusController
  .$inject = ['$scope','$http','djangoUrl','patientService', 'wardService', 'roomService']

QueuesController
  .$inject = ['$http','patientService','$location','$scope']

roomService
  .$inject = ['$resource', 'djangoUrl']

wardService
  .$inject = ['$resource', 'djangoUrl']

#####################################################################################

angular
  .module('QueuesApp',['ng.django.urls','ui.router','ngResource','angular-humanize'])
  .config ($interpolateProvider, $stateProvider, $urlRouterProvider,$httpProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')

    $stateProvider.state("check-out",{
      url: "/",
      controller: "QueuesController as qCtrl"
      templateUrl: static_url+"tables/queue-table.html"
    })
    $stateProvider.state("choose-bed",{
      url: "/!",
      controller: "BedStatusController as bedCtrl"
      templateUrl: static_url+"tables/bed-status-table.html"
    })
    $urlRouterProvider.otherwise('/')
    $httpProvider.defaults.xsrfCookieName = 'csrftoken';
    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';
    return
  .factory('patientService', patientService)
  .factory('wardService', wardService)
  .factory('roomService', roomService)
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)
