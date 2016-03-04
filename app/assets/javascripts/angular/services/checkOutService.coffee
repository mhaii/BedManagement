checkOutService = ($resource) ->
  {
    list    : $resource('/resources/admits/check_out_list.json')
    start   : $resource('/resources/check_out/start.json')
    stop    : $resource('/resources/check_out/:id/stop.json', { id:'@id' }, { 'update': { method: 'PUT' }})
    reset   : $resource('/resources/check_out/:id/reset.json')
  }

checkOutService
  .$inject = ['$resource']

angular.module('app').factory('checkOutService', checkOutService)