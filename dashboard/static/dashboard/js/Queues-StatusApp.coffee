QueuesController = ($http, patientData)->
  vm = @
  vm.qData = []
  $http.get(static_url+'dashboard/SampleJson/queues.json').success((data)->
    console.log("load")
    vm.qData = data.queues
  )
  vm.choose = (item)->
    patientData.clear()
    patientData.add(item)
    return
  return

BedStatusController = ($http, djangoUrl, patientData)->
  vm = @
  vm.wards = []
  if patientData.list().length is 0 then vm.eiei = false
  else
    vm.isPatientData = true
    vm.firstName = 'First name: '+patientData.list()[0].firstname
    vm.lastName = 'Last name: '+patientData.list()[0].lastname
    vm.symptom = 'Symptom: '+patientData.list()[0].symptom
    vm.doctor = 'Doctor: '+patientData.list()[0].doctor
  $http.get(djangoUrl.reverse('fetch-ward')).success (data)->
    vm.wards = data
    return
  vm.onHover = (room)->
    console.log(room)
    return

  vm.onOutHover = ()->
    return
  return

patientData = ()->
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


BedStatusController
  .$inject = ['$http','djangoUrl','patientData']

QueuesController
  .$inject = ['$http','patientData']

angular
  .module('QueuesApp',['ng.django.urls','ui.router'])
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
  .factory('patientData',patientData)
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)
