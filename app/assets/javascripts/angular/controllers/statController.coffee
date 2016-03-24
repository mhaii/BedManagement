statController = ($scope, sessionService, statService) ->
  @session    = sessionService
  @queryDate  = statService.queryDate

  @dateOptions = {
    maxDate:      new Date()
    startingDay:  1
    dateDisabled: null
  }

  updateStat = =>
    statService.inOutRate.get().$promise.then (data)=>
      sessionService.inOutRate = data
      @inOutRate = {
        "type"      : "AreaChart"
        "displayed" : false
        "data"      : {
          "rows"  : []
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
      @inOutRate.data.rows.push({"c": [{"v": i + " O'Clock"}, {"v": @session.inOutRate.startDischargeProcess[i]}, {"v": @session.inOutRate.endOfDischargedProcess[i]}, {"v": @session.inOutRate.newPatientAdmitted[i]}]}) for i in [0...23]

    statService.checkOut.query().$promise.then (data)=>
      sessionService.checkOut = data
      @checkOut = {
        "type"      : "ColumnChart"
        "data"      : {
          "rows"  : []
          "cols"  : [
            { "id": "step"    , "type": "string", "label": "Step Number" }
            { "id": "duration", "type": "number", "label": "Average duration of each process (minutes)" }
          ]
        }
      }
      @checkOut.data.rows.push({"c": [{"v": x.step}, {"v": x.average_duration}]}) for x in data

  updateStat()
  @session.websocket.bind 'check_out', (steps)->
    updateStat()

statController.$inject = ['$scope', 'sessionService', 'statService']

angular.module('app').controller('statController', statController)