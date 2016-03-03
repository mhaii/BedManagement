roomService = ($resource) ->
  {
    room: $resource('/resources/rooms/:id.json', {id: '@id'}, {'update': {method: 'PUT'}})
  }

roomService
  .$inject = ['$resource']

angular.module('app').factory('roomService', roomService)