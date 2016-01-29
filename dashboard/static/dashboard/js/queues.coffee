QueuesController = ($http)->
  vm = @
  vm.qData = []

  $http.get(static_url+'dashboard/SampleJson/queues.json').success (data)->
    vm.qData = data.queues
    return

  vm.choose = (item)->
    console.log(item)
    return

  return

BedStatusController = ()->


QueuesController
  .$inject = ['$http']

angular
  .module('QueuesApp',['ui.router'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
  .config ($stateProvider) ->
    $stateProvider.state("check-out",{
      url: "",
      controller: "QueuesController as Queues"
      templateUrl: "queues"
    })
    $stateProvider.state("choose-bed",{
      url: "/choose-bed",
      controller: "bedStatusController as bedCtrl"
      templateUrl: "status"
    })
    return
  .config ($urlRouterProvider) ->
     $urlRouterProvider.otherwise('/')
     return
  .controller('QueuesController', QueuesController)
  .controller('BedStatusController', BedStatusController)

