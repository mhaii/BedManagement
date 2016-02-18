wardService = ($resource)->
  $resource('resources/wards/rooms')

wardService
  .$inject = ['$resource']

angular.module('app').factory('wardService', wardService)