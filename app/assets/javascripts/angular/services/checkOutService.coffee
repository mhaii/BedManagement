checkOutService = ($resource) ->
  {
    list    : $resource('/resources/admits/check_out.json')
    start   : $resource('/resources/check_out/:id/start.json', {id:'@id'}, {'update': { method: 'PUT' }})
    stop    : $resource('/resources/check_out/:id/stop.json' , {id:'@id'}, {'update': { method: 'PUT' }})
    reset   : $resource('/resources/check_out/:id/reset.json', {id:'@id'})
  }

checkOutService.$inject = ['$resource']

angular.module('app').factory('checkOutService', checkOutService)