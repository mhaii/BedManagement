currentStatisticsCtrl = ($http, CurrentStatisticsService) ->
  vm = @
  vm.wards = CurrentStatService.freeRooms.query()
  vm.dcSoon = CurrentStatService.dischargedSoon.query()
  vm.admitTd = CurrentStatService.admittedToday.query()
  return

currentStatisticsCtrl
  .$inject = ['$http', 'CurrentStatService']

angular
  .module('myModule')
  .controller('currentStatisticsCtrl', currentStatisticsCtrl)