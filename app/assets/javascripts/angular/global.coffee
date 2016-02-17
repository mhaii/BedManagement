angular.module('app').run ($rootScope,$state)->
  $rootScope.getClass = (path)->
    if $state.current.name is path
      return "active"
    else
      return ""
