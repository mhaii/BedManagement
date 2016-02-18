angular.module('app').run ($rootScope,$state) ->
  $rootScope.getClass = (path)->
    $state.current.name
