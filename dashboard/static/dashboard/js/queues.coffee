QueuesController = (myService)->
  vm = @
  vm.qData = []
  myService.getQueuesData().then (data)->
#    console.log(data.queues)
    vm.qData = data.queues
    return
  vm.choose = (item)->
    console.log(item)
    return
  return

QueuesController
  .$inject = ['myService']

angular
  .module('QueuesApp',['globalApp'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('QueuesController', QueuesController)

