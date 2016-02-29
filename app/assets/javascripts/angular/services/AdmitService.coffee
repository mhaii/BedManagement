admitService = ($resource) ->
  {
    admit   : $resource('/resources/admits/:id.json', { id:'@id' }, { 'update': { method: 'PUT' }})
    admits  : $resource('/resources/admits.json')
    edd     : $resource('/resources/admits/out_soon.json')
    in_icu  : $resource('/resources/admits/in_icu.json')
    queue   : $resource('/resources/admits/queue.json')
    today   : $resource('/resources/admits/today.json')

    websocket : new WebSocketRails(location.host + '/websocket').subscribe('admits')
  }

admitService
  .$inject = ['$resource']

angular.module('app').factory('admitService', admitService)