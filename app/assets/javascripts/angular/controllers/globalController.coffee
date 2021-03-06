globalController = ($rootScope, $scope, $state, $translate, sessionService) ->
  @session = sessionService
  ############### Methods concerning translation ##############
  $scope.changeLanguage = (lang) ->
    $translate.use(lang)

  $scope.getLanguage = ->
    $translate.use()

  ########## Listener for authentication validation ###########
  cork = false
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)=>
    checkAuthenticity = ()=>
      if toState.data.access.indexOf(@session.currentUser.role) == -1 or fromState is ''
        switch @session.currentUser.role
          when 'cashier'
            $state.go('check-out')
          when 'nurseAssistance', 'nurse'
            $state.go('status')
          when 'admission', 'administrator'
            $state.go('home')
          when 'executive'
            $state.go('statistic')
      else
        $state.go toState, toParams

    # stop if not fetched current user yet
    if cork = !cork
      event.preventDefault()
      if !@session.user.$resolved
        @session.user.$promise.then checkAuthenticity
      else
        checkAuthenticity()


globalController.$inject = ['$rootScope', '$scope', '$state', '$translate', 'sessionService']

angular.module('app').controller('globalController', globalController)