globalController = ($resource, $rootScope, $scope, $translate, $state, $location) ->
  user = {}
  redirect = (data, toState)->
    user = data
    if toState.data.access.indexOf(user.role) > 0
      $state.go(toState.name)
    else
      switch
        when user.role is 'cashier' then $state.go('check-out')
        when user.role is 'nurseAssistance' or user.role is 'nurse' then $state.go('status')
        when user.role is 'admission' or user.role is 'administrator' or user.role is 'op' then $state.go('home')
    return

  $scope.changeLanguage = (lang) ->
    $translate.use(lang)

  $scope.getLanguage = ->
    $translate.use()

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)->
    if fromState.name is ''
      event.preventDefault()
      $resource('/current_user.json').get().$promise.then((data)->
        fromState.name = 'init'
        redirect(data, toState)
      )
    else
      event.preventDefault() if toState.data.access.indexOf(user.role) < 0


globalController
  .$inject = ['$resource', '$rootScope', '$scope', '$translate', '$state', '$location']

angular.module('app').controller('globalController', globalController)