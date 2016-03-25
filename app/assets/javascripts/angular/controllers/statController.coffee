statController = ($scope, sessionService, statService) ->
  @session    = sessionService
  @queryDate  = statService.queryDate

  @inOutRate  = statService.inOutRateForm
  @checkOut   = statService.checkOutForm

  @refresh = => @session.updateStats()

  @dateOptions = {
    maxDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  return

statController.$inject = ['$scope', 'sessionService', 'statService']

angular.module('app').controller('statController', statController)