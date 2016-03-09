userService = ($resource) ->
  {
    user        : $resource('/resources/users.json')
    currentUser : $resource('/sessions.json')
  }

userService.$inject = ['$resource']

angular.module('app').factory('userService', userService)