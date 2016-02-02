addQueuesCtrl = ()->
  vm = @
  vm.search = (hnNumber)->
    console.log(hnNunber)
    return
  return

angular
  .module('addQueueApp',['ng.django.urls','ngResource'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
  .controller('addQueuesCtrl', addQueuesCtrl)