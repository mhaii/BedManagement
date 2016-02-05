CurrentStatisticsController = ($http, CurrentStatisticsService) ->
  vm = @
  vm.wards = CurrentStatisticsService.freeRooms.query()
  vm.dcSoon = CurrentStatisticsService.dischargedSoon.query()
  vm.admitTd = CurrentStatisticsService.admittedToday.query()
  return


CurrentStatisticsService = ($resource, djangoUrl) ->
  vm = @
  vm.freeRooms = $resource(djangoUrl.reverse('ward-free-count'))
  vm.dischargedSoon = $resource(djangoUrl.reverse('admit-discharged-soon'))
  vm.admittedToday = $resource(djangoUrl.reverse('admit-today'))
  vm

###############################################################################

CurrentStatisticsController
  .$inject = ['$http', 'CurrentStatisticsService']

CurrentStatisticsService
  .$inject = ['$resource', 'djangoUrl']

angular
  .module('CurrentStatistics',['ng.django.urls','ngResource'])
  .config ($interpolateProvider) ->
    $interpolateProvider.startSymbol('{$')
    $interpolateProvider.endSymbol('$}')
    return
  .controller('CurrentStatisticsController', CurrentStatisticsController)
  .factory('CurrentStatisticsService', CurrentStatisticsService)

###############################################################################
# Manual bootstrap, due to multiple NgApp in same html file

angular.element(document).ready ->
  angular.bootstrap $('#CurrentStatistics'), ['CurrentStatistics']