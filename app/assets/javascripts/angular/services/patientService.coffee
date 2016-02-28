patientService = ($resource)->
  {
    admit:  null
    room:   null
    ward:   null

    patient : $resource('/resources/patients/:id.json', {id:'@id'})
    patients: $resource('/resources/patients.json')
  }

patientService
  .$inject = ['$resource']

angular.module("app").factory('patientService', patientService)