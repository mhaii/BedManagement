wardService = ($resource)->
  {
    all   : $resource('/resources/wards/rooms.json')
    free  : $resource('/resources/wards/free.json')
  }

wardService.$inject = ['$resource']

angular.module('app').factory('wardService', wardService)