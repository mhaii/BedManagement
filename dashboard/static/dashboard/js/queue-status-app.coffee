QueuesController = ($http, patientService, queuesService)->
  vm = @
  queuesDataPromise = queuesService.get()
  queuesDataPromise.then((data)->
    vm.qData = data.queues
    console.log("load")
  )
  vm.choose = (item)->
    patientService.clear()
    patientService.add(item)
    return

  return

BedStatusController = ($http, djangoUrl, patientService)->
  vm = @
  vm.wards = []
  if patientService.list().length is 0 then vm.isPatientData = false
  else
    vm.isPatientData = true
    vm.firstName = 'First name: '+patientService.list()[0].firstname
    vm.lastName = 'Last name: '+patientService.list()[0].lastname
    vm.symptom = 'Symptom: '+patientService.list()[0].symptom
    vm.doctor = 'Doctor: '+patientService.list()[0].doctor

  $http.get(djangoUrl.reverse('ward-list')).success (data)->
    vm.wards = data
    for ward in vm.wards
      $http.get(djangoUrl.reverse('ward-rooms', {'pk': ward.id})).success (data)->
        ward.rooms = data
        return
    return

  console.log(vm.wards)

  vm.onHover = (room)->
    console.log(room)
    return

  vm.onOutHover = ()->
    return
  return

patientService = ()->
  items = []
  itemsService = {}
  itemsService.add = (item)->
    items.push(item)
    console.log(items)
    return
  itemsService.list = ()->
    return items
  itemsService.clear = ()->
    items = []
    return
  return itemsService

queuesService = ($http, djangoUrl)->
  get = ()->
    return $http({method:"GET", url: djangoUrl.reverse('admit-queue')}).then((data)->
      console.log(data)
      return data.data
    )
  return {get:get}

BedStatusController
  .$inject = ['$http','djangoUrl','patientService']

QueuesController
  .$inject = ['$http','patientService','queuesService']

queuesService
  .$inject = ['$http','djangoUrl']

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
  .factory('patientService',patientService)
  .factory('queuesService',queuesService)
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)
