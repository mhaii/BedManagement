searchService = ($resource)->
  $resource('/api/patients/:id/check',{id:'@id'})

searchService
  .$inject = ['$resource']

angular.module('app').factory('searchService',searchService)