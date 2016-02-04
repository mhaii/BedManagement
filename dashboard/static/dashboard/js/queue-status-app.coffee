QueuesController = ($http, patientService, queuesService)->
  vm = @
  queuesDataPromise = queuesService.get()
  queuesDataPromise.then((data)->
    vm.qData = data
  )
  vm.choose = (item)->
    patientService.clear()
    patientService.add(item)
    return
  return

#####################################################################################

BedStatusController = ($http, djangoUrl, patientService, wardService, roomService)->
  vm = @

  if patientService.list().length is 0 then vm.isPatientData = false
  else
    vm.isPatientData = true
    vm.firstName = 'First name: '+patientService.list()[0].patient.first_name
    vm.lastName = 'Last name: '+patientService.list()[0].patient.last_name
    vm.symptom = 'Symptom: '+patientService.list()[0].symptom
    vm.doctor = 'Doctor: '+patientService.list()[0].doctor

  vm.rooms = {}
  vm.wards = wardService.query()
  vm.wards.$promise.then((results)->
    angular.forEach results, (ward)->
      vm.rooms[ward.id] = roomService.query({id: ward.id})
      return
    return
  )

  vm.onHover = (room)->
    console.log(room)
    return

  vm.onOutHover = ()->
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
    return
  return itemsService

#####################################################################################

queuesService = ($http, djangoUrl)->
  get = ()->
    return $http({method:"GET", url: djangoUrl.reverse('admit-queue')}).then((data)->
      return data.data
    )
  return {get:get}

#####################################################################################

roomService = ($resource)->
  $resource('/api/wards/:id/rooms',{},{
    query:{method: "GET", isArray: true}
  })

#####################################################################################

wardService = ($resource, djangoUrl)->
  $resource(djangoUrl.reverse('ward-list'))

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
  .module('QueuesApp',['ng.django.urls','ui.router','ngResource'])
  .config ($interpolateProvider, $stateProvider, $urlRouterProvider) ->
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
    return
  .factory('patientService', patientService)
  .factory('queuesService', queuesService)
  .factory('wardService', wardService)
  .factory('roomService', roomService)
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)
