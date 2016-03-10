statController = ($scope, sessionService) ->
  $scope.session = sessionService
  $scope.inOutRate = {
    "type"      : "AreaChart"
    "displayed" : false
    "data"      : {
      "cols"  : [
        { "id": "time",     "label": "Time",   "type": "string", "p": {} }
        { "id": "startDC",  "label": "Start Discharge Process",  "type": "number", "p": {} }
        { "id": "endDC",    "label": "End of Discharge Process",  "type": "number", "p": {} }
        { "id": "new",      "label": "New patient admitted",  "type": "number", "p": {} }
      ]
      "rows"  : []
    }
    "options"   : {
      "fill"      : 20,
      "displayExactValues": true,
      "vAxis"     : {
        "title"     : "Amount"
        "gridlines" : {
          "count"     : 10
        }
      }
      "hAxis"     : {
        "title"     : "Time"
        "gridlines" : {
          "count"     : 23
        }
      }
    }
    "formatters"  : {}
    "view"        : {}
  }
  console.log $scope.session.inOutRate
  $scope.inOutRate.data.rows.push({"c": [{"v": i + " O'Clock"}, {"v": $scope.session.inOutRate.startDischargeProcess[i]}, {"v": $scope.session.inOutRate.endOfDischargedProcess[i]}, {"v": $scope.session.inOutRate.newPatientAdmitted[i]}]}) for i in [0...23]
  console.log $scope.inOutRate

statController.$inject = ['$scope', 'sessionService']

angular.module('app').controller('statController', statController)