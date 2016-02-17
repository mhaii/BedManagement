CurrentStatService = ($resource) ->
  {
    freeRooms : $resource()
    dischargedSoon : $resource()
    admittedToday :$resource()
  }

CurrentStatService
  .$inject = ['$resource']

angular.module('myModule').factory('CurrentStatService', CurrentStatService)