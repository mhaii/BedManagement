bedStatusController = ()->
  bedStatus = $http.get('static_url/dashboard/SampleJson/bedStatusAll.json').success (data)->


angular
  .module('MyApp',[])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('bedStatusController', bedStatusController)