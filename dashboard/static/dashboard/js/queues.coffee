QueuesController = (MainService)->
  vm = @
  vm.qData = []

  MainService.getQueuesData().then (data)->
    console.log(data)
    vm.qData = data.queues
    return
   ,(error)->
    return

  vm.choose = (item)->
    console.log(item)
    return

  return

QueuesController
  .$inject = ['MainService']

angular
  .module('QueuesApp',['globalApp'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('QueuesController', QueuesController)

