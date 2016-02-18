searchService = ($resource)->
  $resource('/resources/patients/:id.json',{id:'@id'})

searchService
  .$inject = ['$resource']

angular.module('app').factory('searchService',searchService)