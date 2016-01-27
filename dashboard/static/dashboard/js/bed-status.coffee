BedStatusController = ($filter) ->
  return

angular
  .module('MyApp', [])
  .config($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('BedStatusController', BedStatusController)