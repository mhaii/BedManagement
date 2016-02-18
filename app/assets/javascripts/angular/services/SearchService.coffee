searchService = ($resource)->
  $resource('/resources/admits/:id.json',{id:'@id'})

searchService
  .$inject = ['$resource']

angular.module('app').factory('searchService',searchService)