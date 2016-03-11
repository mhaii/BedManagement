doctorService = ($resource) ->
  {
    all    : $resource('/resources/doctors.json')
  }

doctorService.$inject = ['$resource']

angular.module('app').factory('doctorService', doctorService)