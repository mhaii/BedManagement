statService = ($resource) ->
  {
    checkOut :  $resource('/resources/statistics/check_out.json')
    inOutRate:  $resource('/resources/statistics/in_out_rate.json')
  }

statService.$inject = ['$resource']

angular.module('app').factory('statService', statService)