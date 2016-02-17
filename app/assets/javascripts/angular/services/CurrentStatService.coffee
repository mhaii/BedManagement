CurrentStatService = ($resource) ->
  {
    freeRooms : $resource('ward-room')
    dischargedSoon : $resource('admits')
    admittedToday :$resource('admits')
  }

CurrentStatService
  .$inject = ['$resource']

angular.module('app').factory('CurrentStatService', CurrentStatService)