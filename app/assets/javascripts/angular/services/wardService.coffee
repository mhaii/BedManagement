wardService = ($resource)->
  $resource('resources/wards/rooms.json')

wardService
  .$inject = ['$resource']

angular.module('app').factory('wardService', wardService)