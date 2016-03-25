statService = ($resource) ->
  {
    queryDate:  {queryFrom: new Date(), queryTil: new Date()}
    checkOut :  $resource('/resources/statistics/check_out.json?from=:from&to=:to')
    inOutRate:  $resource('/resources/statistics/in_out_rate.json?from=:from&to=:to')

    checkOutForm  : {
      "type"      : "ColumnChart"
      "data"      : {
        "cols"  : [
          { "id": "step"    , "type": "string", "label": "Step Number" }
          { "id": "duration", "type": "number", "label": "Average duration of each process (minutes)" }
        ]
      }
    }

    inOutRateForm : {
      "type"      : "AreaChart"
      "displayed" : false
      "data"      : {
        "cols"  : [
          { "id": "time",     "label": "Time",   "type": "string", "p": {} }
          { "id": "startDC",  "label": "Start Discharge Process",  "type": "number", "p": {} }
          { "id": "endDC",    "label": "End of Discharge Process",  "type": "number", "p": {} }
          { "id": "new",      "label": "New patient admitted",  "type": "number", "p": {} }
        ]
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
  }

statService.$inject = ['$resource']

angular.module('app').factory('statService', statService)