patientService = ($resource)->
  [@admit, @room, @ward] = [null, null, null]
  @patient = $resource('/resources/patients/:id.json', {id:'@id'})
  @

patientService
  .$inject = ['$resource']

angular.module("app").factory('patientService', patientService)