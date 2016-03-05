globalController = ($rootScope, $scope, $state, $translate, sessionService) ->
  ############### Methods concerning translation ##############
  $scope.changeLanguage = (lang) ->
    $translate.use(lang)

  $scope.getLanguage = ->
    $translate.use()

  ########## Listener for authentication validation ###########
  cork = false
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)->
    checkAuthenticity = ()->
      console.log toState.data.access.indexOf(sessionService.currentUser.role)
      console.log toState, toParams, fromState, fromParams
      if toState.data.access.indexOf(sessionService.currentUser.role) == -1 or fromState is ''
        switch sessionService.currentUser.role
          when 'cashier'
            $state.go('check-out')
          when 'nurseAssistance', 'nurse'
            $state.go('status')
          when 'admission', 'op'
            $state.go('home')
          when 'administrator'
            $state.go('statistic')
      else
        $state.go toState, toParams

    # stop if not fetched current user yet
    if cork = !cork
      event.preventDefault()
      if !sessionService.currentUser.$resolved
        sessionService.currentUser.$promise.then checkAuthenticity
      else
        checkAuthenticity()

  $rootScope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams)->
    console.log(fromState, fromParams)
    console.log(unfoundState.to)
    console.log(unfoundState.toParams)
    console.log(unfoundState.options)



globalController.$inject = ['$rootScope', '$scope', '$state', '$translate', 'sessionService']

angular.module('app').controller('globalController', globalController)