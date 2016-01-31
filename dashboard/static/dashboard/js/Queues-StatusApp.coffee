QueuesController = ($http, patientService, queuesService)->
  vm = @
#  $http.get(static_url+'dashboard/SampleJson/queues.json').success((data)->
#    vm.qData = queuesData
#  )
  vm.choose = (item)->
    patientService.clear()
    patientService.add(item)
    return
  vm.qData = queuesService.list()[0]
  console.log("loaded")
  return

BedStatusController = ($http, djangoUrl, patientService)->
  vm = @
  vm.wards = []
  if patientService.list().length is 0 then vm.eiei = false
  else
    vm.ispatientService = true
    vm.firstName = 'First name: '+patientService.list()[0].firstname
    vm.lastName = 'Last name: '+patientService.list()[0].lastname
    vm.symptom = 'Symptom: '+patientService.list()[0].symptom
    vm.doctor = 'Doctor: '+patientService.list()[0].doctor
  $http.get(djangoUrl.reverse('fetch-ward')).success (data)->
    vm.wards = data
    return
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

queuesService = ($http)->
  queues = []
  queuesItem = {}
  $http.get(static_url+'dashboard/SampleJson/queues.json').success((data)->
    queues.push(data.queues)
    console.log("data loaded")
    console.log(queues[0])
    return
  )
  queuesItem.list = ()->
    return queues
  return queuesItem

BedStatusController
  .$inject = ['$http','djangoUrl','patientService']

QueuesController
  .$inject = ['$http','patientService','queuesService']

queuesService
  .$inject = ['$http']

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
