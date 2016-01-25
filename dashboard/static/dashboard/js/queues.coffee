getData = ($http)->
  $http.get(static_url+'dashboard/SampleJson/queues.json')

QueuesController = (getData)->
  getData.success (data)->
    console.log(data)
    return
  return

QueuesController
  .$inject = ['getData']

angular
  .module('QueuesApp',[])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('QueuesController', QueuesController)
  .factory('getData', getData)

