QueuesController = ($http, patientService, queuesService)->
  vm = @

  vm.getQueues = ()->
    $http.get('/api/admits/queue_detail/').success((data)->
      vm.qData = data
    )
    return

  vm.getQueues()

  vm.choose = (item)->
    patientService.clear()
    patientService.add(item)
    return

  vm.toReadAble = (dateItem)->
    console.log(dateItem)

  vm.confirm = (item)->
    return

  vm.changeStatus = (item)->
    item.status = (parseInt(item.status_r.key)+1).toString()
    item.doctor = item.doctor_r.key
    item.patient = item.patient.hn
    console.log(item)
    $http(
      method: 'PUT',
      url: '/api/admits/'+item.id+'/'
      data: item
    ).then(->
      vm.getQueues()
    )
    return

  return

#####################################################################################

BedStatusController = ($http, djangoUrl, patientService, wardService)->
  vm = @

  if patientService.list().length is 0
  then vm.isPatientData = false
  else
    vm.isPatientData = true
    vm.firstName = 'First name: '+patientService.list()[0].patient.first_name
    vm.lastName = 'Last name: '+patientService.list()[0].patient.last_name
    vm.symptom = 'Symptom: '+patientService.list()[0].symptom
    vm.doctor = 'Doctor: '+patientService.list()[0].doctor_r.value

  vm.wards = wardService.query()

  vm.addToRoom = (ward, room)->
    if vm.isPatientData
      patientService.list()[0].patient = patientService.list()[0].patient.hn
      patientService.list()[0].doctor = patientService.list()[0].doctor_r.key
      patientService.list()[0].edd = null
      patientService.list()[0].admit_date = (new Date).toISOString()
      patientService.list()[0].room = room.id
      patientService.list()[0].status = 2

      $http(
        method: 'PUT',
        url: '/api/admits/'+patientService.list()[0].id+'/',
        data: patientService.list()[0]
      ).then((data)->
        window.location.href = 'http://127.0.0.1:8000/status/#/!'
      )
    return

  return

#####################################################################################

patientService = ()->
  items = []
  itemsService = {}
  itemsService.add = (item)->
    items.push(item)
    return
  itemsService.list = ()->
    items
  itemsService.clear = ()->
    items = []
  itemsService

#####################################################################################

queuesService = ($resource, djangoUrl)->
  {
    getQueues: $resource(url: djangoUrl.reverse('admit-queue-detail'))
  }

#####################################################################################

roomService = ($resource, djangoUrl)->
  $resource(djangoUrl.reverse('ward-rooms')+'&djng_url_kwarg_pk=:id')

#####################################################################################

wardService = ($resource, djangoUrl)->
  $resource(djangoUrl.reverse('ward-with-rooms'))

#####################################################################################

BedStatusController
  .$inject = ['$http','djangoUrl','patientService', 'wardService', 'roomService']

QueuesController
  .$inject = ['$http','patientService','queuesService']

queuesService
  .$inject = ['$http','djangoUrl']

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
  .factory('queuesService', queuesService)
  .factory('wardService', wardService)
  .factory('roomService', roomService)
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)
