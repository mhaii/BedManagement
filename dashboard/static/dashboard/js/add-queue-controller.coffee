addQueuesCtrl = ()->


angular
  .module('addQueueApp',['ng.django.urls','ngResource'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
  .controller('addQueuesCtrl', addQueuesCtrl)