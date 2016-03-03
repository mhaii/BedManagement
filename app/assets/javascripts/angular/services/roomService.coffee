roomService = ($resource) ->
  {
    room: $resource('/resources/room/:id.json', {id: '@id'}, {'update': {method: 'PUT'}})
  }

roomService
  .$inject = ['$resource']

angular.module('app').factory('roomService', roomService)