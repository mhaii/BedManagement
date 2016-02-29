patientService = ($resource)->
  {
    patient : $resource('/resources/patients/:id.json', {id:'@id'})
    patients: $resource('/resources/patients.json')
  }

patientService
  .$inject = ['$resource']

angular.module("app").factory('patientService', patientService)