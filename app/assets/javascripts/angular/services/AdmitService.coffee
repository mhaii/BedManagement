admitService = ($resource) ->
  {
    admit   : $resource('/resources/admits/:id.json', { id:'@id' }, { 'update': { method: 'PUT' }})
    edd     : $resource('/resources/admits/out_soon.json')
    in_icu  : $resource('/resources/admits/in_icu.json')
    today   : $resource('/resources/admits/today.json')
  }

admitService
  .$inject = ['$resource']

angular.module('app').factory('admitService', admitService)