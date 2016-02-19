CurrentStatService = ($resource) ->
  {
    freeRooms : $resource('/resources/wards/free.json')
    dischargedSoon : $resource('/resources/admits/out_soon.json')
    admittedToday :$resource('/resources/admits/today.json')
  }

CurrentStatService
  .$inject = ['$resource']

angular.module('app').factory('CurrentStatService', CurrentStatService)