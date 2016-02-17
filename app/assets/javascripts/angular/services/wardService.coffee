wardService = ($resource)->
  $resource('ward-with-rooms')

wardService
  .$inject = ['$resource']

angular.module('app').factory('wardService', wardService)